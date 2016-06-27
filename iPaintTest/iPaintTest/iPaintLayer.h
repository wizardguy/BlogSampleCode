//
//  iPaintLayer.h
//  iPaintTest
//
//  Created by Dennis on 24/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>


@interface iPaintLayer : CALayer

@property (assign, readwrite) BOOL usingScale;
@property (assign, readwrite) BOOL returnsNilActionForContentKey;
@property (assign, readwrite) BOOL flatteringPath;
@property (assign, readwrite) BOOL showingDirtyRects;
@property (assign, readwrite) BOOL drawingDirtyRects;
@property (assign, readwrite) BOOL drawingAsync;

@property (strong, readwrite, nonatomic) UIBezierPath *path;


@property (strong, readwrite, atomic) UIColor *currentStrokeColor;
@property (assign, readwrite, atomic) float currentStrokeWidth;

@property (assign, readwrite, atomic) double drawTime;


- (void)beginPathAtPoint:(CGPoint)point;

- (void)addNextPoint:(CGPoint)point;

- (void)endPathAtPoint:(CGPoint)point;

- (void)clearContent;

//- (void)cancelPathAtPoint:(CGPoint)point;

@end
