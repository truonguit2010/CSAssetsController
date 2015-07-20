//
//  ProductInGridCollectionViewCell.h
//  Capsule
//
//  Created by truongps on 7/4/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInGrid.h"

extern NSString *const PRODUCT_IN_GRID_COLLECTION_VIEW_CELL_ID;

@interface ProductInGridCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ProductInGrid* productView;

+ (void) registerFor:(UICollectionView*) collectionView;

@end
