//
//  MSTPlugSocket.m
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTPlugSocket.h"

@implementation MSTPlugSocket

- (id)initWithType:(NSString*)type{
    self = [super init];
    self.socketType = type;
    self.isPoweredOn = NO;
    self.current = 0;
    return self;
}

@end
