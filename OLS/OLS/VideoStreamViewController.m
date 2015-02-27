//
//  VideoStreamViewController.m
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "VideoStreamViewController.h"

@interface VideoStreamViewController ()

@end

@implementation VideoStreamViewController
- (IBAction)buttonTapped:(id)sender {
    CGRect frame=self.view.frame;
    UIWebView *videoView=[[UIWebView alloc]initWithFrame:frame];
    videoView.delegate=self;
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://10.242.241.126:8080/1/stream.html"]];
    [videoView loadRequest:request];
//    float zoom=videoView.bounds.size.width/videoView.scrollView.contentSize.width;
    videoView.scalesPageToFit=YES;
    [self.view addSubview:videoView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
