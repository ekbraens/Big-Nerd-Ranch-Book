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
    
    // Create full path for image
    NSString * imagePath = [self imagePathForKey:key];
    
    // Turn image into jpeg data
    NSData * data = UIImageJPEGRepresentation(image, 0.5);
    
    // write it to full path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    UIImage * result = self.dictionary[key];
    
    if (!result)
    {
        NSString * imagePath = [self imagePathForKey:key];
        
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // if wefound an image on the file system, place it in the cache
        if (result)
        {
            self.dictionary[key] = result;
        }
        else
        {
            NSLog(@"error: unable to find %@", [self imagePathForKey:key]);
        }
    }
    return result;
}

-(void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    
    [self.dictionary removeObjectForKey:key];
    
    NSString * imagePath =  [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

-(NSString *)imagePathForKey:(NSString *)key
{
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString * documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
