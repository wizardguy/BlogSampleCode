//
//  XJVIPERError.h
//  VIPERTest
//
//  Created by Dennis on 29/4/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#ifndef XJVIPERError_h
#define XJVIPERError_h


#define XJVIPER_ERROR               @"XJVIPER_ERROR"

#define XJSUCCESS 0

#define XJERROR_VIEW_BASE           1000
#define XJERROR_ITERACTOR_BASE      2000
#define XJERROR_PERSENTER_BASE      3000
#define XJERROR_ENTITY_BASE         4000
#define XJERROR_ROUTER_BASE         5000


#define XJERROR_ADAPTER_BASE        (XJERROR_ITERACTOR_BASE + 500)

#define XJERROR_ADAPTER_KEYNOTFOUND (XJERROR_ADAPTER_BASE + 1)


#endif /* XJVIPERError_h */
