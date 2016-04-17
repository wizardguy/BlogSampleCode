//
//  ViewController.h
//  autolayoutTest
//
//  Created by Dennis on 11/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *blueViewConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewSpaceConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowViewConstraint;

@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;


@property (weak, nonatomic) IBOutlet UISwitch *s;
@end

