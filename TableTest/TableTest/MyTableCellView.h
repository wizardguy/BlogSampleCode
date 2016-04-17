//
//  MyTableCellView.h
//  TableTest
//
//  Created by Dennis on 1/4/16.
//  Copyright (c) 2016年 Dennis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableCellView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
