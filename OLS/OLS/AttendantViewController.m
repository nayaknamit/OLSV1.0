//
//  AttendantViewController.m
//  OLS
//
//  Created by Hackathon on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "AttendantViewController.h"
#import "VideoStreamViewController.h"
#import "ChatViewController.h"

@interface AttendantViewController ()

@end

@implementation AttendantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.items=[[NSMutableArray alloc]initWithObjects:@"Report",@"Chat", @"Patient History",@"Expenses", nil];
    UITapGestureRecognizer *singleFingerTap =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(openStream)];
    [self.streamButton addGestureRecognizer:singleFingerTap];
    self.tableView=[[UITableView alloc]init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    // Do any additional setup after loading the view from its nib.
    [self performSelector:@selector(openStream) withObject:nil afterDelay:15.0];

}

-(void)openStream{
    self.streamButton.hidden = YES;
    self.webView.hidden = NO;
    self.webView.delegate= self;
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.20.10.5:8080/1/stream.html"]];
    [self.webView loadRequest:request];
    //    float zoom=videoView.bounds.size.width/videoView.scrollView.contentSize.width;
    self.webView.scalesPageToFit=YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
}


- (IBAction)backButtonTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
    }
    
    cell.textLabel.text=[self.items objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:{
            ChatViewController * chat=[[ChatViewController alloc]init];
            [self.navigationController addChildViewController:chat];
            break;
        }
        case 2:
            
            break;
        case 3:
            
            break;
            
        default:
            break;
    }
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
