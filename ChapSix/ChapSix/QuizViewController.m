//
//  QuizViewController.m
//  ChapSix
//
//  Created by New on 8/19/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "QuizViewController.h"

@implementation QuizViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // set the title
        self.tabBarItem.title = @"Quiz Me!";
        
        // get the image from image.xcassets
        // UIImage * i = [UIImage imageNamed:@"T"];
        
        // set the tabBarItem to that image
        // self.tabBarItem.image = i;
    }
    
    return self;
}


@end
