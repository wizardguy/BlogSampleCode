//
//  MySegue.m
//  UItest
//
//  Created by Dennis on 28/3/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "MySegue.h"

@implementation MySegue

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    // You can add any other code to configure your segue here.
    return [super initWithIdentifier:identifier source:source destination:destination];
}


- (void)perform
{
    // Configure your transition animations here.
    // Here we just call presentViewController to simply the process.
    [[self sourceViewController] presentViewController:[self destinationViewController] animated:YES completion:^(){
        UIViewController *vc = [self destinationViewController];
        vc.view.backgroundColor = [UIColor purpleColor];
    }];
}

@end
