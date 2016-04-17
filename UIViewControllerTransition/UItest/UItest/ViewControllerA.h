//
//  ViewControllerA.h
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewControllerA : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (strong, atomic) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
