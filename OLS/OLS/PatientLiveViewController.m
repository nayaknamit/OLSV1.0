//
//  PatientLiveViewController.m
//  OLS
//
//  Created by Namit Nayak on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "PatientLiveViewController.h"
#import "ChatViewController.h"
#import "PatientLiveCellTableViewCell.h"
@interface PatientLiveViewController (){
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}
@property (strong, nonatomic) NSMutableArray *dataArra;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@end

@implementation PatientLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArra = [NSMutableArray array];
    [_dataArra addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Suggested Prescription",@"label",@"icon11.png",@"image", nil]];
    
    [_dataArra addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Chat",@"label",@"icon12.png",@"image", nil]];
    
    [_dataArra addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Patient History",@"label",@"icon13.png",@"image", nil]];
    
    [_dataArra addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"Reports",@"label",@"icon14.png",@"image", nil]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost/smoothie/examples/example1.html"];

    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self initNetworkCommunication];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"PatientLiveCellTableViewCell";
    
    PatientLiveCellTableViewCell * cell =  (PatientLiveCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PatientLiveCellTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSMutableDictionary * dict = [_dataArra objectAtIndex:indexPath.row];
    if(indexPath.row%2 ==0){
        cell.bgImageView.image = [UIImage imageNamed:@"cell2.png"];
        
    }else{
        cell.bgImageView.image = [UIImage imageNamed:@"cell1.png"];
    }
    cell.itemTypeLabel.text = [dict objectForKey:@"label"];
    cell.itemTypeImageView.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArra.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict = [_dataArra objectAtIndex:indexPath.row];
    if ([[dict objectForKey:@"label"] isEqualToString:@"Chat"]) {
          [self joinNetwork];
        
    }else if ([[dict objectForKey:@"label"] isEqualToString:@"Suggested Prescription"]) {
        
    }else if ([[dict objectForKey:@"label"] isEqualToString:@"Patient"]) {
        
    }else if ([[dict objectForKey:@"label"] isEqualToString:@"Reports"]) {
        
    }
    
    
    NSLog(@"ss");
}




- (void)initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"192.168.56.91", 8888, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    //    [inputStream setDelegate:self];
    //    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
}

- (void)joinNetwork{
    NSString *response  = [NSString stringWithFormat:@"iam"];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    ChatViewController * clientView=[[ChatViewController alloc]init];
    clientView.inputStream=inputStream;
    clientView.outputStream=outputStream;
    [self.navigationController pushViewController:clientView animated:YES];
    
//    [self presentViewController:clientView animated:YES completion:nil];
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
