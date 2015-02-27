//
//  ViewController.m
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"
#import "HelperClass.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    BOOL network=[[HelperClass alloc] isNetworkAvailable];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
