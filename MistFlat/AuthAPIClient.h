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

@property (nonatomic) id devices;

+ (AuthAPIClient *)sharedClient;

//- (void)loginWithUsername:(NSString *)username                Password:(NSString *)password;
- (NSURLSessionDataTask *)loginWithUsername:(NSString *)username password:(NSString *)password completion:( void (^)(NSArray *results, NSError *error) )completion;
- (NSURLSessionDataTask *)signupWithUsername:(NSString *)username password:(NSString *)password nickname:(NSString*)nickname completion:( void (^)(NSArray *results, NSError *error) )completion;
- (BOOL)isAccessTokenExpired;
//- (void)refreshPlugPanelDeckWithCompletion:( void (^)(NSArray *results, NSError *error) )completion;
- (void)refreshPlugPanelDeck;
- (void)addPlugPanelItem:pinOfPlugPanel;
- (void)setBoard:(NSString*)boardHandle hub:(NSNumber*)hubId statusIsOn:(BOOL)on ;
@end
