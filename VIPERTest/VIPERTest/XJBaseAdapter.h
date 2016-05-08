//
//  XJBaseAdapter.h
//  VIPERTest
//
//  Created by Dennis on 26/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XJBASEADAPTER_DEFAULTMAPPING_FILENAME @"adapterDefaultMapping"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ XJAdapterSuccessBlock)(id _Nullable task, NSDictionary* _Nullable responseDic) ;
typedef void (^ XJAdapterFailureBlock)(id _Nullable task, NSError * _Nullable error);

@interface XJBaseAdapter : NSObject

- (nullable id)initWithSettingFile:(NSString *)file NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)mapping;
- (void)reloadSetting;
- (void)loadSettingWithFile:(NSString *)file;

@end


@protocol XJBaseAdataperProtocol <NSObject>

@required

- (id)initWithDefaultSetting;

- (void)createDataWithKey:(NSString *)key
               parameters:(id)parameters
                 identity:(NSString *)identity
            waitUntilDone:(BOOL)wait
                  success:(nullable XJAdapterSuccessBlock)success
                  failure:(nullable XJAdapterFailureBlock)failure;

- (void)readDataWithKey:(NSString *)key
             parameters:(nullable id)parameters
               identity:(NSString *)identity
          waitUntilDone:(BOOL)wait
                success:(nullable XJAdapterSuccessBlock)success
                failure:(nullable XJAdapterFailureBlock)failure;

- (void)updateDataWithKey:(NSString *)key
               parameters:(id)parameters
                  identiy:(NSString *)identity
            waitUntilDone:(BOOL)wait
                  success:(nullable XJAdapterSuccessBlock)success
                  failure:(nullable XJAdapterFailureBlock)failure;

- (void)deleteDataWithKey:(NSString *)key
               parameters:(nullable id)parameters
                  identiy:(NSString *)identity
            waitUntilDone:(BOOL)wait
                  success:(nullable XJAdapterSuccessBlock)success
                  failure:(nullable XJAdapterFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END