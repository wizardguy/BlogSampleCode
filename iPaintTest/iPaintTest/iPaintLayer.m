//
//  iPaintLayer.m
//  iPaintTest
//
//  Created by Dennis on 24/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "iPaintLayer.h"
#import <mach/mach_time.h>

@interface iPaintRecord : NSObject

@property (strong, readwrite) UIColor *strokeColor;
@property (strong, readwrite) UIBezierPath *path;
@property (assign, readwrite) NSUInteger numPoints;
@property (assign, readwrite) float strokeWidth;


- (instancetype) initWithPath:(UIBezierPath *)path
                        Color:(UIColor *)color
                        Width:(float)width;

- (void)beginPathAtPoint:(CGPoint)point;

- (void)updatePathLineWithPoint:(CGPoint)point;

@end

@implementation iPaintRecord

- (instancetype) initWithPath:(UIBezierPath *)path
                        Color:(UIColor *)color
                        Width:(float)width
{
    self = [super init];
    if (self) {
        _strokeColor = color;
        _strokeWidth = width;
        _path = path;
        _numPoints = 0;
    }
    return self;
}


- (void)beginPathAtPoint:(CGPoint)point
{
    [_path moveToPoint:point];
    _numPoints++;
}

- (void)updatePathLineWithPoint:(CGPoint)point
{
    [_path addLineToPoint:point];
    //NSValue *value = [NSValue value:&point withObjCType:@encode(struct CGPoint)];
    _numPoints++;
}

@end


const int kPaintLayerMaxPoints = 50;
const int kPaintLayerMaxPath = 5;

@interface iPaintLayer ()

@property (strong, readwrite) NSMutableArray<iPaintRecord*> *records;
@property (strong, readwrite) iPaintRecord *currentRecord;

@property (assign, readwrite) CGPoint currentPoint;
@property (assign, readwrite) CGPoint previousPoint;

@property (strong, readwrite) UIColor *debugColor;
@property (strong, readwrite) UIColor *bgColor;
@property (strong, readwrite) UIImage *flattenImage;

@end



@implementation iPaintLayer


- (instancetype)init
{
    self = [super init];
    if (self) {
        _usingScale = NO;
        _returnsNilActionForContentKey = NO;
        _flatteringPath = NO;
        _showingDirtyRects = NO;
        _drawingDirtyRects = NO;
        _drawingAsync = NO;
        
        _records = [[NSMutableArray alloc] init];
        _currentRecord = nil;
        
        _currentStrokeColor = [UIColor redColor];
        _currentStrokeWidth = 10.0;
        _drawTime = 0.0;
        
        _debugColor = [UIColor redColor];
        _bgColor = [UIColor whiteColor];
        _flattenImage = nil;
    }
    return self;
}


- (id<CAAction>)actionForKey:(NSString *)event
{
    if (_returnsNilActionForContentKey && [event isEqualToString:@"contents"]) {
        return nil;
    }
    return [super actionForKey:event];
}


- (void)drawInContext:(CGContextRef)ctx
{
    uint64_t drawStart  = mach_absolute_time();
    
    // If we have the flatten image, draw it first.
    if (self.flattenImage) {
        // Flip the image, due to the difference of coordinate system between UIKit and CoreGraphic.
        CGContextSaveGState(ctx);
        CGContextTranslateCTM(ctx, 0, self.flattenImage.size.height);
        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextDrawImage(ctx, self.bounds, self.flattenImage.CGImage);
        CGContextRestoreGState(ctx);
    }
    
    // Empty record, Clear the screen
    if (![self.records count]) {
        CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextFillRect(ctx, self.frame);
    }
    else {
        // Continue to draw the path
        for (iPaintRecord *record in self.records) {
            
            CGContextAddPath(ctx, record.path.CGPath);
            CGContextSetLineWidth(ctx, record.strokeWidth);
            CGContextSetStrokeColorWithColor(ctx, record.strokeColor.CGColor);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextStrokePath(ctx);
            
            // Change:
            // In WWDC session video, the speaker individually process the single point case.
            // As we update the point when end the path, there is no need to process
            // single point here.
            /*
            if (record.numPoints == 1) {
                CGContextSetFillColorWithColor(ctx, record.strokeColor.CGColor);
                CGContextFillEllipseInRect(ctx,
                                           CGRectMake(self.currentPoint.x - self.currentStrokeWidth * 0.5,
                                                      self.currentPoint.y - self.currentStrokeWidth * 0.5,
                                                      self.currentStrokeWidth, self.currentStrokeWidth));
            }*/
        }
    }
    
    if (self.showingDirtyRects) {
        CGRect clipRect = CGContextGetClipBoundingBox(ctx);
        clipRect = CGRectInset(clipRect, 0.5, 0.5);
        CGContextSetLineWidth(ctx, 1);
        CGContextSetStrokeColorWithColor(ctx, self.debugColor.CGColor);
        CGContextStrokeRect(ctx, clipRect);
    }
    
    uint64_t drawEnd = mach_absolute_time();
    [self recordPerformanceMetricsWithFrameStart:drawStart end:drawEnd];
}


- (void)beginPathAtPoint:(CGPoint)point
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    iPaintRecord *record = [[iPaintRecord alloc] initWithPath:path
                                                        Color:self.currentStrokeColor
                                                        Width:self.currentStrokeWidth];
    [record beginPathAtPoint:point];
    [self.records addObject:record];
    
    self.currentRecord = record;
    self.previousPoint = point;
    self.currentPoint = point;
    
    //[self setNeedsDisplay];
}


- (CGRect)calculateDirtyRect {
    CGFloat minX = fmin(self.previousPoint.x, self.currentPoint.x) - self.currentStrokeWidth * 0.5;
    CGFloat minY = fmin(self.previousPoint.y, self.currentPoint.y) - self.currentStrokeWidth * 0.5;
    CGFloat maxX = fmax(self.previousPoint.x, self.currentPoint.x) + self.currentStrokeWidth * 0.5;
    CGFloat maxY = fmax(self.previousPoint.y, self.currentPoint.y) + self.currentStrokeWidth * 0.5;
    
    CGRect dirtyRect = CGRectMake(minX, minY, (maxX - minX) * 2, (maxY - minY) * 2);
    return dirtyRect;
}

- (void)addNextPoint:(CGPoint)point
{
    self.previousPoint = self.currentPoint;
    self.currentPoint = point;
    
    /* flatten the path if it is too long */
    if (self.flatteringPath && (self.records.count > kPaintLayerMaxPath ||
                                self.currentRecord.numPoints > kPaintLayerMaxPoints)) {
        [self flattenPath];
        
        /* after flatten, clear all the records */
        [self.records removeAllObjects];
        
        /* begin a new one at current point */
        [self beginPathAtPoint:self.previousPoint];
        
        return;
    }
    
    /* add the ppint to our path */
    [self.currentRecord updatePathLineWithPoint:point];
    
    if (self.drawingDirtyRects) {
        /* calculate our dirty rect */
        [self setNeedsDisplayInRect:[self calculateDirtyRect]];
    }
    else {
        [self setNeedsDisplay];
    }
}


- (void)endPathAtPoint:(CGPoint)point
{
    self.previousPoint = self.currentPoint;
    self.currentPoint = point;
    
    [self.currentRecord updatePathLineWithPoint:point];

    self.currentRecord = nil;
    
    if (self.drawingDirtyRects) {
        /* calculate our dirty rect */
        [self setNeedsDisplayInRect:[self calculateDirtyRect]];
    }
    else {
        [self setNeedsDisplay];
        
    }
}


/*
- (void)cancelPathAtPoint:(CGPoint)point
{
    [self.aryPaths removeLastObject];
}
*/


- (void)clearContent
{
    [self.records removeAllObjects];
    self.flattenImage = nil;
    
    [self setNeedsDisplay];
}


/*
CGImageRef flip (CGImageRef im) {
    CGSize sz = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContextWithOptions(sz, YES, 0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, sz.width, sz.height), im);
    CGImageRef result = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    
    return result;
}
 */


- (void)flattenPath
{
    uint64_t start = mach_absolute_time();
    
    CGRect rect = self.bounds;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, self.contentsScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillRect(context, rect);
    [self renderInContext:context]; // Here, renderInContext: will call drawInContext:
    self.flattenImage = UIGraphicsGetImageFromCurrentImageContext();
    //UIImage *tempimg = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    // I intended to flip the image here, but it seens that
    // it costs too much to redraw the image twice.
    // So I move the flip into the drawInRect.
    //self.flattenImage = [UIImage imageWithCGImage:flip(tempimg.CGImage)];
    
    uint64_t end = mach_absolute_time();
    
    NSLog(@"%lf ms", MachTimeToMillisecs(end - start));
}


- (void)recordPerformanceMetricsWithFrameStart:(uint64_t)start end:(uint64_t)end
{
    self.drawTime = MachTimeToMillisecs(end - start);
}



double MachTimeToMillisecs(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer / (double)timebase.denom / 1e6;
}

@end
