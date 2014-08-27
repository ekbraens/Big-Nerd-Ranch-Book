//
//  ItemStore.m
//  HomeInventory
//
//  Created by New on 8/21/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "ItemStore.h"
#import "BNRItem.h"

@interface ItemStore ()

@property (nonatomic) NSMutableArray * privateItems;

@end

@implementation ItemStore

+(instancetype)sharedStore
{
    static ItemStore * sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use [sharedStore]" userInfo:nil];
    
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BNRItem *)createItem
{
    BNRItem * item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    return item;
}

-(void)removeItem:(BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}

-(void)moveItem:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex)
    {
        return;
    }
    else
    {
        BNRItem * item = [self.privateItems objectAtIndex:fromIndex];
    
        [self.privateItems removeObjectAtIndex:fromIndex];
    
        [self.privateItems insertObject:item atIndex:toIndex];
    }
}

-(NSArray *)allItems
{
    return self.privateItems;
}

@end
