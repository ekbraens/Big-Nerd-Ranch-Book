//
//  ImageStore.h
//  HomeInventory
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
