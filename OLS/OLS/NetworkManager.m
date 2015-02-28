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
#define localhost @"172.20.10.4:8888"
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
    
//    http://192.168.56.87:8888/health/web-service.php?user=ashish&method=Login&password=password
    NSString *webServicePathRaw = @"http://172.20.10.3/health/web-service.php?method=Login";
    NSString *webServicePath = [NSString stringWithFormat:@"%@&user=%@&password=%@",webServicePathRaw,userName,pass];

    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userName, @"user",
                                pass, @"password",
                                nil];
    
    NSURL *baseURL = [NSURL URLWithString:webServicePath];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:webServicePath parameters:parameters];
    
    [request setTimeoutInterval:60000];
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

//http://192.168.56.87:8888/health/web-service.php?method=patientList&userID=4
    NSString *webServicePathRaw = @"http://172.20.10.3/health/web-service.php?method=patientList";
    NSString *webServicePath = [NSString stringWithFormat:@"%@&userID=%@",webServicePathRaw,userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID, @"userID",
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

-(void)getPatientDetailList:(NSString*)userID withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetPatientDetailAPIRequestHandler)responseHandler{
    
    //http://192.168.56.87:8888/health/web-service.php?method=patientList&userID=4
    NSString *webServicePathRaw = @"http://172.20.10.3/health/web-service.php?method=patientDetails";
    NSString *webServicePath = [NSString stringWithFormat:@"%@&userID=%@",webServicePathRaw,userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID, @"userID",
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

-(void)getPatientExpenditureDetail:(NSString*)userID withResponseType:(REQUEST_TYPE)reqType responseHandler:(OLSGetPatientDetailAPIRequestHandler)responseHandler{
    
    //http://192.168.56.87:8888/health/web-service.php?method=patientList&userID=4
    NSString *webServicePathRaw = @"http://172.20.10.3/health/web-service.php?method=expenseReport";
    NSString *webServicePath = [NSString stringWithFormat:@"%@&userID=%@",webServicePathRaw,userID];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                userID, @"userID",
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


@end
