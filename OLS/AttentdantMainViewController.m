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
            BOOL success = [[resultDict objectForKey:@"Success"] boolValue];
            if (error == nil && success) {
                // update the records of the user
            }
        }
        }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)videoStreamTapped:(id)sender{
    
}
-(IBAction)expenseTapped:(id)sender{
    
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
