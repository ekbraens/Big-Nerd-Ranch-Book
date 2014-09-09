//
//  ItemViewController.m
//  HomeInventory
//
//  Created by New on 8/21/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import "DetailViewController.h"
#import "ItemViewController.h"
#import "ItemStore.h"
#import "BNRItem.h"
#import "ItemCell.h"

@interface ItemViewController ()

@property (nonatomic, strong) IBOutlet UIView * headerView;

@end

@implementation ItemViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.navigationItem.title = @"Home Organizer";
        
        UIBarButtonItem * bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        // set this new bar button to the right
        self.navigationItem.rightBarButtonItem = bbi;
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem;
    }
//    for (int i = 0; i < 5; ++i)
//    {
//        [[ItemStore sharedStore] createItem];
//    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController * dvc = [[DetailViewController alloc] init];
    
    [self.navigationController pushViewController:dvc animated:YES];
    
    NSArray * items = [[ItemStore sharedStore] allItems];
    BNRItem * selectedItem = items[indexPath.row];
    
    dvc.item = selectedItem;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[ItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get new or recycled cell
    ItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    NSArray * items = [[ItemStore sharedStore] allItems];
    BNRItem * item = items[indexPath.row];
    
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    cell.thumbnailView.image = item.thumbnail;
    
    return cell;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load the nib file
    UINib * nib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
    
    // Register the NIB, which contains the cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"ItemCell"];
}

//- (UIView *)headerView
//{
//    if (!_headerView)
//    {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil];
//    }
//    
//    return _headerView;
//}

-(IBAction)addNewItem:(id)sender
{
    BNRItem * newItem = [[ItemStore sharedStore] createItem];
    
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    // insert this new row into the table view
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray * items = [[ItemStore sharedStore] allItems];
        BNRItem * item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Remove";
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItem:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

//-(IBAction)toggleEditingMode:(id)sender
//{
//    if (self.isEditing)
//    {
//        [sender setTitle:@"Edit" forState:UIControlStateNormal];
//        
//        [self setEditing:NO animated:YES];
//    }
//    else
//    {
//        [sender setTitle:@"Done?" forState:UIControlStateNormal];
//        
//        [self setEditing:YES animated:YES];
//    }
//}
@end
