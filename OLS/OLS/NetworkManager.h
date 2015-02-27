//
//  NetworkManager.h
//  OLS
//
//  Created by Ashish Arora 4 on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    OLSUSERINFORMATION=0,

}REQUEST_TYPE;

typedef void (^OLSGetuserAPIRequestHandler)(NSDictionary *resultDict, NSError *error);
@interface NetworkManager : NSObject

// Get the shared instance and create it if necessary.
+ (NetworkManager *) sharedInstance;

@end
