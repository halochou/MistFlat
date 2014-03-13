//
//  MSTPlugPanel.m
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTPlugPanel.h"
#import "MSTPlugSocket.h"

@interface MSTPlugPanel ()

@end

@implementation MSTPlugPanel

- (id)init{
    self = [super init];
    self.plugSockets = [[NSArray alloc]init];
    return self;
}

- (id)initWithId:(NSString*)panelId {
    self = [super init];
    self.panelId = panelId;
    self.plugSockets = [[NSArray alloc]init];
    return self;
}

- (id)initWithId:(NSString*)panelId numberOfSockets:(NSInteger)num{
    self = [super init];
    self.panelId = panelId;
    NSMutableArray* newPlugSockets = [[NSMutableArray alloc]init];
    [self addSocketWithNumber:num socketType:@"Normal"];
    self.plugSockets = newPlugSockets;
    return self;
}

- (void)addSocketWithNumber:(NSInteger)num socketType:(NSString*)socketType {
    NSMutableArray* newPlugSockets = [[NSMutableArray alloc]init];
    for(int i = 1;i <= num;i ++){
        [newPlugSockets addObject:[[MSTPlugSocket alloc]initWithType:socketType]];
    }
    self.plugSockets = newPlugSockets;
}

@end
