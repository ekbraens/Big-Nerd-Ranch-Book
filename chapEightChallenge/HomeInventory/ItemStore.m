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
@property (nonatomic) NSMutableArray * privateUnderFifty;
@property (nonatomic) NSMutableArray * privateOverFifty;

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
        _privateOverFifty = [[NSMutableArray alloc] init];
        _privateUnderFifty = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BNRItem *)createItem
{
    BNRItem * item = [BNRItem randomItem];
    
    [self.privateItems addObject:item];
    
    if (item.valueInDollars < 50)
    {
        [self.privateUnderFifty addObject:item];
    }
    else
    {
        [self.privateOverFifty addObject:item];
    }
    
    return item;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(NSArray *)underFifty
{
    return self.privateUnderFifty;
}

-(NSArray *)overFifty
{
    return self.privateOverFifty;
}

@end
