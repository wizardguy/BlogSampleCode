//
//  ViewController.h
//  UItest
//
//  Created by Dennis on 16/7/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View1.h"

@interface ViewController : UIViewController <view1Protocol>

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

