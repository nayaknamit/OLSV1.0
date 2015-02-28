//
//  PatientExpenseViewController.m
//  OLS
//
//  Created by Ashish Arora 4 on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "PatientExpenseViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
@interface PatientExpenseViewController ()

@end

@implementation PatientExpenseViewController
NSMutableArray *nameDictArra;
NSMutableArray *expectedDictExpArra;
NSInteger totalAmount;
NSInteger totalExpectedAmount;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    nameDictArra = [NSMutableArray array];
    expectedDictExpArra = [NSMutableArray array];

    NSMutableDictionary *data1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"200",@"amount",@"BloodTest",@"expenseName", nil];
    NSMutableDictionary *data2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"250",@"amount",@"ECG",@"expenseName", nil];
    NSMutableDictionary *data3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"2000",@"amount",@"CT scan",@"expenseName", nil];
        totalExpectedAmount = 2000+250+200;
        [expectedDictExpArra addObject:data1];
        [expectedDictExpArra addObject:data2];
        [expectedDictExpArra addObject:data3];
    
    totalAmount = 0;
    NetworkManager *networkManger = [NetworkManager sharedInstance];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    [networkManger getPatientExpenditureDetail:appDelegate.userID withResponseType:OLSPATIENTEXPENDITUREDETAIL responseHandler:^(NSDictionary *resultDict,NSError *error){
        
        
        if (resultDict == nil && error == nil) {
            //            [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:NSLocalizedString(@"INVALID_USERNAME_PASSWORD",nil)];
        }
        
        
        if(resultDict !=nil)
        {
            BOOL success = [[resultDict objectForKey:@"Success"] boolValue];
            if (error == nil && success) {
                // update the records of the user in core data
                NSMutableArray * dataArra = [resultDict objectForKey:@"posts"];
                [nameDictArra removeAllObjects];
                totalAmount = 0;
                for (int i=0; i<dataArra.count; i++) {
                    
                    NSMutableDictionary *dict = [[dataArra objectAtIndex:i] objectForKey:@"expenseReport"];
                    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict
                                                                                                   objectForKey:@"amount"],@"amount",[dict
                                                                                                                                      objectForKey:@"expenseName"],@"expenseName", nil];
                    NSString *amount = [dict objectForKey:@"amount"];
                    totalAmount += [amount intValue];
                    [nameDictArra addObject:data];
                }
                 [self.ExpenseTable reloadData];
                self.totalExpLbl.text = [NSString stringWithFormat:@"%ld",(long)totalAmount];
            }else{
                
                NSString *errorMessage = [resultDict objectForKey:@"ErrorMessage"];
                [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:errorMessage];
                
            }
            
        }else{
            if(error !=nil){
                NSString *errorMessage = error.localizedDescription;
                [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:errorMessage];
            }
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(self.ExpenseSegment.selectedSegmentIndex==0){
        return [nameDictArra count];
    }else{
        return [expectedDictExpArra count];
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"patientExpenseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    NSDictionary *dict = Nil;

    if(self.ExpenseSegment.selectedSegmentIndex==0){
        dict = [nameDictArra objectAtIndex:indexPath.row];
    }else{
        dict = [expectedDictExpArra objectAtIndex:indexPath.row];
    }
    
    
    cell.textLabel.text  = [dict objectForKey:@"expenseName"];
    cell.detailTextLabel.text  = [dict objectForKey:@"amount"];
    
    return cell;
}

- (void)showAlert:(NSString*)titleText body:(NSString *)bodyText {
    
    UIAlertView *ErrorAlertView = [[UIAlertView alloc]initWithTitle:titleText message:bodyText delegate:nil cancelButtonTitle:NSLocalizedString(@"ALERT_VIEW_OK","nil") otherButtonTitles:Nil, nil];
    [ErrorAlertView show];
    
}

-(IBAction)segmentedIndexChange:(id)sender{
    
    [self.ExpenseTable reloadData];
    if(self.ExpenseSegment.selectedSegmentIndex==0){
        self.totalExpLbl.text = [NSString stringWithFormat:@"%ld",(long)totalAmount];;
    }else{
        self.totalExpLbl.text = [NSString stringWithFormat:@"%ld",(long)totalExpectedAmount];;
    }
    
}
- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
