//
//  ItemStore.h
//  HomeInventory
//
//  Created by New on 8/21/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface ItemStore : NSObject

@property (nonatomic, readonly) NSArray * allItems;
@property (nonatomic, readonly) NSArray * overFifty;
@property (nonatomic, readonly) NSArray * underFifty;

+(instancetype)sharedStore;
-(BNRItem *)createItem;

@end
