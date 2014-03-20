//
//  MSTAction.m
//  MistFlat
//
//  Created by Zhou Yang on 3/20/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTAction.h"

@implementation MSTAction

+ (MSTAction *)sharedClient {
    static MSTAction *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MSTAction alloc]init];
    });
    return _sharedClient;
}
/*
 - (void)addPlugPanel:(MSTPlugPanel*)panel{
 NSMutableArray* newPlugPanelDeck = [[NSMutableArray alloc]initWithArray:self.plugPanelDeck];
 [newPlugPanelDeck addObject:panel];
 self.plugPanelDeck = newPlugPanelDeck;
 }*/

- (void)setActions:(id)actions{
    _actions = actions;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"action-changed" object:self];
    NSLog(@"actonReset:");
}

@end
