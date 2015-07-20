//
//  ProductView.h
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductView : UIView

@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* labelPrice;
@property (nonatomic, strong) UILabel* labelOldPrice;
@property (nonatomic, strong) UIButton* buttonViewMore;
@property (nonatomic, strong) UIButton* buttonAddToWishList;
@property (nonatomic, strong) UIButton* buttonAddToCart;

@end
