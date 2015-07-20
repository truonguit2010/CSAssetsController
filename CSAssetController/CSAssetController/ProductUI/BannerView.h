//
//  BannerView.h
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYTPhoto.h"

@interface CSPhoto : NSObject<NYTPhoto>

@property (nonatomic) UIImage *image;
@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) NSAttributedString *attributedCaptionTitle;
@property (nonatomic) NSAttributedString *attributedCaptionSummary;
@property (nonatomic) NSAttributedString *attributedCaptionCredit;

@end

@interface BannerView : UIView

@property (nonatomic, strong) UICollectionView* collectionView;

@end
