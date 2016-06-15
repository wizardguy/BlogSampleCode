//
//  ViewController.h
//  ScrollTest
//
//  Created by Dennis on 13/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"
#import "MyScrollView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MyView *yellowView;

@property (weak, nonatomic) IBOutlet MyScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet UIButton *button;

- (IBAction)tapBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UILabel *note;

@property (weak, nonatomic) IBOutlet UISwitch *switchCanCancel;

@property (weak, nonatomic) IBOutlet UISwitch *switchDelays;

@end

