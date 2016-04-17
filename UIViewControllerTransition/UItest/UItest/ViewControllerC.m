//
//  ViewControllerC.m
//  UItest
//
//  Created by Dennis on 24/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewControllerC.h"
#import "ViewControllerA.h"

@interface ViewControllerC ()

@property (strong) ViewControllerA *a;

@end

@implementation ViewControllerC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated
{
    self.nameLabel.text = [NSString stringWithFormat:@"This is %@", NSStringFromClass([self class])];
    self.label.text = [NSString stringWithFormat:@"from:%@", NSStringFromClass([self.presentingViewController class])];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack:(id)sender
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (IBAction)newA:(id)sender
{
    if (self.a == nil) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        self.a = [story instantiateViewControllerWithIdentifier:@"vcA"];
    }
    
    /*
    [self presentViewController:self.a animated:YES completion:^(){
        self.a.view.frame = CGRectMake(100,100, 200, 300);
    }];
     */
    /*
    [self showViewController:self.a sender:nil];
     */
    [self showDetailViewController:self.a sender:nil];
}

@end
