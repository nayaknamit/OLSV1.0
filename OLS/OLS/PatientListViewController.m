//
//  PatientListViewController.m
//  OLS
//
//  Created by Ashish Arora 4 on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "PatientListViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "PatientLiveViewController.h"
@interface PatientListViewController ()

@end

@implementation PatientListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

    
NetworkManager *networkManager = [NetworkManager sharedInstance];
    
[    networkManager getPatientList:@"4" withResponseType:OLSPATIENTLIST responseHandler:^(NSDictionary *resultDict,NSError *error){
        
        
        if (resultDict == nil && error == nil) {
            //            [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:NSLocalizedString(@"INVALID_USERNAME_PASSWORD",nil)];
        }
        
        
        if(resultDict !=nil)
        {
            BOOL success = [[resultDict objectForKey:@"Success"] boolValue];
            if (error == nil && success) {
                // update the records of the user in core data
                NSMutableArray * dataArra = [resultDict objectForKey:@"posts"];

                PatientLiveViewController *patientLiveVC = [[PatientLiveViewController alloc]initWithNibName:@"PatientLiveViewController" bundle:Nil];

                [self.navigationController pushViewController:patientLiveVC animated:YES];
                
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

- (void)showAlert:(NSString*)titleText body:(NSString *)bodyText {
    
    UIAlertView *ErrorAlertView = [[UIAlertView alloc]initWithTitle:titleText message:bodyText delegate:nil cancelButtonTitle:NSLocalizedString(@"ALERT_VIEW_OK","nil") otherButtonTitles:Nil, nil];
    [ErrorAlertView show];
    
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
    return 1;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"patientListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text  =@"Ramesh";
    return cell;
}

@end
