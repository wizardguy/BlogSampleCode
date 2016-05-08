//
//  MyEntity.m
//  VIPERTest
//
//  Created by Dennis on 4/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "MyEntity.h"

@implementation MyEntity

+ (NSDictionary *) JSONKeyPathsByPropertyKey
{
    return @{
             @"imageUrl" : @"image_mobile",
             @"pid" : @"product_id",
             @"rid" : @"rid",
             @"sequence" : @"sequence",
             @"type" : @"show_type"
             };
}

@end
