//
//  BNRItem.m
//  HomeInventory
//
//  Created by New on 9/10/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem

@dynamic itemName;
@dynamic serialNumber;
@dynamic valueInDollars;
@dynamic dateCreated;
@dynamic itemKey;
@dynamic thumbnail;
@dynamic orderingValue;
@dynamic assetType;

// sorry github for tricking you like this, must keep up appearances

-(void)awakeFromInsert
{
    [super awakeFromInsert];
    
    self.dateCreated = [NSDate date];
    
    // Create an NSUUID object and get its string representation
    NSUUID * uuid = [[NSUUID alloc] init];
    NSString * key = [uuid UUIDString];
    self.itemKey = key;
}

-(void)setThumbnailFromImage:(UIImage *)image
{
    CGSize origImageSize = image.size;
    
    // the rectangle of the thumbnail
    CGRect newRect = CGRectMake(0, 0, 40, 40);
    
    // Figure out a scaling ratio to make sure we maintain the same aspect ratio
    float ratio = MAX(newRect.size.width / origImageSize.width,
                      newRect.size.height / origImageSize.height);
    
    //create a transparent bitmap context with a scaling factor
    // equal to that of the screen
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    
    //Create a path that is a rounded rectangle
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    
    // make all subsequent drawing clip to this rounded rect
    [path addClip];
    
    // center the image in the thumbnail rect
    CGRect projectRect;
    projectRect.size.width = ratio * origImageSize.width;
    projectRect.size.height = ratio * origImageSize.height;
    projectRect.origin.x = (newRect.size.width - projectRect.size.width) / 2.0;
    projectRect.origin.y = (newRect.size.height = projectRect.size.height) / 2.0;
    
    //draw the image on it
    [image drawInRect:projectRect];
    
    // GEt the image from the image context; keep it as our thumbnail
    UIImage * smallImage = UIGraphicsGetImageFromCurrentImageContext();
    self.thumbnail = smallImage;
    
    // clean up image context resources
    UIGraphicsEndImageContext();
}

@end
