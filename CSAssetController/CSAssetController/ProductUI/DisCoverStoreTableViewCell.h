//
//  DisCoverStoreTableViewCell.h
//  Capsule
//
//  Created by truongps on 7/4/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverStoreView.h"

extern NSString *const DISCOVER_STORE_VIEW_CELL_ID;

@interface DisCoverStoreTableViewCell : UITableViewCell

@property (nonatomic, strong) DiscoverStoreView* discoverStoreView;

+ (void) registerCellFor:(UITableView*) tableView;

@end
