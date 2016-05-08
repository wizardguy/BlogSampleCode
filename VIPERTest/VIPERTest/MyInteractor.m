//
//  MyInteractor.m
//  VIPERTest
//
//  Created by Dennis on 4/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "MyInteractor.h"
#import "XJNetworkAdapter.h"
#import "XJGlobalDef.h"
#import "MyEntity.h"


@implementation MyInteractor


- (instancetype)init
{
    XJNetworkAdapter *adapter = [[XJNetworkAdapter alloc] initWithDefaultSetting];
    self = [super initWithAdapter:adapter];
    return self;
}


- (void)requestItemsForKey:(NSString *)key identity:(NSString *)identity
{
    XJAsyncReadData(self, key, nil, identity);
}


- (void)requestItemForKey:(NSString *)key rid:(NSNumber *)rid identity:(NSString *)identity
{
    NSString *finalKey = [NSString stringWithFormat:@"%@/%d/", key, [rid intValue]];
    XJAsyncReadData(self, finalKey, nil, identity);
}


- (Class)entityClassForKey:(NSString *)key
{
    return ([MyEntity class]);
}

@end
