//
//  MyPresenter.h
//  VIPERTest
//
//  Created by Dennis on 5/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJBasePresenter.h"
#import "XJBaseInteractor.h"

#define MY_KEY_ADINDEX      @"adindex"
#define MY_ID_ADINDEX       @"myEntityList"
#define MY_ID_AD            @"myEntity"

@interface MyPresenter : XJBasePresenter

- (void)loadData;

@end
