//
//  MSTAction.h
//  MistFlat
//
//  Created by Zhou Yang on 3/20/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTAction : NSObject

@property (nonatomic) NSArray* actions;
+ (MSTAction *)sharedClient;

@end
