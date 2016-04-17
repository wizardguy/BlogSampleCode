//
//  ViewController.m
//  UIView4
//
//  Created by Dennis on 15/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changed:(id)sender {
    NSLog(@"value = %f", self.slider.value);
    self.width.constant = self.slider.value;
    self.height.constant = self.slider.value;
    
}

@end
