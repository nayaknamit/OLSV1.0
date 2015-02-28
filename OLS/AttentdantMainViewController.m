//
//  AttentdantMainViewController.m
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "AttentdantMainViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "PatientExpenseViewController.h"
#import "AttendantViewController.h"

@interface AttentdantMainViewController ()

-(IBAction)videoStreamTapped:(id)sender;
-(IBAction)expenseTapped:(id)sender;
-(IBAction)reportsTapped:(id)sender;
@end

@implementation AttentdantMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.layer.contents = (id)[UIImage
                                                                  imageNamed:@"header1.png"].CGImage;    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [[NetworkManager sharedInstance] getPatientDetailList:delegate.userID withResponseType:OLSPATIENTDETAIL responseHandler:^(NSDictionary *resultDict, NSError *error) {
        
        if (resultDict == nil && error == nil) {
            //            [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:NSLocalizedString(@"INVALID_USERNAME_PASSWORD",nil)];
        }
        
        
        if(resultDict !=nil)
        {
            
            if (error == nil) {
                // update the records of the user
                
                NSDictionary *dict = [[[resultDict objectForKey:@"posts"] objectAtIndex:0] objectForKey:@"patientDetails"];
                [self performSelectorOnMainThread:@selector(updateData:) withObject:dict waitUntilDone:YES];
    
            }
        }
        }];
}
-(void)updateData:(NSDictionary *)dict{
    
    
    self.lblDocName.text = [dict objectForKey:@"doctorName"];
    self.lblDoctorMob.text =[dict objectForKey:@"doc_mob"];
    self.lblICUNo.text = [dict objectForKey:@"icuBadNo"];
    self.lblName.text = [dict objectForKey:@"name"];
    self.lblUID.text = [dict objectForKey:@"patientID"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)videoStreamTapped:(id)sender{
    AttendantViewController *att  = [[AttendantViewController alloc] initWithNibName:@"AttendantViewController" bundle:nil];
    [self.navigationController pushViewController:att animated:YES];
}

-(IBAction)expenseTapped:(id)sender{
 
    PatientExpenseViewController *PEVC = [[PatientExpenseViewController alloc]initWithNibName:@"PatientExpenseViewController" bundle:Nil];
    
    [self.navigationController pushViewController:PEVC animated:YES];
    
}
-(IBAction)reportsTapped:(id)sender{
    
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
