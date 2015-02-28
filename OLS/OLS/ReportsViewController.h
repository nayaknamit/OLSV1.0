//
//  ReportsViewController.h
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) IBOutlet UIButton *btn;
-(IBAction)sendBtnTapped:(id)sender;
@end
