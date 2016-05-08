//
//  XJNetworkAdapter.h
//  VIPERTest
//
//  Created by Dennis on 26/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "XJBaseAdapter.h"

typedef void (^ successBlock)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) ;
typedef void (^ failureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error);

@interface XJNetworkAdapter : XJBaseAdapter <XJBaseAdataperProtocol>



@end


#define XJNETWORKADAPTER_KEY_BASEURL    @"baseUrl"