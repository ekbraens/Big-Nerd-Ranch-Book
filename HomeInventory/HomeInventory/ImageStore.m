//
//  ImageStore.m
//  HomeInventory
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore()

@property (nonatomic, strong) NSMutableDictionary * dictionary;

@end

@implementation ImageStore

+ (instancetype)sharedStore
{
    static ImageStore * sharedStore = nil;
    
    if (!sharedStore)
    {
        sharedStore = [[ImageStore alloc] initPrivate];
    }
    return sharedStore;
}

-(instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use sharedStore" userInfo:nil];
    
    return nil;
}

-(instancetype)initPrivate
{
    self = [super init];
    
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    [self.dictionary setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key
{
    return [self.dictionary objectForKey:key];
}

-(void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
}

@end
