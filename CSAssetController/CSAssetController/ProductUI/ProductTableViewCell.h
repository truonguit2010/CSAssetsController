//
//  ProductTableViewCell.h
//  Capsule
//
//  Created by truongps on 7/6/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductView.h"

extern NSString *const PRODUCT_TABLE_VIEW_CELL_ID;

@interface ProductTableViewCell : UITableViewCell
@property (nonatomic, strong) UICollectionView* collectionView;

+ (void) registerCellFor:(UITableView*)tableView;

@end

// 
@interface ProductCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ProductView* productView;

@end
