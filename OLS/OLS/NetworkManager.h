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
    OLSPATIENTLIST,

}REQUEST_TYPE;

typedef void (^OLSGetuserAPIRequestHandler)(NSDictionary *resultDict, NSError *error);
typedef void (^OLSGetPatientAPIRequestHandler)(NSDictionary *resultDict, NSError *error);
@interface NetworkManager : NSObject

// Get the shared instance and create it if necessary.
+ (NetworkManager *) sharedInstance;
-(void)getUserInformation:(NSString*)userName withPass:(NSString*)pass withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetuserAPIRequestHandler)responseHandler;

-(void)getPatientList:(NSString*)userID withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetPatientAPIRequestHandler)responseHandler;

@end
