//
//  iPaintView.m
//  iPaintTest
//
//  Created by Dennis on 24/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "iPaintView.h"
#import "ViewController.h"

@implementation iPaintView


- (void)setUp
{
    _paintLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}



- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _paintLayer = [[iPaintLayer alloc] init];
        [self.layer addSublayer:_paintLayer];
    }
    return self;
}


- (void)setColor:(UIColor *)color
{
    self.paintLayer.currentStrokeColor = color;
}


- (void)setWidth:(float)width
{
    self.paintLayer.currentStrokeWidth = width;
}



- (void)clearAll
{
    [self.paintLayer clearContent];
}


- (void)setScale:(BOOL)flag
{
    self.paintLayer.contentsScale = flag ? [UIScreen mainScreen].scale : 1.0;
    self.paintLayer.usingScale = flag;
}

- (void)setNilAction:(BOOL)flag
{
    self.paintLayer.returnsNilActionForContentKey = flag;
}


- (void)setShowUpdatedRects:(BOOL)flag
{
    self.paintLayer.showingDirtyRects = flag;
}


- (void)setDrawDirtyRects:(BOOL)flag
{
    self.paintLayer.drawingDirtyRects = flag;
}


- (void)setFlattenImage:(BOOL)flag
{
    self.paintLayer.flatteringPath = flag;
}


- (double)getAverageTime
{
    return self.paintLayer.drawTime;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.paintLayer beginPathAtPoint:point];
}



- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.paintLayer addNextPoint:point];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.paintLayer endPathAtPoint:point];
}

/*
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.paintLayer cancelPathAtPoint:point];
}
*/
@end
