//
//  MSTPlugPanel.h
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSTPlugSocket.h"

@interface MSTPlugPanel : NSObject

@property (nonatomic) NSArray* plugSockets;
@property (nonatomic) NSString* panelId;

- (id)initWithId:(NSString*)panelId;
- (id)initWithId:(NSString*)panelId numberOfSockets:(NSInteger)num;
- (void)addSocketWithNumber:(NSInteger)num socketType:(NSString*)socketType;
@end
