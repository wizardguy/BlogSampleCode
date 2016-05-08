//
//  XJBaseInteractor.h
//  VIPERTest
//
//  Created by Dennis on 21/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XJBaseInteractorDef.h"
#import "XJBaseAdapter.h"


#pragma mark - Interactor Delegate Protocol

@class XJBaseInteractor;

@protocol XJBaseInteractorDelegateProtocol <NSObject>

- (void)interactor:(__kindof XJBaseInteractor *)interactor actionDidSuccessWithData:(id)data key:(NSString*)key identifier:(NSString*)identifier;

- (void)interactor:(__kindof XJBaseInteractor *)interactor acctionDidFailWithError:(NSError *)error key:(NSString*)key identifier:(NSString*)identifier;

@end


@class XJBasePresenter;

@interface XJBaseInteractor : NSObject

@property (weak, readwrite) __kindof XJBasePresenter* presenter;

- (instancetype)initWithAdapter:(id <XJBaseAdataperProtocol>)adapter;

/**
 * Asynchronous action method. The sender must acknowledge to the <XJBaseInteractorProtcol>.
 *
 * @param   key         The access path to the resource.
 * @param   parameters  The extra parameters for the current calling.
 * @param   identity    An unique string that identify the current accessing.
 * @param   usingCache     The flag to indicate if using the cache or not. If this flag is set to NO, then 
 *                      it will use the cache policy overrided in - cachePolicy: .
 *
 */

- (void)asyncAction:(XJDataActionType)type
                key:(NSString *)key
         parameters:(id)parameters
           identity:(NSString *)identity
         usingCache:(BOOL)isUsingCache;


/**
 * Synchronous action method.
 *
 * @param   key         The access path to the resource.
 * @param   parameters  The extra parameters for the current calling.
 * @param   identity    An unique string that identify the current accessing.
 * @param   usingCache     The flag to indicate if using the cache or not. If this flag is set to NO, then
 *                      it will use the cache policy overided in - cachePolicy: .
 * @param   data        The response data. If it is set to nil, the response data will be discarded.
 *
 */

- (void)syncAction:(XJDataActionType)type
               key:(NSString *)key
        parameters:(id)parameters
          identity:(NSString *)identity
        usingCache:(BOOL)isUsingCache
              data:(id __autoreleasing *)data;


/**
 * @abstract
 * Return the specific Class for corresponding key
 * Must be overrided for specific interactor.
 */
- (Class)entityClassForKey:(NSString *)key;


/**
 * @abstract
 * The default cache policy is XJDataCachePolicyNone.
 * Must be overrided if the interactor want to use different cache policy.
 */

- (XJDataCachePolicy)cachePolicyForKey:(NSString*)key;

@end

#pragma mark - Async Action Wrapper

#define XJAsyncCreateData(inter, k, p, i) {[(inter) asyncAction:XJDataActionTypeCREATE key:(k) parameters:(p) identity:(i) usingCache:NO];}

#define XJAsyncReadData(inter, k, p, i) {[(inter) asyncAction:XJDataActionTypeREAD key:(k) parameters:(p) identity:(i) usingCache:NO];}

#define XJAsyncUpdateData(inter, k, p, i) {[(inter) asyncAction:XJDataActionTypeUPDATE key:(k) parameters:(p) identity:(i) usingCache:NO];}

#define XJAsyncDeleteData(inter, k, p, i) {[(inter) asyncAction:XJDataActionTypeDELETE key:(k) parameters:(p) identity:(i) usingCache:NO];}

#pragma mark - Sync Action Wrapper

#define XJSyncCreateData(inter, k, p, i, d) {[(inter) syncAction:XJDataActionTypeCREATE key:(k) parameters:(p) identity:(i) usingCache:NO response:(d)];}

#define XJSyncReadData(inter, k, p, i, d) {[(inter) syncAction:XJDataActionTypeREAD key:(k) parameters:(p) identity:(i) usingCache:NO response:(d)];}

// Forcely read the data, ignoring the current cache policy.
#define XJSyncReadDataWithusingCache(inter, k, p, i, d) {[(inter) syncAction:XJDataActionTypeREAD key:(k) parameters:(p) identity:(i) usingCache:YES response:(d)];}

#define XJSyncUpdateData(inter, k, p, i, d) {[(inter) syncAction:XJDataActionTypeUPDATE key:(k) parameters:(p) identity:(i) usingCache:NO response:(d)];}

#define XJSyncDeleteData(inter, k, p, i, d) {[(inter) syncAction:XJDataActionTypeDELETE key:(k) parameters:(p) identity:(i) usingCache:NO response:(d)];}


