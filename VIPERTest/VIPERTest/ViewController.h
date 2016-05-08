//
//  ViewController.h
//  VIPERTest
//
//  Created by Dennis on 21/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyInteractor.h"
#import "XJBaseInteractor.h"
#import "XJBaseViewController.h"

@interface MyListCellItem : NSObject

@property (strong) NSString *idLable;
@property (strong) NSString *urlLable;

- (instancetype) initWithUrl:(NSURL *)url ID:(NSNumber *)idNum;
@end



@interface ViewController : XJBaseViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;


- (void)updateUIWithData:(NSArray<MyListCellItem *> *)data;

@end

