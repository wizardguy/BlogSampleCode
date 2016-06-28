//
//  iPaintView.h
//  iPaintTest
//
//  Created by Dennis on 24/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPaintLayer.h"

typedef NS_ENUM(NSUInteger, STROKETYPE) {
    BRUSH = 0,
    ERASER = 1,
};

@interface iPaintView : UIView

@property (weak, readwrite, nonatomic) id delegate;
@property (strong, readwrite, nonatomic) iPaintLayer *paintLayer;


- (void)setUp;

- (void)setColor:(UIColor *)color;
- (void)setWidth:(float)width;

- (void)setStrokeType:(STROKETYPE)type;

- (void)clearAll;

- (void)setScale:(BOOL)flag;
- (void)setNilAction:(BOOL)flag;
- (void)setShowUpdatedRects:(BOOL)flag;
- (void)setDrawDirtyRects:(BOOL)flag;
- (void)setFlattenImage:(BOOL)flag;
- (void)setAsyncDraw:(BOOL)flag;

- (double)getAverageTime;

@end
