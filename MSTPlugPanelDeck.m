//
//  MSTPlugPanelDeck.m
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import "MSTPlugPanelDeck.h"
//#import "MSTPlugPanel.h"

@interface MSTPlugPanelDeck ()

@end

@implementation MSTPlugPanelDeck

+ (MSTPlugPanelDeck *)sharedClient {
    static MSTPlugPanelDeck *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MSTPlugPanelDeck alloc]init];
    });
    return _sharedClient;
}
/*
- (void)addPlugPanel:(MSTPlugPanel*)panel{
    NSMutableArray* newPlugPanelDeck = [[NSMutableArray alloc]initWithArray:self.plugPanelDeck];
    [newPlugPanelDeck addObject:panel];
    self.plugPanelDeck = newPlugPanelDeck;
}*/

- (void)setPlugPanelDeck:(id)plugPanelDeck{
    _plugPanelDeck = plugPanelDeck;

    [[NSNotificationCenter defaultCenter] postNotificationName:@"device-changed" object:self];
    NSLog(@"modelReset:");
}

@end
