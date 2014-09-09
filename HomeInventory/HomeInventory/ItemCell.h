//
//  ItemCell.h
//  HomeInventory
//
//  Created by New on 9/8/14.
//  Copyright (c) 2014 New. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
