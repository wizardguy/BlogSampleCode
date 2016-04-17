//
//  ViewController.m
//  autolayoutTest
//
//  Created by Dennis on 11/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self updateConstraintsForMode:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeMode:(id)sender {
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:1.0 animations:^{
        [self updateConstraintsForMode:self.s.on];
        [self.view layoutIfNeeded];
    }];
}


- (void)updateConstraintsForMode:(BOOL)mode
{
    if (mode) {
        self.viewSpaceConstraint.constant = 8.0;
        self.yellowViewConstraint.priority = UILayoutPriorityDefaultLow;
        self.blueViewConstraint.priority = UILayoutPriorityDefaultHigh;
    }
    else {
        //self.viewSpaceConstraint.priority = UILayoutPriorityDefaultHigh;
        self.viewSpaceConstraint.constant = 100.0;
        self.yellowViewConstraint.constant = 0.0;
        self.yellowViewConstraint.priority = UILayoutPriorityDefaultHigh;
        self.blueViewConstraint.priority = UILayoutPriorityDefaultLow;
    }
}

@end
