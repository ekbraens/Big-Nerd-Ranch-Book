//
//  ItemViewController.m
//  HomeInventory
//
//  Created by New on 8/21/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"

@implementation ItemViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    for (int i = 0; i < 5; ++i)
    {
        [[ItemStore sharedStore] createItem];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [[[ItemStore sharedStore] underFifty] count];
    }
    if (section == 1)
    {
        return [[[ItemStore sharedStore] overFifty] count];
    }
    if (section == 2)
    {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        NSArray * cheapItems = [[ItemStore sharedStore] underFifty];
        BNRItem * item = cheapItems[indexPath.row];
    
        cell.textLabel.text = item.description;
    
        return cell;
    }
    
    if (indexPath.section == 1)
    {
        NSArray * expensiveItems = [[ItemStore sharedStore] overFifty];
        BNRItem * item = expensiveItems[indexPath.row];
        
        cell.textLabel.text = item.description;
        
        return cell;
    }
    
    if (indexPath.section == 2)
    {
        cell.textLabel.text = @"No More Items!";
        return cell;
    }
    
    return 0;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end
