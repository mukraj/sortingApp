//
//  SortingVC.h
//  SortingApp
//
//  Created by Mukesh on 25/04/16.
//  Copyright © 2016 Mukesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SortingVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray *sortArray;
@property(retain,nonatomic)NSString * sortTitle;
@property(readwrite)NSInteger sortCompareValue;

@end
