//
//  MyPresenter.m
//  VIPERTest
//
//  Created by Dennis on 5/5/2016.
//  Copyright © 2016 Dennis. All rights reserved.
//

#import "MyPresenter.h"
#import "MyInteractor.h"
#import "MyEntity.h"
#import "ViewController.h"



@implementation MyPresenter

- (void)loadData
{
    MyInteractor *interactor = self.interacter;
    [interactor requestItemsForKey:MY_KEY_ADINDEX identity:MY_ID_ADINDEX];
}



- (NSArray<MyListCellItem *> *)prepareData:(NSArray *)data
{
    NSArray *result = nil;
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MyEntity *ent = (MyEntity *)obj;
        MyListCellItem *item = [[MyListCellItem alloc] initWithUrl:ent.imageUrl ID:ent.rid];
        [result arrayByAddingObject:item];
    }];
    return result;
}

#pragma mark - interactor delegate
- (void)interactor:(__kindof XJBaseInteractor *)interactor actionDidSuccessWithData:(id)data key:(NSString *)key identifier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"myEntityList"]) {
        ViewController *output = self.output;
        [output updateUIWithData:[self prepareData:data]];
    }
    else if ([identifier isEqualToString:@"myEntity"]) {
        
    }
}



- (void)interactor:(__kindof XJBaseInteractor *)interactor acctionDidFailWithError:(NSError *)error key:(NSString *)key identifier:(NSString *)identifier
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed!" message:[error description] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}



@end
