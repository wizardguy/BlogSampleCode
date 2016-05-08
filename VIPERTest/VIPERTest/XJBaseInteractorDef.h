//
//  XJBaseInteractorDef.h
//  VIPERTest
//
//  Created by Dennis on 21/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#ifndef VIPERTest_XJBaseInteractorDef_h
#define VIPERTest_XJBaseInteractorDef_h


typedef NS_ENUM(NSInteger, XJDataActionType) {
    XJDataActionTypeCREAT = 0,
    XJDataActionTypeREAD,
    XJDataActionTypeUPDATE,
    XJDataActionTypeDELETE,
};


typedef NS_ENUM(NSInteger, XJHTTPMethodType) {
    XJMethodTypeGET = 0,
    XJMethodTypePOST,
    XJMethodTypePUT,
    XJMethodTypeDELETE,
    XJMethodTypePATCH,
};


typedef NS_ENUM(NSInteger, XJDataCachePolicy) {
    XJDataCachePolicyNone,
    XJDataCachePolicyUsingCache,
};

#define kMeta               @"meta"
#define kMetaTotalCount     @"total_count"
#define kObject             @"objects"
#define kOffset             @"offset"


#endif
