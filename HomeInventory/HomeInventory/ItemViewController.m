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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray * items = [[ItemStore sharedStore] allItems];
    BNRItem * item = items[indexPath.row];
    
    cell.textLabel.text = item.description;
    
    return cell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

@end
