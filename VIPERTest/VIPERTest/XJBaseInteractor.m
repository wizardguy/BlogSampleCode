//
//  XJBaseInteractor.m
//  VIPERTest
//
//  Created by Dennis on 21/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "XJBaseInteractor.h"
#import "XJGlobalDef.h"
#import <TMCache.h>
#import <Mantle.h>

@interface XJBaseInteractor ()

@property (nonatomic, strong, readwrite) NSMutableDictionary* dicTotalCount;
@property (strong, readwrite) id<XJBaseAdataperProtocol> adapter;
@property (strong, readwrite) TMCache *cache;

@end


@implementation XJBaseInteractor

- (id)initWithAdapter:(id<XJBaseAdataperProtocol>)adapter
{
    if (adapter == nil) {
        VIPERLOG(@"adapter must not be nil!");
        return nil;
    }
    
    if (self = [super init]) {
        self.dicTotalCount = [[NSMutableDictionary alloc] init];
        self.adapter = adapter;
        self.presenter = nil;
    }
    
    return self;
}

- (void)asyncAction:(XJDataActionType)type
                key:(NSString *)key
         parameters:(id)parameters
           identity:(NSString *)identity
         usingCache:(BOOL)isUsingCache
{
    XJAdapterFailureBlock failureBlock = ^(id task, NSError *error) {
        if (self.presenter) {
            [self.presenter interactor:self
               acctionDidFailWithError:error
                                   key:key
                            identifier:identity];
        }
    };
    
    XJAdapterSuccessBlock successBlock = ^(id task, NSDictionary *responseDic){
        
        // extract the totalcount from meta data for current action by indentity
        NSDictionary *responseMeta = [responseDic objectForKey:kMeta];
        NSNumber *totalCount = [responseMeta objectForKey:kMetaTotalCount];
        [self.dicTotalCount setObject:totalCount forKey:identity];
        
        // Get the response contents
        NSArray *responseContents = [(NSDictionary *)responseDic objectForKey:kObject];
        NSError *error = nil;
        NSArray *contents = [MTLJSONAdapter modelsOfClass:[self entityClassForKey:key] fromJSONArray:responseContents error:&error];
        
        if (self.presenter) {
            [self.presenter interactor:self actionDidSuccessWithData:contents key:key identifier:identity];
        }
    };
    
    XJAdapterSuccessBlock readBlock = ^(id task, id responseData) {
        [self.cache setObject:responseData forKey:key];
        
        successBlock(nil, responseData);
    };
    
    
    
    id respondObject = nil;
    
    switch (type) {

        case XJDataActionTypeREAD:
            /* Checking the cache */
            if (isUsingCache) {
                if ([self cachePolicyForKey:key] == XJDataCachePolicyUsingCache) {
                    respondObject = [self.cache objectForKey:key];
                    if (respondObject) {
                        successBlock(nil, respondObject);
                        return;
                    }
                    else {
                        VIPERLOG(@"No cache foud for Key:%@. Will request data forcely.", key);
                    }
                }
                
            }
            
            [self.adapter readDataWithKey:key
                               parameters:parameters
                                 identity:identity
                            waitUntilDone:NO
                                  success:readBlock
                                  failure:failureBlock];
            
            break;
            
        case XJDataActionTypeUPDATE:
            [self.adapter updateDataWithKey:key
                                 parameters:parameters
                                    identiy:identity
                              waitUntilDone:NO
                                    success:successBlock
                                    failure:failureBlock];
            break;
            
        case XJDataActionTypeDELETE:
            [self.adapter deleteDataWithKey:key
                                 parameters:parameters
                                    identiy:identity
                              waitUntilDone:NO
                                    success:successBlock
                                    failure:failureBlock];
            break;
            
        case XJDataActionTypeCREAT:
            [self.adapter createDataWithKey:key
                                 parameters:parameters
                                   identity:identity
                              waitUntilDone:NO
                                    success:successBlock
                                    failure:failureBlock];
            break;
            
        default:
            VIPERLOG(@"error: Unkown data action type: %ld", (long)type);
            break;
    }
}


- (void)syncAction:(XJDataActionType)type
               key:(NSString *)key
        parameters:(id)parameters
          identity:(NSString *)identity
        usingCache:(BOOL)isUsingcache
              data:(__autoreleasing id *)data
{
    
}


- (XJDataCachePolicy)cachePolicyForKey:(NSString *)key
{
    return XJDataCachePolicyNone;
}


- (Class)entityClassForKey:(NSString *)key
{
    return [NSObject class];
}


@end
