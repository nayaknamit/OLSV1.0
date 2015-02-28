//
//  LoginViewController.h
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"

@interface LoginViewController : ViewController<NSStreamDelegate,UITextFieldDelegate>

@property (strong,nonatomic)NSTimer *timer;

@property (strong,nonatomic) UIImageView *splashView;
@property (weak, nonatomic) IBOutlet UIView *loginButtonView;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end
