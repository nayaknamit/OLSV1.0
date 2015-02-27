//
//  HelperClass.h
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HelperClass : NSObject
- (void) handleReceivedNotification:(UILocalNotification*) thisNotification;
-(BOOL)isNetworkAvailable;
-(void)showLocalNotificationsWithString:(NSString* )string;
- (void) scheduleNotificationOn:(NSDate*) fireDate text:(NSString*) alertText action:(NSString*) alertAction sound:(NSString*) soundfileName launchImage:(NSString*) launchImage  andInfo:(NSDictionary*) userInfo;
@end
