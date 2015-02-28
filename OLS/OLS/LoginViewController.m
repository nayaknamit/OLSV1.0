//
//  LoginViewController.m
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "LoginViewController.h"
#import "HelperClass.h"
#import "ChatViewController.h"
#import "NetworkManager.h"
#import "AppDelegate.h"
#import "PatientListViewController.h"
#import "AttentdantMainViewController.h"
@interface LoginViewController (){
    NSInteger count;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    UITapGestureRecognizer *singleFingerTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(loginTapped)];
    [self.loginButtonView addGestureRecognizer:singleFingerTap];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
    count=0;
    CGRect frame=self.view.frame;
    self.splashView=[[UIImageView alloc]initWithFrame:frame];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeSplashImage) userInfo:nil repeats:YES];
    [self.view addSubview:self.splashView];
    [self.view bringSubviewToFront:self.splashView];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeSplashImage{
    count=count+1;
    if (count==40) {
        [self.timer invalidate];
        [self.splashView removeFromSuperview];
    }
    else{
        if (count%6==0) {
            NSString *name=[NSString stringWithFormat:@"splashscreen6.png"];
            self.splashView.image=[UIImage imageNamed:name];
        }
        else{
            NSString *name=[NSString stringWithFormat:@"splashscreen%ld.png",(long)count%6];
            self.splashView.image=[UIImage imageNamed:name];
        }
    }
}

//Chat server



-(IBAction)loginTapped:(id)sender{
    
        NetworkManager *networkManager = [NetworkManager sharedInstance];
    
    [networkManager getUserInformation:self.usernameField.text withPass:self.passwordField.text withResponseType:OLSUSERINFORMATION responseHandler:^(NSDictionary *resultDict,NSError *error){

        
        if (resultDict == nil && error == nil) {
//            [self showAlert:NSLocalizedString(@"ALERT_VIEW_TITLE",nil) body:NSLocalizedString(@"INVALID_USERNAME_PASSWORD",nil)];
        }
        
        
        if(resultDict !=nil)
        {
            BOOL success = [[resultDict objectForKey:@"Success"] boolValue];
            if (error == nil && success) {
                // update the records of the user in core data
                
                AppDelegate *appDelegate =    ((AppDelegate *)[UIApplication sharedApplication].delegate);
//                appDelegate.userID =
                
                NSDictionary *dict = [[[resultDict objectForKey:@"posts"] objectAtIndex:0] objectForKey:@"users"];
                appDelegate.userID = [dict objectForKey:@"id"];
                appDelegate.patientName = [dict objectForKey:@"username"];
                if([[dict objectForKey:@"accountType"] integerValue] == 3){
                    AttentdantMainViewController *patientList = [[AttentdantMainViewController alloc]initWithNibName:@"AttentdantMainViewController" bundle:Nil];
                    
                    
                    [self.navigationController pushViewController:patientList animated:YES];
                    return ;
                }
                else if([[dict objectForKey:@"accountType"] integerValue] == 1)
                {
                PatientListViewController *patientList = [[PatientListViewController alloc]initWithNibName:@"PatientListViewController" bundle:Nil];

                
                [self.navigationController pushViewController:patientList animated:YES];
                }
            }else{
                
                NSString *errorMessage = [resultDict objectForKey:@"ErrorMessage"];
                [self showAlert:@"Alert" body:errorMessage];
                
            }
            
        }else{
            if(error !=nil){
                NSString *errorMessage = error.localizedDescription;
                [self showAlert:@"Alert" body:errorMessage];
            }
        }
    }];
}

- (void)showAlert:(NSString*)titleText body:(NSString *)bodyText {
    
    UIAlertView *ErrorAlertView = [[UIAlertView alloc]initWithTitle:titleText message:bodyText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}

@end
