//
//  XJBaseViewController.h
//  VIPERTest
//
//  Created by Dennis on 5/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XJBasePresenter.h"

@interface XJBaseViewController : UIViewController

@property (strong, readwrite) __kindof XJBasePresenter *eventHandler;


@end
