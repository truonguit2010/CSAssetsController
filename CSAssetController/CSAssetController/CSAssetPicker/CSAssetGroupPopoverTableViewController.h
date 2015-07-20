//
//  CSAssetGroupPopoverTableViewController.h
//  CSAssetController
//
//  Created by truongps on 7/19/15.
//  Copyright (c) 2015 CS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol CSAssetGroupPopoverViewControllerDelegate;

@interface CSAssetGroupCell : UITableViewCell

@property (nonatomic, strong) UIImageView* iconImageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* desLabel;
@property (nonatomic, strong) UIImageView* rightIconImageView;

@end

@interface CSAssetGroupPopoverTableViewController : UIViewController

@property (nonatomic, strong) NSArray* assetGroup;
@property (nonatomic, strong) ALAssetsGroup* selectedGroup;

@property (nonatomic, weak) id <CSAssetGroupPopoverViewControllerDelegate> delegate;

@end

@protocol CSAssetGroupPopoverViewControllerDelegate <NSObject>

- (void) assetGroupPopover:(CSAssetGroupPopoverTableViewController*)controller didSelectAsset:(ALAssetsGroup*) group;

@end