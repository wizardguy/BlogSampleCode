//
//  View1.h
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol view1Protocol

- (void) hideView1;

@end


@interface View1 : UIView

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *btnHide;

@property (strong) id delegate;

- (id)initWithDelegate:(id)delegate;

@end


