//
//  PatientExpenseViewController.h
//  OLS
//
//  Created by Ashish Arora 4 on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientExpenseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *ExpenseTable;
@property(nonatomic,strong) IBOutlet UISegmentedControl *ExpenseSegment;

@end
