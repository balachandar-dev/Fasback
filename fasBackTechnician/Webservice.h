//
//  Webservice.h
//  fasBackTechnician
//
//  Created by User on 22/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol webProtocol  <NSObject>

@required

-(void)dataIsRecieved :(id)parsedData withMsgType : (int) msgType;//here data is recieved
-(void)errorRecieved:(NSString * )errorString withMsgType : (int) msgType;//if error occured its recieved here

@end

@interface Webservice : NSObject <NSURLSessionDelegate,NSURLConnectionDelegate>

@property(nonatomic) id <webProtocol> delegateObject;


+(NSString *)webserviceLink;
-(void)requestMethod:(NSString *)requestUrlString withMsgType : (int) msgType;
-(void) requestMethodForPost : (NSString *) requestUrlString withData : (id) dataToBePosted withTag : (int) webserviceMsgType;

@end
