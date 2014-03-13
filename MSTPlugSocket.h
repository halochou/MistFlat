//
//  MSTPlugSocket.h
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSTPlugSocket : NSObject

@property (nonatomic) NSString* socketType;
@property (nonatomic) BOOL isPoweredOn;
@property (nonatomic) NSNumber* current;

- (id)initWithType:(NSString*)type;

@end
