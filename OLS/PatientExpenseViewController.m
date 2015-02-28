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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

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
    return 1;//[nameDictArra count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"patientExpenseCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    NSDictionary *dict = [nameDictArra objectAtIndex:indexPath.row];
    
//    cell.textLabel.text  = [dict objectForKey:@"name"];
    return cell;
}

- (void)showAlert:(NSString*)titleText body:(NSString *)bodyText {
    
    UIAlertView *ErrorAlertView = [[UIAlertView alloc]initWithTitle:titleText message:bodyText delegate:nil cancelButtonTitle:NSLocalizedString(@"ALERT_VIEW_OK","nil") otherButtonTitles:Nil, nil];
    [ErrorAlertView show];
    
}

@end
