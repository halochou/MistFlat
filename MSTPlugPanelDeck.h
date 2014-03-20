//
//  MSTPlugPanelDeck.h
//  MistFlat
//
//  Created by Zhou Yang on 3/11/14.
//  Copyright (c) 2014 Zhou Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MSTPlugPanel.h"

@interface MSTPlugPanelDeck : NSObject

@property (nonatomic) NSArray* plugPanelDeck;

+ (MSTPlugPanelDeck *)sharedClient;
//- (void)addPlugPanel:(MSTPlugPanel*)panel;

@end
