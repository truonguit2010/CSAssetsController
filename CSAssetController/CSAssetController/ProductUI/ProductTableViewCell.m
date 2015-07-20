//
//  ProductTableViewCell.m
//  Capsule
//
//  Created by truongps on 7/6/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "ProductTableViewCell.h"

NSString *const PRODUCT_TABLE_VIEW_CELL_ID = @"PRODUCT_TABLE_VIEW_CELL_ID";
static NSString *const PRODUCT_COLLECTION_VIEW_CELL_ID = @"PRODUCT_COLLECTION_VIEW_CELL_ID";

@interface ProductTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;

@property (nonatomic, strong) UICollectionViewFlowLayout* flowLayout;

@end

@implementation ProductTableViewCell

+ (void)registerCellFor:(UITableView *)tableView {
    [tableView registerClass:[ProductTableViewCell class] forCellReuseIdentifier:PRODUCT_TABLE_VIEW_CELL_ID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.backgroundColor = [UIColor clearColor];
        
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout.minimumInteritemSpacing = 0;
        self.flowLayout.minimumLineSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:self.flowLayout];
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.pagingEnabled = YES;
        [self.collectionView registerClass:[ProductCollectionViewCell class] forCellWithReuseIdentifier:PRODUCT_COLLECTION_VIEW_CELL_ID];
        [self.contentView addSubview:self.collectionView];
        
        int topPadding = 6;
        int leftPadding = 6;
        int rightPadding = -6;
        int bottomPadding = -6;
        self.topConstraint =[NSLayoutConstraint constraintWithItem:self.collectionView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:topPadding];
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:bottomPadding];
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.contentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1
                                                            constant:leftPadding];
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1
                                                             constant:rightPadding];
        [self.contentView addConstraint:self.topConstraint];
        [self.contentView addConstraint:self.bottomConstraint];
        [self.contentView addConstraint:self.rightConstraint];
        [self.contentView addConstraint:self.leftConstraint];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PRODUCT_COLLECTION_VIEW_CELL_ID forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

@end

@interface ProductCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;

@end

@implementation ProductCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.productView = [[ProductView alloc] init];
        self.productView.translatesAutoresizingMaskIntoConstraints = NO;
        self.productView.layer.cornerRadius = 5;
        self.productView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.productView];
        
        int topPadding = 0;
        int leftPadding = 0;
        int rightPadding = -0;
        int bottomPadding = -0;
        self.topConstraint =[NSLayoutConstraint constraintWithItem:self.productView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:topPadding];
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.productView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:bottomPadding];
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.productView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.contentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1
                                                            constant:leftPadding];
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.productView
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1
                                                             constant:rightPadding];
        [self.contentView addConstraint:self.topConstraint];
        [self.contentView addConstraint:self.bottomConstraint];
        [self.contentView addConstraint:self.rightConstraint];
        [self.contentView addConstraint:self.leftConstraint];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
