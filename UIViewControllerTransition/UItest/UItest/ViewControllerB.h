//
//  ViewControllerB.h
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerB : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *back;

@property (strong, atomic) NSString *name;
@property (weak, nonatomic) IBOutlet UIButton *btnTransToA;

@end
