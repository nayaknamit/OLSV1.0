//
//  ReportsViewController.m
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ReportsViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
@interface ReportsViewController ()
{
    NSMutableArray *reportArra;
    NSMutableArray *cellSelected;
}
@end

@implementation ReportsViewController

-(IBAction)backbuttonTapped:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    reportArra = [NSMutableArray array];
    cellSelected = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)sendBtnTapped:(id)sender{
    NSMutableArray *reportIDAr = [NSMutableArray array];
    
    for (int j=0;j<cellSelected.count; j++) {
        NSIndexPath *path = [cellSelected objectAtIndex:j];
        reportIDAr = [[reportArra objectAtIndex:path.row] objectForKey:@"id"];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [[NetworkManager sharedInstance] getReportsMaster:delegate.userID withResponseType:OLSReportMaster responseHandler:^(NSDictionary *resultDict, NSError *error) {
        
        
        if (resultDict == nil && error == nil) {
            //            [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:NSLocalizedString(@"INVALID_USERNAME_PASSWORD",nil)];
        }
        
        
        if(resultDict !=nil)
        {
            
            if (error == nil) {
                // update the records of the user
                
                NSArray *arra = [resultDict objectForKey:@"posts"];
                for(int i=0;i<arra.count;i++){
                    NSDictionary *dict = [[arra objectAtIndex:i] objectForKey:@"reportMaster"];
                    [reportArra addObject:dict];
                    
                }
                [_tableView reloadData];
                
            }
        }

    }];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ReportsTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    }
    if ([cellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    cell.backgroundColor = [UIColor grayColor];
    NSDictionary *dict = [reportArra objectAtIndex:indexPath.row];
    
    cell.textLabel.text  = [dict objectForKey:@"testName"];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return reportArra.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //if you want only one cell to be selected use a local NSIndexPath property instead of array. and use the code below
    //self.selectedIndexPath = indexPath;
    
    //the below code will allow multiple selection
    if ([cellSelected containsObject:indexPath])
    {
        [cellSelected removeObject:indexPath];
    }
    else
    {
        [cellSelected addObject:indexPath];
    }
    [tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
