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
{
    NSMutableArray *nameDictArra;
}
@end

@implementation PatientListViewController
- (IBAction)backBottonTapped:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    nameDictArra = [NSMutableArray array];
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
                [nameDictArra removeAllObjects];
                for (int i=0; i<dataArra.count; i++) {
                    NSMutableDictionary *dict = [[dataArra objectAtIndex:i] objectForKey:@"patientList"];
                    
                    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict
 objectForKey:@"id"],@"ID",[NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"name"],[dict objectForKey:@"surname"]],@"name", nil];
                    [nameDictArra addObject:data];
               
                }
                [_patientTableView reloadData];
                /*
                PatientLiveViewController *patientLiveVC = [[PatientLiveViewController alloc]initWithNibName:@"PatientLiveViewController" bundle:Nil];
                patientLiveVC.patientArr = nameDictArra;
                [self.navigationController pushViewController:patientLiveVC animated:YES];
                */
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
    return [nameDictArra count];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"patientListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dict = [nameDictArra objectAtIndex:indexPath.row];
    
    cell.textLabel.text  = [dict objectForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    PatientLiveViewController* patientView=[[PatientLiveViewController alloc]initWithNibName:@"PatientLiveViewController" bundle:nil];
    patientView.dataDictionary=[nameDictArra objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:patientView animated:YES];
}

@end
