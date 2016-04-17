//
//  ViewControllerA.m
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewControllerA.h"

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.name = @"A";
}


- (void) viewWillAppear:(BOOL)animated
{
    self.nameLabel.text = [NSString stringWithFormat:@"This is %@", NSStringFromClass([self class])];
    self.label.text = [NSString stringWithFormat:@"from:%@", NSStringFromClass([self.presentingViewController class])];
}

- (IBAction)backToB:(id)sender
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
















@end
