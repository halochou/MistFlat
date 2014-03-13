//
//  MSTAccount.m
//  MistFlat
//
//  Created by Zhou Yang on 3/13/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTAccount.h"

@implementation MSTAccount

+ (MSTAccount *)sharedClient {
    static MSTAccount *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient.username = @"";
        //_sharedClient = [[MSTPlugPanelDeck alloc]init];
    });
    return _sharedClient;
}

@end
