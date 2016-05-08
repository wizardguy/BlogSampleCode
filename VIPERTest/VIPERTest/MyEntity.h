//
//  MyEntity.h
//  VIPERTest
//
//  Created by Dennis on 4/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM(int, MyEntityShowType) {
    ShowType1 = 0,
    ShowType2,
    ShowType3
};

@interface MyEntity : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong, readonly) NSURL *imageUrl;
@property (nonatomic, strong, readonly) NSNumber *pid;
@property (nonatomic, strong, readonly) NSNumber *rid;
@property (nonatomic, strong, readonly) NSNumber *sequence;
@property (nonatomic, strong, readonly) NSNumber *type;


@end
