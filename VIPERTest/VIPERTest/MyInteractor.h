//
//  MyInteractorDelegate.h
//  VIPERTest
//
//  Created by Dennis on 4/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "XJBaseInteractor.h"
#import "MyEntity.h"

@interface MyInteractor : XJBaseInteractor

- (instancetype)init;
- (void)requestItemsForKey:(NSString *)key identity:(NSString *)identity;
- (void)requestItemForKey:(NSString *)key rid:(NSNumber *)rid identity:(NSString *)identity;


@end
