//
//  ViewController.m
//  UItest
//
//  Created by Dennis on 16/7/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "MySegue.h"

@interface ViewController ()

@property (strong) View1 *view1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pushA"]) {
        NSLog(@"push by storyboard");
    }
    else if ([segue.identifier isEqualToString:@"pushB"]){
        NSLog(@"push by storyboard");
    }
    else if ([segue.identifier isEqualToString:@"showAv2"]){
        NSLog(@"push by code");
    }
}


- (IBAction)unwind:(UIStoryboardSegue*)unwindSegue
{
    UIViewController *vc = unwindSegue.sourceViewController;
    
    if ([vc isKindOfClass:[ViewControllerA class]]){
        self.label.text = ((ViewControllerA*)vc).name;
    }
    else {
        self.label.text = ((ViewControllerB*)vc).name;
    }
    
}


- (IBAction)presentAbyCustomSegue:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewControllerA *a = [story instantiateViewControllerWithIdentifier:@"vcA"];
    
    MySegue *segue = [[MySegue alloc] initWithIdentifier:@"mySegue" source:self destination:a];
    [segue perform];
}

- (IBAction)pushAByCode:(id)sender
{
    [self performSegueWithIdentifier:@"showAv2" sender:self];
}

- (void)hideView1
{
    [self.view1 removeFromSuperview];
}

- (IBAction)addView1:(id)sender
{
    if (!self.view1) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"View1" owner:nil options:nil];
        self.view1 = [array firstObject];
        self.view1.delegate = self;
        self.view1.frame = CGRectMake(50,100, 250, 100);
        self.view1.label.text = @"test view";
    }
    [self.view addSubview:self.view1];
}


- (IBAction)presentA:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewControllerA *a = [story instantiateViewControllerWithIdentifier:@"vcA"];
    
    [self presentViewController:a animated:YES completion:^(){
        a.view.backgroundColor = [UIColor purpleColor];
    }];
}

- (IBAction)showB:(id)sender
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    ViewControllerB *b = [story instantiateViewControllerWithIdentifier:@"vcB"];
    b.modalPresentationStyle = UIModalPresentationOverFullScreen;
    b.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self showDetailViewController:b sender:self];
}

@end
