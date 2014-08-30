//
//  ChangeDateViewController.h
//  HomeInventory
//
//  Created by New on 8/30/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItem.h"

@interface ChangeDateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *dateChanger;
@property (nonatomic, strong) BNRItem * item;

@end
