//
//  ViewController.m
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"
#import "HelperClass.h"
@interface ViewController (){
    NSInteger count;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
