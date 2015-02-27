//
//  ViewController.h
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSStreamDelegate>
@property (weak, nonatomic) IBOutlet UIView *loginButtonView;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong,nonatomic)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (strong,nonatomic) UIImageView *splashView;
@end

