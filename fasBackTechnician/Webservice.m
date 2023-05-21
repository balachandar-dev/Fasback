//
//  Webservice.m
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import "Webservice.h"
#import <AFNetworking.h>
#import "Constants.h"

@implementation Webservice

static NSString * ipAddressForWebService = @"http://fasbackdevapi.azurewebsites.net";
//static NSString *  ipAddressForWebService = @"http://fasbackapi.azurewebsites.net";

+(NSString *)webserviceLink
{
    return ipAddressForWebService;
}

#pragma mark - RequestMethod

-(void)requestMethod:(NSString *)requestUrlString withMsgType : (int) msgType
{
    NSURL * url=[NSURL URLWithString:requestUrlString];
    
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    config.HTTPAdditionalHeaders = @{@"Authorization": [[NSUserDefaults standardUserDefaults]objectForKey:accessToken]};
//    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                NSLog(@"%@", json);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //Side thread
//            [self moveToParentClasswithData:json withError:error withMsgType:msgType];
//        });
//        
//        
//    }];
    
    
    
    
    
    //Configure your session with common header fields like authorization etc
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization": authValue};
    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
//    NSURLSession *session = [NSURLSession sharedSession];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    
//    [request setValue:authValue forHTTPHeaderField:@"Authorization"];

//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        if (!error) {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//            if (httpResponse.statusCode == 200){
//                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:nil];
//                NSLog(@"json %@",jsonData);
//                //Process the data
//            }
//        }
//        
//    }];
//    [task resume];

//    self.responseData = [[NSMutableData alloc]init];
//    self.dataDictionary = [[NSMutableDictionary alloc]init];
    
    NSString *authValue = [NSString stringWithFormat:@"bearer %@",[[NSUserDefaults standardUserDefaults]objectForKey:accessToken] ];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:@"GET"];
    [request addValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                if(statusCode!=200) {
                    NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    NSLog(@"json %@",results);
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [self moveToParentClasswithData:results withError:error withMsgType:msgType];
                    });
                }else if((statusCode==200)&(data != nil)){
                    NSDictionary* results = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [self moveToParentClasswithData:results withError:nil withMsgType:msgType];
                    });

                    NSLog(@"json %@",results);
                }
            }
        }];
        [task resume];
    });

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//
////    manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: requestUrlString ] sessionConfiguration:config];
//
//    NSLog(@"access %@",[[NSUserDefaults standardUserDefaults]objectForKey:accessToken]);
//    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults]objectForKey:accessToken] forHTTPHeaderField:@"Authorization"];
//    
//    [manager GET:requestUrlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        [self moveToParentClasswithData:responseObject withError:nil withMsgType:msgType];
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [self moveToParentClasswithData:nil withError:error withMsgType:msgType];
//        
//    }];

}

-(void) requestMethodForPost : (NSString *) requestUrlString withData : (id) dataToBePosted withTag : (int) webserviceMsgType
{
    
//    NSError * error;
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
//    NSURL *url = [NSURL URLWithString:requestUrlString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                       timeoutInterval:30.0];
//    
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Accept"];
//
//    [request setHTTPMethod:@"POST"];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:dataToBePosted options:0 error:&error];
//    [request setHTTPBody:postData];
//    
//    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *errorInResponse)
//                                          {
//                                            dispatch_async(dispatch_get_main_queue(), ^{
//                                                  [self moveToParentClasswithData:data withError:error withMsgType:webserviceMsgType];
//                                              });
//                                              
//                                          }];
//    
//    [postDataTask resume];
   
    
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestUrlString]];
//    // Set post method
//    [request setHTTPMethod:@"POST"];
//    // Set header to accept JSON request
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // Your params
    // Change your 'params' dictionary to JSON string to set it into HTTP
    // body. Dictionary type will be not understanding by request.
//    NSString *jsonString = [self getJSONStringWithDictionary:params];
    
    // And finally, add it to HTTP body and job done.
//    [request setHTTPBody:[dataToBePosted dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *authValue = [NSString stringWithFormat:@"bearer %@",[[NSUserDefaults standardUserDefaults]objectForKey:accessToken] ];
    
    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager POST:requestUrlString parameters:dataToBePosted success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSLog(@"%@", responseObject);
        [self moveToParentClasswithData:responseObject withError:nil withMsgType:webserviceMsgType];

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@", error);
                [self moveToParentClasswithData:nil withError:error withMsgType:webserviceMsgType];

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //    NSDictionary *params = @{@"Email": _emailId};
//
//    NSString *authValue = [NSString stringWithFormat:@"bearer %@",[[NSUserDefaults standardUserDefaults]objectForKey:accessToken] ];
//
//    [manager.requestSerializer setValue:authValue forHTTPHeaderField:@"Authorization"];
//    [manager.requestSerializer setTimeoutInterval:60.0];

//    [manager POST:requestUrlString parameters:dataToBePosted progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        [self moveToParentClasswithData:responseObject withError:nil withMsgType:webserviceMsgType];
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        [self moveToParentClasswithData:nil withError:error withMsgType:webserviceMsgType];
//
//    }];

}

-(void) moveToParentClasswithData : (id) jsonParsedData withError : (NSError *) errorReceived withMsgType: (int) msgType
{
    if (jsonParsedData == nil)
    {
        if ([self.delegateObject respondsToSelector:@selector(errorRecieved:withMsgType:)])
        {
            [self.delegateObject errorRecieved:[errorReceived localizedDescription] withMsgType:msgType];
        }
    }
    else
    {
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonParsedData options:0 error:nil];
        NSLog(@"JSON %@", jsonParsedData);
        
        id requestStatusS=[jsonParsedData objectForKey:@"requestStatus"];
        NSLog(@"%@",requestStatusS);
        
        if ([[jsonParsedData objectForKey:@"Message"] isEqualToString:@"Authorization has been denied for this request."]) {
            NSLog(@"logout");
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"Logout"
             object:nil];

        }
        else
        {
        if ([self.delegateObject respondsToSelector:@selector(dataIsRecieved:withMsgType:)])
        {
            [self.delegateObject dataIsRecieved:jsonParsedData withMsgType:msgType];
        }
        }
    }
    
}

@end
