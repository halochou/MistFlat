//
//  AuthAPIClient.m
//  AuthClient
//
//  Created by Ben Scheirman on 11/4/12.
//  Copyright (c) 2012 nsscreencast. All rights reserved.
//

#import "AuthAPIClient.h"

@interface AuthAPIClient ()

@property (nonatomic) BOOL isLogin;
@property (nonatomic) CredentialStore *store;
@end


@implementation AuthAPIClient

+ (AuthAPIClient *)sharedClient {
    static AuthAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@""];    //http://mistweb.duapp.com"];
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

#pragma mark - login & signup
- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:( void (^)(NSArray *results, NSError *error) )completion{
    id params = @{
                  @"username": username,
                  @"password": password,
                  //@"nickname": @"nickname"
                  };
    NSURLSessionDataTask *task = [self POST:@"http://mistweb.duapp.com/api/user/login"
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
                                           NSLog(@"Received HTTP %ld", httpResponse.statusCode);
                                       }
                                       
                                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           completion(nil, error);
                                       });
                                   }];
    return task;
    
}

- (NSURLSessionDataTask *)signupWithUsername:(NSString *)username password:(NSString *)password nickname:(NSString*)nickname completion:( void (^)(NSArray *results, NSError *error) )completion{
    id params = @{
                  @"username": username,
                  @"password": password,
                  @"nickname": nickname
                  };
    NSURLSessionDataTask *task = [self POST:@"http://mistweb.duapp.com/api/user/register"
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
                                            NSLog(@"Received HTTP %ld", httpResponse.statusCode);
                                        }
                                        
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            completion(nil, error);
                                        });
                                    }];
    return task;
    
}

//Not tested
- (BOOL)isAccessTokenExpired {
    __block BOOL success = YES;
    [self GET:@"/api/user/detail" parameters:nil
      success:^(NSURLSessionDataTask *task, id responseObject){if(responseObject[@"status"] == 0){success = NO;}}
      failure:nil];
    return success;
}

- (void)setAuthTokenHeader {
    CredentialStore *store = [[CredentialStore alloc] init];
    NSString *authToken = [store authToken];
    NSLog(@"Token Stored:%@",authToken);
    [self.requestSerializer setValue:authToken forHTTPHeaderField:@"access_token"];
}

- (void)tokenChanged:(NSNotification *)notification {
    [self setAuthTokenHeader];
}

#pragma mark plugPanelDeck
/*
- (void)refreshPlugPanelDeckWithCompletion:( void (^)(NSArray *results, NSError *error) )completion{
    [self POST:@"http://mistweb.duapp.com/api/user/boardall"
                                 parameters:nil
                                    success:^(NSURLSessionDataTask *task, id responseObject) {
                                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
                                        //NSLog(@"STATUS:%d",httpResponse.statusCode);
                                        if (httpResponse.statusCode == 200) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                completion(responseObject[@"boards"], nil);
                                            });
                                        } else {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                completion(nil, nil);
                                            });
                                            NSLog(@"Received: %@", responseObject);
                                            NSLog(@"Received HTTP %ld", httpResponse.statusCode);
                                        }
                                        
                                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            completion(nil, error);
                                        });
                                    }];
}*/

- (void)refreshPlugPanelDeck {
    [self GET:@"http://mistweb.duapp.com/api/user/boardall"
                                parameters:nil
                                   success:^(NSURLSessionDataTask *task, id responseObject){
                                       NSLog(@"refreshPlugPanelDeck");
                                       [[MSTPlugPanelDeck sharedClient]setPlugPanelDeck:responseObject[@"boards"]];
                                   }
                                   failure:^(NSURLSessionDataTask *task, NSError *error){
                                   }
                                  ];
    
}


- (void)addPlugPanelItem:(NSString*) pinOfPlugPanel {
    id params = @{
                  @"board_pin": pinOfPlugPanel
                  };

    [self POST:@"http://mistweb.duapp.com/api/user/addboard"
    parameters:params
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
           if (httpResponse.statusCode == 200) {
               NSLog(@"Received: %@", responseObject);
           } else {
               NSLog(@"Received: %@", responseObject);
               NSLog(@"Received HTTP %ld", httpResponse.statusCode);
           }
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"%@",error);
       }];
    [self refreshPlugPanelDeck];
    //return success;
}

- (void)setBoard:(NSString*)boardHandle hub:(NSNumber*)hubId statusIsOn:(BOOL)on {
    id params = @{
                  @"board_handle": boardHandle,
                  @"hub_id": hubId,
                  @"work": [NSNumber numberWithBool:on]
                  };
    
    [self POST:@"http://mistserver.duapp.com/iosapi"
    //[self POST:@"http://127.0.0.1:18080/iosapi"
    parameters:params
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
           if (httpResponse.statusCode == 200) {
               NSLog(@"Received: %@", responseObject);
           } else {
               NSLog(@"Received: %@", responseObject);
               NSLog(@"Received HTTP %ld", httpResponse.statusCode);
           }
           
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"%@",error);
       }];
    [self refreshPlugPanelDeck];
    //return success;
}

#pragma mark - actions
//not tested
- (void)refreshActions {
    [self GET:@"http://mistserver.duapp.com/api/getActions"
   parameters:nil
      success:^(NSURLSessionDataTask *task, id responseObject){
          NSLog(@"refreshActions");
          [[MSTAction sharedClient]setActions:responseObject[@"actions"]];
      }
      failure:^(NSURLSessionDataTask *task, NSError *error){
      }
     ];
}
//not tested
- (void)addAction:(NSArray*) actions {
    NSDictionary* params = @{@"actions": actions};
    [self POST:@"http://mistserver.duapp.com/api/addAction"
    parameters:params
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
           if (httpResponse.statusCode == 200) {
               NSLog(@"Received: %@", responseObject);
           } else {
               NSLog(@"Received: %@", responseObject);
               NSLog(@"Received HTTP %ld", httpResponse.statusCode);
           }
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           NSLog(@"%@",error);
       }];
    [self refreshActions];
}

@end
