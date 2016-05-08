//
//  XJBasePresenter.m
//  VIPERTest
//
//  Created by Dennis on 5/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "XJBasePresenter.h"


@implementation XJBasePresenter


- (instancetype)initWithInteractor:(__kindof XJBaseInteractor *)interactor
{
    if (interactor == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _interacter = interactor;
        interactor.presenter = self;
    }
    return self;
}

- (void)interactor:(__kindof XJBaseInteractor *)interactor acctionDidFailWithError:(NSError *)error key:(NSString *)key identifier:(NSString *)identifier
{
    return;
}

- (void)interactor:(__kindof XJBaseInteractor *)interactor actionDidSuccessWithData:(id)data key:(NSString *)key identifier:(NSString *)identifier
{
    return;
}

@end
