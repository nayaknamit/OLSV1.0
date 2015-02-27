//
//  AttendantViewController.h
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"

@interface AttendantViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *streamButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSMutableArray *items;
@end
