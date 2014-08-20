//
//  TimerViewController.m
//  ChapSix
//
//  Created by New on 8/19/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker * datePicker;

@end

@implementation TimerViewController

-(IBAction)addReminder:(id)sender
{
    NSDate * date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UILocalNotification * note = [[UILocalNotification alloc] init];
    note.alertBody = @"HYPNOTIZE ME!";
    note.fireDate = date;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // set the title
        self.tabBarItem.title = @"Remind Me!";
        
        // get the image from image.xcassets
        UIImage * i = [UIImage imageNamed:@"Time"];
        
        // set the tabBarItem to that image
        self.tabBarItem.image = i;
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

@end
