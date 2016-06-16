//
//  ViewController.h
//  ShadowTest
//
//  Created by Dennis on 15/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISwitch *sImageCorner;
@property (weak, nonatomic) IBOutlet UISwitch *sCorner;
@property (weak, nonatomic) IBOutlet UISwitch *sMask;
@property (weak, nonatomic) IBOutlet UISwitch *sClip;

@property (weak, nonatomic) IBOutlet UISwitch *sContent;
@property (weak, nonatomic) IBOutlet UISwitch *sSubView;
@property (weak, nonatomic) IBOutlet UISwitch *sAddScrollView;
@property (weak, nonatomic) IBOutlet UITextField *num;
@property (weak, nonatomic) IBOutlet UISwitch *sLayerShadow;

@property (weak, nonatomic) IBOutlet UISwitch *sSubViewShadow;
@property (weak, nonatomic) IBOutlet UISwitch *sResterize;

@property (weak, nonatomic) IBOutlet UILabel *fps;


@property (weak, nonatomic) IBOutlet UILabel *delay;

@end

