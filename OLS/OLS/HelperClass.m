//
//  HelperClass.m
//  OLS
//
//  Created by Kartik Mittal on 2/26/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "HelperClass.h"
#import "Reachability.h"
#import "AFNetworking.h"


@implementation HelperClass

-(BOOL)isNetworkAvailable{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}

-(void)showLocalNotificationsWithString:(NSString* )string{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = string;
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

- (void) scheduleNotificationOn:(NSDate*) fireDate text:(NSString*) alertText action:(NSString*) alertAction sound:(NSString*) soundfileName launchImage:(NSString*) launchImage  andInfo:(NSDictionary*) userInfo

{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = fireDate;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertBody = alertText;
    localNotification.alertAction = alertAction;
    
    if(soundfileName == nil)
    {
        localNotification.soundName = UILocalNotificationDefaultSoundName;
    }
    else
    {
        localNotification.soundName = soundfileName;
    }
    
    localNotification.alertLaunchImage = launchImage;
    
    
    localNotification.userInfo = userInfo;
    
    // Schedule it with the app
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

- (void) handleReceivedNotification:(UILocalNotification*) thisNotification
{
    NSLog(@"Received: %@",[thisNotification description]);
}

@end
