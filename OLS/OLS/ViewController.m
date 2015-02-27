//
//  ViewController.m
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"
#import "HelperClass.h"
#import "ChatViewController.h"
@interface ViewController (){
    NSInteger count;
    
        NSInputStream *inputStream;
        NSOutputStream *outputStream;
    
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


@end
