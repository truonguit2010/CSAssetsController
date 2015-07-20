//
//  BannerView.m
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "BannerView.h"
#import "NYTPhotosViewController.h"

static NSString *const CELL_ID = @"CELL_ID";
static NSString *const TAG = @"BannerView";

@implementation CSPhoto


@end

@interface BannerView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, NYTPhotosViewControllerDelegate>

@property (nonatomic, strong) NSLayoutConstraint* topCollectionViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomCollectionViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leadingCollectionViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* trailingCollectionViewConstraint;

@property (nonatomic, strong) NSMutableArray* bannerArray;

@end

@implementation BannerView

- (instancetype)init {
    if (self = [super init]) {
        
        self.bannerArray = [[NSMutableArray alloc] init];
        for (int i = 1; i < 6; i++) {
            [self.bannerArray addObject:[NSString stringWithFormat:@"banner%d", i]];
        }
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.collectionView];
        
        self.topCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeTop
                                                                       multiplier:1
                                                                         constant:0];
        self.bottomCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
        self.leadingCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:0];
        self.trailingCollectionViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeTrailing
                                                                       multiplier:1
                                                                         constant:0];
        [self addConstraint:self.topCollectionViewConstraint];
        [self addConstraint:self.bottomCollectionViewConstraint];
        [self addConstraint:self.leadingCollectionViewConstraint];
        [self addConstraint:self.trailingCollectionViewConstraint];
    }
    return self;
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bannerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    NSString* m = [self.bannerArray objectAtIndex:indexPath.row];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:m]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray* bs = [[NSMutableArray alloc] init];
    for (int i = 1; i < 6; i++) {
        NSString* imageName = [NSString stringWithFormat:@"banner%d", i];
        UIImage* image = [UIImage imageNamed:imageName];
        CSPhoto* p = [[CSPhoto alloc] init];
        p.image = image;
        [bs addObject:p];
    }
    NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:bs];
    photosViewController.delegate = self;
    UIViewController* co = [UIApplication sharedApplication].keyWindow.rootViewController;
    [co presentViewController:photosViewController animated:YES completion:nil];
//    
//    [self updateImagesOnPhotosViewController:photosViewController afterDelayWithPhotos:bs];
}

#pragma UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGFloat)photosViewController:(NYTPhotosViewController *)photosViewController maximumZoomScaleForPhoto:(id<NYTPhoto>)photo {
    return 2;
}

@end
