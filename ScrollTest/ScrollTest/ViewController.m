//
//  ViewController.m
//  ScrollTest
//
//  Created by Dennis on 13/6/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, [UIScreen mainScreen].bounds.size.height);
    self.scrollView.delegate = self;
    
    self.scrollView.delaysContentTouches = self.switchDelays.on;
    
    self.scrollView.canCancelContentTouches = self.switchCanCancel.on;

    
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [leftSwipeGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.yellowView addGestureRecognizer:leftSwipeGesture];
    
    
    UISwipeGestureRecognizer *leftSwipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [leftSwipeGesture2 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.greenView addGestureRecognizer:leftSwipeGesture2];
    
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [rightSwipeGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.yellowView addGestureRecognizer:rightSwipeGesture];
    
    
    UISwipeGestureRecognizer *rightSwipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [rightSwipeGesture2 setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.greenView addGestureRecognizer:rightSwipeGesture2];
    
    
    
    UISwipeGestureRecognizer *otherSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [otherSwipe setDirection:UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown];
    
    [self.yellowView addGestureRecognizer:otherSwipe];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapBtn:(id)sender {
    self.note.text = @"Button tapped!";
}



- (IBAction)switchChange:(id)sender {
    self.scrollView.canCancelContentTouches = ((UISwitch *)sender).on;
}

- (IBAction)switchDelayChange:(id)sender {
    self.scrollView.delaysContentTouches = ((UISwitch *)sender).on;
}


- (void)handleSwipe:(UIGestureRecognizer *)sender
{
    UISwipeGestureRecognizerDirection direction=[(UISwipeGestureRecognizer*) sender direction];
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.note.text = @"Left!";
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            self.note.text = @"Right";
            break;
            
        default:
            self.note.text = @"Other direction!";
            break;
            
    }
}

@end
