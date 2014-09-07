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

+(instancetype)sharedStore;
-(BNRItem *)createItem;
-(void)removeItem:(BNRItem *)item;
-(void)moveItem:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
-(BOOL)saveChanges;

@end
