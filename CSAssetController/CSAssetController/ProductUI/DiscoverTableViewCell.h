//
//  DiscoverTableViewCell.h
//  CSAssetController
//
//  Created by truongps on 7/18/15.
//  Copyright (c) 2015 CS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverView : UIView

@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIButton* buttonBottom;

@end

@interface DiscoverTableViewCell : UITableViewCell

@end
