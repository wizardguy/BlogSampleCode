//
//  XJBaseAdapter.m
//  VIPERTest
//
//  Created by Dennis on 26/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "XJBaseAdapter.h"

@interface XJBaseAdapter ()

@property (readwrite, strong) NSDictionary *urlMapping;
@property (readwrite, strong) NSString *mappingFileName;

@end

@implementation XJBaseAdapter


// @abstract method. Must be overrided.
- (id)initWithSettingFile:(NSString *)file
{
    if (self = [super init]) {
        [self loadSettingWithFile:file];
    }
    return self;
}


- (NSDictionary *)mapping
{
    return self.urlMapping;
}


- (void)reloadSetting
{
    [self loadSettingWithFile:self.mappingFileName];
}


- (void)loadSettingWithFile:(NSString *)file
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:file ofType:@"plist"];
    if (!filePath) {
        return;
    }
    self.mappingFileName = file;
    self.urlMapping = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

@end



