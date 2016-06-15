//
//  MyScrollView.m
//  ScrollTest
//
//  Created by Dennis on 13/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "MyScrollView.h"
#import "MyView.h"

@implementation MyScrollView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setUp
{
    self.canCancelContentTouches = YES;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    return YES;
}


- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view
{
    if (view.tag == 1) {
        return NO;
    }
    else {
        return YES;
    }
}


@end
