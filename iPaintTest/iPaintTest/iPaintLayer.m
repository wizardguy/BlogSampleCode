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


const int kPaintLayerMaxPoints = 100;
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



CGImageRef flip (CGImageRef im) {
    CGSize sz = CGSizeMake(CGImageGetWidth(im), CGImageGetHeight(im));
    UIGraphicsBeginImageContextWithOptions(sz, NO, 0);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, sz.width, sz.height), im);
    CGImageRef result = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return result;
}




- (void)drawInContext:(CGContextRef)ctx
{
    uint64_t drawStart  = mach_absolute_time();
    
    CGContextSaveGState(ctx);
    
    // Empty record, Clear the screen
    if (![self.records count]) {
        CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
        CGContextFillRect(ctx, self.frame);
    }
    else {
        
        // If we have the flatten image, draw it first.
        if (self.flattenImage) {
            CGContextDrawImage(ctx, self.bounds, self.flattenImage.CGImage);
        }
        
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
    
    CGContextRestoreGState(ctx);
    
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
    
    /* add the ppint to our path */
    [self.currentRecord updatePathLineWithPoint:point];
    
    /* flatten the path if it is too long */
    if (self.flatteringPath && (self.records.count > kPaintLayerMaxPath ||
                                self.currentRecord.numPoints > kPaintLayerMaxPoints)) {
        [self flattenPath];
        return;
    }
    
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


- (void)flattenPath
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, self.contentsScale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextFillRect(context, self.bounds);
    [self renderInContext:context]; // Here, renderInContext: will call drawInContext:
    UIImage *tempimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // Flip the image, due to the difference of coordinate system between UIKit and CoreGraphic.
    self.flattenImage = [UIImage imageWithCGImage:flip(tempimg.CGImage)];
    
    /* after flatten, clear all the records */
    [self.records removeAllObjects];
    /* begin a new one at current point */
    [self beginPathAtPoint:self.previousPoint];
    [self addNextPoint:self.currentPoint];
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
