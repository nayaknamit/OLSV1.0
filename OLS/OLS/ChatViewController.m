//
//  ChatViewController.m
//  ChatRoom
//
//  Created by Kartik Mittal on 2/23/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "AppDelegate.h"
@interface ChatViewController (){
    NSMutableArray * messages;
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    

}
@property (strong, nonatomic) IBOutlet UITextField *inputMessageField;
@property (strong, nonatomic) IBOutlet UITableView *tView;
@property (strong,nonatomic) IBOutlet UIView *chatTextView;
@end

@implementation ChatViewController
- (void)initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"172.20.10.5", 80, &readStream, &writeStream);
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
    AppDelegate *appDelegate =    ((AppDelegate *)[UIApplication sharedApplication].delegate);
    NSString *response  = [NSString stringWithFormat:@"iam: %@",appDelegate.patientName];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
//    ChatViewController * clientView=[[ChatViewController alloc]init];
//    clientView.inputStream=inputStream;
//    clientView.outputStream=outputStream;
//    [self.navigationController pushViewController:clientView animated:YES];
    
    //    [self presentViewController:clientView animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNetworkCommunication];
    messages = [[NSMutableArray alloc] init];
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    self.tView.delegate=self;
    self.tView.dataSource=self;
    [self joinNetwork];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.01 animations:^{
        self.tView.frame = CGRectMake(self.tView.frame.origin.x, self.tView.frame.origin.y, self.tView.frame.size.width, 678);
        
        self.chatTextView.frame = CGRectMake(self.chatTextView.frame.origin.x, self.chatTextView.frame.origin.y, self.chatTextView.frame.size.width, self.chatTextView.frame.size.height);
        
    }];
    return false;
}
- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.01 animations:^{
        self.tView.frame = CGRectMake(self.tView.frame.origin.x, self.tView.frame.origin.y, self.tView.frame.size.width, 270);
        
        self.chatTextView.frame = CGRectMake(self.chatTextView.frame.origin.x, 521, self.chatTextView.frame.size.width, self.chatTextView.frame.size.height);
        
    }];
    
    return true;
    
}// return NO to disallow editing.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage:(id)sender {
    NSString *response  = [NSString stringWithFormat:@"msg:%@", self.inputMessageField.text];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    NSString *s = (NSString *) [messages objectAtIndex:indexPath.row];
    NSArray* text=[s componentsSeparatedByString:@":"];
    NSString *sss=(NSString*)[text objectAtIndex:0];
//    cell.bcImage=[[UIImageView alloc]init];
    if ([sss isEqualToString:@" kartik"]) {
        cell.text.text = s;
        cell.text.textAlignment=UITextAlignmentRight;
        cell.bcImage.image=[UIImage imageNamed:@"callout-2.png"];
    }
    else{
        cell.text.text = s;
        cell.text.textAlignment=UITextAlignmentLeft;
        cell.bcImage.image=[UIImage imageNamed:@"callout-1.png"];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
            
        case NSStreamEventHasBytesAvailable:
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                NSInteger len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            NSLog(@"server said: %@", output);
                            [self messageReceived:output];
                        }
                    }
                }
            }
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            break;
            
        default:
            NSLog(@"Unknown event");
    }
    
}

- (void) messageReceived:(NSString *)message {
    
    [messages addObject:message];
    [self.tView reloadData];
//    NSIndexPath *topIndexPath =[NSIndexPath indexPathForRow:messages.count-1 inSection:0];
//    [self.tView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
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
