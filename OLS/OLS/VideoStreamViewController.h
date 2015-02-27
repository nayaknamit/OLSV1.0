//
//  VideoStreamViewController.h
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ViewController.h"

@interface VideoStreamViewController : ViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
