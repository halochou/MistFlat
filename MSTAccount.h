//
//  MSTAccount.h
//  MistFlat
//
//  Created by Zhou Yang on 3/13/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTAccount : NSObject

@property (nonatomic) NSString* username;
//@property (nonatomic) NSString* username;

+ (MSTAccount *)sharedClient;

@end
