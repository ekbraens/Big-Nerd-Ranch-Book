//
//  HypnoViewController.m
//  ChapSix
//
//  Created by New on 8/19/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "HypnoViewController.h"
#import "HypnosisView.h"

@interface HypnoViewController () <UITextFieldDelegate>
@end

@implementation HypnoViewController

-(void)loadView
{
    // create the view for the controller
    HypnosisView * hypnoView = [[HypnosisView alloc] init];
    
    // text field to type things into
    // with specifications
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField * textField = [[UITextField alloc] initWithFrame:textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"talk existential to me";
    textField.returnKeyType = UIReturnKeyDone;
    
    // self should respond to any actions in the textfield
    textField.delegate = self;
    
    [hypnoView addSubview:textField];
    
    // set it as THE view for this controller
    self.view = hypnoView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    
    // clear the text field typed into and make the keyboard go away
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
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

-(void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 5; ++i)
    {
        UILabel * messageLabel = [[UILabel alloc] init];
        
        // make the message label clear background and white text,
        // for creepy looks, fit to words typed
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        
        // make sure these messages dont go past the edges of the screen
        int width = (int)(self.view.bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        int height = (int)(self.view.bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        // add the label to the view with specifications
        CGRect messageFrame = messageLabel.frame;
        messageFrame.origin = CGPointMake(x, y);
        messageLabel.frame = messageFrame;
        [self.view addSubview:messageLabel];
        
        // give these labels motion effects
        UIInterpolatingMotionEffect * motionEffect;
        
        // this is for the x axis
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                            type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        // and this is fo the y axis
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                            type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

@end
