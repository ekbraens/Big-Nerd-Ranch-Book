//
//  DetailViewController.m
//  HomeInventory
//
//  Created by New on 8/27/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "ChangeDateViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialField;
@property (weak, nonatomic) IBOutlet UITextField *costField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    // sets the navigation bar title to the name of the item
    self.navigationItem.title = self.item.itemName;
    
    self.nameField.text = self.item.itemName;
    self.serialField.text = self.item.serialNumber;
    self.costField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    static NSDateFormatter * dateFormatter = nil;
    if (!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    UIBarButtonItem * bbi = [[UIBarButtonItem alloc] initWithTitle:@"Date" style:UIBarButtonItemStylePlain target:self action:@selector(changeDate:)];
    
    self.navigationItem.rightBarButtonItem = bbi;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.costField resignFirstResponder];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self.view endEditing:YES];
    
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialField.text;
    self.item.valueInDollars = [self.costField.text intValue];
}

-(IBAction)changeDate:(id)sender
{
    ChangeDateViewController * cdvc = [[ChangeDateViewController alloc] init];
    
    [self.navigationController pushViewController:cdvc animated:YES];
    
    cdvc.item = self.item;
}

@end
