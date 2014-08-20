//
//  HypnoViewController.m
//  ChapSix
//
//  Created by New on 8/19/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "HypnoViewController.h"
#import "HypnosisView.h"

@implementation HypnoViewController

-(void)loadView
{
    // create the view for the controller
    HypnosisView * hypnoView = [[HypnosisView alloc] init];
    
    // set it as THE view for this controller
    self.view = hypnoView;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // set the tab bar item's title
        self.tabBarItem.title = @"Hypnotize";
        
        //create a UIImage from a file
        // this will use the x2 on retina display
        UIImage * i = [UIImage imageNamed:@"Hypno"];
        
        // assign that image to this tabBarItem
        self.tabBarItem.image = i;
    }
    
    return self;
}

@end
