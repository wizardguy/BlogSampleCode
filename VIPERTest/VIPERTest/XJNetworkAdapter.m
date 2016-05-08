//
//  XJNetworkAdapter.m
//  VIPERTest
//
//  Created by Dennis on 26/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "XJNetworkAdapter.h"
#import "XJVIPERError.h"

@interface XJNetworkAdapter () <XJBaseAdataperProtocol>

@property (strong, readwrite, nonnull) AFHTTPSessionManager *manager;


@end

#define XJNETWORKADAPTER_SETTINGPLIST @"networkAdapterMapping"

@implementation XJNetworkAdapter

- (nonnull instancetype) initWithDefaultSetting
{
    if (self = [super initWithSettingFile:XJNETWORKADAPTER_SETTINGPLIST]) {
        NSString *baseUrlStr = [self.mapping objectForKey:XJNETWORKADAPTER_KEY_BASEURL];
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrlStr]];
        /*
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        NSSet *set = _manager.responseSerializer.acceptableContentTypes;
        _manager.responseSerializer.acceptableContentTypes = [set setByAddingObject:@"text/html"];
        _manager.securityPolicy.allowInvalidCertificates = YES;
         */
    }
    return self;
}


- (void)readDataWithKey:(NSString *)key parameters:(id)parameters identity:(NSString *)identity waitUntilDone:(BOOL)wait success:(XJAdapterSuccessBlock)success failure:(XJAdapterFailureBlock)failure
{
    NSString *urlString = [self.mapping objectForKey:key];
    if (urlString) {
        [self.manager GET:urlString parameters:nil progress:nil success:success failure:failure];
    }
    else {
        NSError *error = [NSError errorWithDomain:XJVIPER_ERROR code:XJERROR_ADAPTER_KEYNOTFOUND userInfo:nil];
        if (failure) {
            failure(nil, error);
        }
    }
}


- (void)createDataWithKey:(NSString *)key parameters:(id)parameters identity:(NSString *)identity waitUntilDone:(BOOL)wait success:(XJAdapterSuccessBlock)success failure:(XJAdapterFailureBlock)failure
{
    
}


- (void)deleteDataWithKey:(NSString *)key parameters:(id)parameters identiy:(NSString *)identity waitUntilDone:(BOOL)wait success:(XJAdapterSuccessBlock)success failure:(XJAdapterFailureBlock)failure
{
    
}


- (void)updateDataWithKey:(NSString *)key parameters:(id)parameters identiy:(NSString *)identity waitUntilDone:(BOOL)wait success:(XJAdapterSuccessBlock)success failure:(XJAdapterFailureBlock)failure
{
    
}

@end
