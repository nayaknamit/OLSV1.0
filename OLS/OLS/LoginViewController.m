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
#import "DocDashBoardViewController.h"
#import "AppDelegate.h"

@interface LoginViewController (){
    NSInteger count;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
}


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *singleFingerTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(loginTapped)];
    [self.loginButtonView addGestureRecognizer:singleFingerTap];
    
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

- (void)initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.56.91", 3600, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    //    [inputStream setDelegate:self];
    //    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}

- (IBAction)joinNetwork:(id)sender {
    NSString *response  = @"ss";//[NSString stringWithFormat:@"iam:%@", self.nameField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    ChatViewController * clientView=[[ChatViewController alloc]init];
    clientView.inputStream=inputStream;
    clientView.outputStream=outputStream;
    [self presentViewController:clientView animated:YES completion:nil];
}


-(void) loginTapped{
    
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
                DocDashBoardViewController *docDash = [[DocDashBoardViewController alloc]initWithNibName:@"DocDashBoardViewController" bundle:Nil];
                
                [self.navigationController pushViewController:docDash animated:YES];
              
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

@end
