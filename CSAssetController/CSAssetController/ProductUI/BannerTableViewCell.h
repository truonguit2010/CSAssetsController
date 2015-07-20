//
//  BannerTableViewCell.h
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"

extern NSString *const BANNER_TABLE_VIEW_CELL_ID;

@interface BannerTableViewCell : UITableViewCell

@property (strong, nonatomic) BannerView* bannerView;

+ (void) registerFor:(UITableView*) tableView;

@end
