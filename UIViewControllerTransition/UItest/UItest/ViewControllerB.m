//
//  ViewControllerB.m
//  UItest
//
//  Created by Dennis on 23/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewControllerB.h"
#import "ViewControllerA.h"
#import "ViewControllerC.h"

@interface ViewControllerB ()

@property (weak) ViewControllerA *a;
@property (weak) ViewControllerA *a2;

@property (weak) ViewControllerC *c;
@property (weak) ViewControllerC *c2;

@end

@implementation ViewControllerB


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.name = @"B";
    self.a = nil;
    self.a2 = nil;
    self.c = nil;
    self.c2 = nil;
    
}



- (IBAction)transToA:(id)sender
{
    if (self.a == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.a = [story instantiateViewControllerWithIdentifier:@"vcA"];
    }
    
    [self addChildViewController:self.a];
    self.a.view.frame = CGRectMake(100, 300, 150, 150);
    [self.view addSubview:self.a.view];
    [self.a didMoveToParentViewController:self];
}


- (IBAction)transFromAtoC:(id)sender
{
    if (self.a == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.a = [story instantiateViewControllerWithIdentifier:@"vcA"];
    }
    
    if (self.c == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.c = [story instantiateViewControllerWithIdentifier:@"vcC"];
    }
    
    [self.a willMoveToParentViewController:nil];
    [self addChildViewController:self.c];
   
    [self transitionFromViewController:self.a toViewController:self.c duration:0.25 options:0 animations:^(){
        self.c.view.frame = CGRectMake(100, 300, 150, 150);
    } completion:^(BOOL finished) {
        [self.a removeFromParentViewController];
        [self.a didMoveToParentViewController:self];
    }];
    
}


- (IBAction)addA2:(id)sender
{
    if (self.a2 == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        self.a2 = [story instantiateViewControllerWithIdentifier:@"vcA"];
    }
    
    [self addChildViewController:self.a2];
    self.a2.view.frame = CGRectMake(100, 500, 150, 150);
    [self.view addSubview:self.a2.view];
    [self.a2 didMoveToParentViewController:self];
    
}

- (IBAction)trans2Ato2C:(id)sender {
    [self transFromAtoC:nil];
    
    if (self.a2 == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        self.a2 = [story instantiateViewControllerWithIdentifier:@"vcA"];
    }
    
    if (self.c2 == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        self.c2 = [story instantiateViewControllerWithIdentifier:@"vcC"];
    }
    
    [self.a2 willMoveToParentViewController:nil];
    [self addChildViewController:self.c2];
    self.c2.view.frame = CGRectMake(100,500, 0, 0);
    
    [self transitionFromViewController:self.a2 toViewController:self.c2 duration:0.25 options:UIViewAnimationOptionTransitionCrossDissolve animations:^(){
        self.c2.view.frame = CGRectMake(100, 500, 150, 150);
    } completion:^(BOOL finished) {
        [self.a2 removeFromParentViewController];
        [self.a2 didMoveToParentViewController:self];
    }];
}


@end
