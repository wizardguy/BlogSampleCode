//
//  ViewController.h
//  iPaintTest
//
//  Created by Dennis on 23/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iPaintView.h"



@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnRed;
@property (weak, nonatomic) IBOutlet UIButton *btnYellow;
@property (weak, nonatomic) IBOutlet UIButton *btnBlue;
@property (weak, nonatomic) IBOutlet UIButton *btnGreen;
@property (weak, nonatomic) IBOutlet UIView *preView;
@property (weak, nonatomic) IBOutlet UISlider *slideSize;
@property (weak, nonatomic) IBOutlet UISegmentedControl *strokeType;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;

@property (weak, nonatomic) IBOutlet UISwitch *sScale;
@property (weak, nonatomic) IBOutlet UISwitch *sAction;
@property (weak, nonatomic) IBOutlet UISwitch *sFlatter;
@property (weak, nonatomic) IBOutlet UISwitch *sShowRects;
@property (weak, nonatomic) IBOutlet UISwitch *sDirtyRect;
@property (weak, nonatomic) IBOutlet UISwitch *sDrawAsync;

@property (weak, nonatomic) IBOutlet UILabel *txtFPS;
@property (weak, nonatomic) IBOutlet UILabel *txtDrawTime;

@property (weak, nonatomic) IBOutlet iPaintView *paintView;

@property (strong, readwrite, nonatomic) UIColor *currentColor;
@property (assign, readwrite, nonatomic) float currentSize;


@end

