//
//  AuthAPIClient.h
//  AuthClient
//
//  Created by Ben Scheirman on 11/4/12.
//  Copyright (c) 2012 nsscreencast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AuthAPIClient : AFHTTPSessionManager

+ (AuthAPIClient *)sharedClient;

//- (void)loginWithUsername:(NSString *)username                Password:(NSString *)password;
- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:( void (^)(NSArray *results, NSError *error) )completion;
- (NSURLSessionDataTask *)getProfileContent:( void (^)(NSArray *results, NSError *error) )completion;

@end
