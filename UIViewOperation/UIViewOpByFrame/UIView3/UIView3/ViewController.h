//
//  ViewController.h
//  UIView3
//
//  Created by Dennis on 15/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *yellowView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewbottomConstraint;

@property (weak, nonatomic) IBOutlet UISlider *slider;


@end

