//
//  XJBasePresenter.h
//  VIPERTest
//
//  Created by Dennis on 5/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJBaseInteractor.h"

@class XJBaseViewController;


@protocol XJBasePresenterProtocol <NSObject>

@end


@interface XJBasePresenter : NSObject <XJBaseInteractorDelegateProtocol>

@property (strong, readwrite) __kindof XJBaseInteractor *interacter;
@property (weak, readwrite) __kindof XJBaseViewController *output;

- (instancetype) initWithInteractor:(__kindof XJBaseInteractor*)interactor  NS_DESIGNATED_INITIALIZER;

@end
