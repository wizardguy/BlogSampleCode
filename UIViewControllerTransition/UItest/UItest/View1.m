//
//  View1.m
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "View1.h"

@implementation View1

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}


- (IBAction)hide:(id)sender
{
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(view1Protocol)]) {
        [self.delegate hideView1];
    }
}

@end
