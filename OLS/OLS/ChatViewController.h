//
//  ChatViewController.h
//  ChatRoom
//
//  Created by Kartik Mittal on 2/23/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSStreamDelegate,UITextFieldDelegate>
@property (strong,nonatomic) NSInputStream *inputStream;
@property (strong,nonatomic) NSOutputStream *outputStream;
@end
