//
//  ViewController.m
//  UIView2
//
//  Created by Dennis on 14/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 360)];
    self.blueView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.blueView];
    self.blueView.hidden = YES;
    
}

-(void)viewDidLayoutSubviews
{
    float blueViewx = self.yellowView.frame.origin.x + self.yellowView.frame.size.width + 100;
    float blueViewy = self.yellowView.frame.origin.y;
    
    self.blueView.frame = CGRectMake(blueViewx, blueViewy, 360, 360);
    self.blueView.hidden = NO;
}

/*
- (void)viewDidAppear:(BOOL)animated
{
    float blueViewx = self.yellowView.frame.origin.x + self.yellowView.frame.size.width + 100;
    float blueViewy = self.yellowView.frame.origin.y;
    
    self.blueView.frame = CGRectMake(blueViewx, blueViewy, 360, 360);
    self.blueView.hidden = NO;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)fancyMode:(id)sender {
    if (self.s.on){
        [UIView animateWithDuration:1.0 animations:^{
            self.yellowView.frame = CGRectMake(self.yellowView.frame.origin.x, self.yellowView.frame.origin.y, (self.yellowView.frame.size.width - 10) / 2, self.yellowView.frame.size.height);
        }];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.blueView.frame = CGRectMake(self.yellowView.frame.origin.x + self.yellowView.frame.size.width + 10, self.yellowView.frame.origin.y, self.yellowView.frame.size.width, self.yellowView.frame.size.height);
        }];
        
    }
    else {
        [UIView animateWithDuration:1.0 animations:^{
            self.yellowView.frame = CGRectMake(self.yellowView.frame.origin.x, self.yellowView.frame.origin.y, self.yellowView.frame.size.width * 2 + 10, self.yellowView.frame.size.height);
        }];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.blueView.frame = CGRectMake(self.yellowView.frame.origin.x + self.yellowView.frame.size.width + 100, self.yellowView.frame.origin.y, self.blueView.frame.size.width * 2, self.blueView.frame.size.height);
        }];
    }
}


@end
