//
//  NetworkManager.m
//  OLS
//
//  Created by Ashish Arora 4 on 2/28/15.
//  Copyright (c) 2015 Sapient. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

@implementation NetworkManager

static NetworkManager *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (id) sharedInstance {
    @synchronized(self) {
        if (sharedInstance == nil)
        sharedInstance = [[super allocWithZone:nil] init];
    }
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

-(void)getUserInformation:(NSString*)userName withPass:(NSString*)pass withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetuserAPIRequestHandler)responseHandler{
    
//    http://localhost:8888/health/web-service.php?user=ashish&method=Login&password=password
    NSString *webServicePathRaw = @"http://localhost:8888/health/web-service.php?method=Login";
    NSString *webServicePath = [NSString stringWithFormat:@"%@&user=%@&password=%@",webServicePathRaw,userName,pass];

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userName, @"user",
                                pass, @"password",
                                nil];
    
    NSURL *baseURL = [NSURL URLWithString:webServicePath];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:webServicePath parameters:parameters];
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    
    AFJSONRequestOperation *anOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              NSDictionary * parsedResult = [self parseConfigWithResponse:JSON withResponseType:reqType];
                                                                                              NSNumber *parseCode = [parsedResult objectForKey:@"ErrorCode"];
                                                                                              if(parseCode == [NSNumber numberWithInt:2]){
                                                                                                  
                                                                                                  responseHandler (nil,nil);
                                                                                              }else{
                                                                                                  responseHandler(parsedResult,nil);
                                                                                              }
                                                                                              
                                                                                          }
                                                                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                                              
                                                                                              responseHandler(nil, error);
                                                                                          }];
    // execute the operation
    [anOperation start];
    
    
}

-(id)parseConfigWithResponse:(id)response withResponseType:(REQUEST_TYPE)reqType{
    
    NSDictionary *jsonResponseDict = response;
    return jsonResponseDict;
}

-(void)getPatientList:(NSString*)userID withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetPatientAPIRequestHandler)responseHandler{


}


@end
