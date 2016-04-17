//
//  ViewController.m
//  UIView3
//
//  Created by Dennis on 15/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)spaceChanged:(id)sender {
    static float old = 0.0;
    float value = self.slider.value;
    float delta = value - old;
    old = value;
    
    [self updateMainViewWithDelta:delta];
    [self updateOtherView:self.yellowView WithDelta:delta];
    [self updateOtherView:self.blueView WithDelta:delta];
    [self updateOtherView:self.greenView WithDelta:delta];
    
}

- (void) updateMainViewWithDelta:(float)delta
{
    self.redView.frame = CGRectMake(self.redView.frame.origin.x, self.redView.frame.origin.y, self.redView.frame.size.width, self.redView.frame.size.height + delta);
}

- (void) updateOtherView:(UIView *)view WithDelta:(float)delta
{
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + delta, view.frame.size.width, view.frame.size.height);
}

//self.redViewbottomConstraint.constant -= delta;


@end
