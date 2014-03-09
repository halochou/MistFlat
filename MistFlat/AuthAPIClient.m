//
//  AuthAPIClient.m
//  AuthClient
//
//  Created by Ben Scheirman on 11/4/12.
//  Copyright (c) 2012 nsscreencast. All rights reserved.
//

#import "AuthAPIClient.h"
#import "CredentialStore.h"
#import "AFHTTPRequestOperationManager.h"


@interface AuthAPIClient ()

@property (nonatomic) BOOL isLogin;

@end


@implementation AuthAPIClient

+ (AuthAPIClient *)sharedClient {
    static AuthAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://nsscreencast-auth-server.herokuapp.com"];
        //NSURL *baseURL = [NSURL URLWithString:@"http://127.0.0.1:9000"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //[config setHTTPAdditionalHeaders:@{ @"User-Agent" : @"TuneStore iOS 1.0"}];
        
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
                                                          diskCapacity:50 * 1024 * 1024
                                                              diskPath:nil];
        
        [config setURLCache:cache];
        
        _sharedClient = [[AuthAPIClient alloc] initWithBaseURL:baseURL
                                         sessionConfiguration:config];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        [_sharedClient setAuthTokenHeader];
        
        [[NSNotificationCenter defaultCenter] addObserver:_sharedClient
                                                 selector:@selector(tokenChanged:)
                                                     name:@"token-changed"
                                                   object:nil];

    });
    
    return _sharedClient;
}



//- (NSURLSessionDataTask *)searchForTerm:(NSString *)term completion:( void (^)(NSArray *results, NSError *error) )completion
- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:( void (^)(NSArray *results, NSError *error) )completion{
    id params = @{
                  @"username": username,
                  @"password": password
                  };
    NSURLSessionDataTask *task = [self POST:@"/auth/login.json"
                                 parameters:params
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       //NSLog(@"STATUS:%d",httpResponse.statusCode);
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject, nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
    
}

- (NSURLSessionDataTask *)getProfileContent:( void (^)(NSArray *results, NSError *error) )completion {
    NSURLSessionDataTask *task = [self GET:@"/home/index.json"
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject) {
                                       [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                       NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                       if (httpResponse.statusCode == 200) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(responseObject, nil);
                                           });
                                       } else {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               completion(nil, nil);
                                           });
                                           NSLog(@"Received: %@", responseObject);
                                           NSLog(@"Received HTTP %d", httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
    
}


- (void)setAuthTokenHeader {
    CredentialStore *store = [[CredentialStore alloc] init];
    NSString *authToken = [store authToken];
    NSLog(@"Token Stored:%@",authToken);
    //[self.requestSerializer setAuthorizationHeaderFieldWithToken:authToken];
    [self.requestSerializer setValue:authToken forHTTPHeaderField:@"auth_token"];
}

- (void)tokenChanged:(NSNotification *)notification {
    [self setAuthTokenHeader];
}

@end
