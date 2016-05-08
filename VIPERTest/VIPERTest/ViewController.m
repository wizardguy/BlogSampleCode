//
//  ViewController.m
//  VIPERTest
//
//  Created by Dennis on 21/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import "ViewController.h"
#import "XJGlobalDef.h"
#import <AFNetworking.h>
#import "MyPresenter.h"
#import "MyInteractor.h"

@implementation MyListCellItem


- (instancetype) initWithUrl:(NSURL *)url ID:(NSNumber *)idNum
{
    self = [super init];
    if (self) {
        self.urlLable = [url absoluteString];
        self.idLable = [idNum stringValue];
    }
    return self;
}

@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyInteractor *interactor = [[MyInteractor alloc] init];
    MyPresenter *presenter = [[MyPresenter alloc] initWithInteractor:interactor];
    
    presenter.output = self;
    self.eventHandler = presenter;
    
    [presenter loadData];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)updateUIWithData:(NSArray<MyListCellItem *> *)data
{
    for (MyListCellItem *item in data) {
        NSLog(@"URL: %@", item.urlLable);
        NSLog(@"ID: %@", item.idLable);
    }
}


@end
