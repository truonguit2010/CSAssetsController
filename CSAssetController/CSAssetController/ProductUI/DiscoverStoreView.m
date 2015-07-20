//
//  DiscoverStoreView.m
//  Capsule
//
//  Created by truongps on 7/3/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "DiscoverStoreView.h"
#import "ProductInGridCollectionViewCell.h"

NSString *const TAG = @"DiscoverStoreView";

@interface DiscoverStoreView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSLayoutConstraint* topTitleLabelToViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftTitleLabelToViewConstraint;

@property (nonatomic, strong) NSLayoutConstraint* centerCollectionViewToViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* widthCollectionViewToViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* topCollectionViewToTitleLabelConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomCollectionViewToTitleLabelConstraint;

@property (nonatomic, strong) NSLayoutConstraint* trailingButtonConnectConstraint;
@property (nonatomic, strong) NSLayoutConstraint* centerYButtonConnectConstraint;

@property (nonatomic, strong) NSMutableArray* productArray;

@end

@implementation DiscoverStoreView

- (instancetype)init {
    if (self = [super init]) {

        self.productArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 6; i++) {
            [self.productArray addObject:@"pro1"];
        }
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.text = @"sdkjfakjsda";
        
        self.buttonConnect = [[UIButton alloc] init];
        [self.buttonConnect setImage:[UIImage imageNamed:@"wish"] forState:UIControlStateNormal];
        [self.buttonConnect setImage:[UIImage imageNamed:@"wish_down"] forState:UIControlStateSelected];
        self.buttonConnect.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.buttonConnect];
        
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(130.0, 170.0);
//        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [ProductInGridCollectionViewCell registerFor:self.collectionView];
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;
        self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.labelTitle];
        [self addSubview:self.collectionView];
        
        self.topTitleLabelToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                          attribute:NSLayoutAttributeTop
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeTop
                                                                         multiplier:1
                                                                           constant:6];
        self.leftTitleLabelToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1
                                                                            constant:6];
        self.centerCollectionViewToViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                                 attribute:NSLayoutAttributeCenterX
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeCenterX
                                                                                multiplier:1
                                                                                  constant:0];
        self.widthCollectionViewToViewConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                                attribute:NSLayoutAttributeWidth
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:self
                                                                                attribute:NSLayoutAttributeWidth
                                                                               multiplier:1
                                                                                 constant:0];
        self.topCollectionViewToTitleLabelConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                                    attribute:NSLayoutAttributeTop
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self.labelTitle
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1
                                                                                     constant:6];
        self.bottomCollectionViewToTitleLabelConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeBottom
                                                                                      multiplier:1
                                                                                        constant:0];
        // Button connect -----------------------------------------------------------------
        self.trailingButtonConnectConstraint = [NSLayoutConstraint constraintWithItem:self.buttonConnect
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1
                                                                             constant:0];
        self.centerYButtonConnectConstraint = [NSLayoutConstraint constraintWithItem:self.buttonConnect
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.labelTitle
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1
                                                                            constant:0];
        
        NSArray* constraints = [NSArray arrayWithObjects:
                                self.topTitleLabelToViewConstraint
                                , self.leftTitleLabelToViewConstraint
                                , self.centerCollectionViewToViewConstraint
                                , self.widthCollectionViewToViewConstraint
                                , self.topCollectionViewToTitleLabelConstraint
                                , self.bottomCollectionViewToTitleLabelConstraint
                                , self.trailingButtonConnectConstraint
                                , self.centerYButtonConnectConstraint
                                , nil];
        [self addConstraints:constraints];
    }
    return self;
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductInGridCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:PRODUCT_IN_GRID_COLLECTION_VIEW_CELL_ID forIndexPath:indexPath];
    NSString* model = [self.productArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.productView.imageView.image = [UIImage imageNamed:model];
    return cell;
}

#pragma UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width / 2.5f, self.collectionView.frame.size.height);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    int titleHeight = self.labelTitle.frame.size.height + self.topCollectionViewToTitleLabelConstraint.constant + self.topTitleLabelToViewConstraint.constant;
    //Get the current drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 0.5f);
    //Start a new Path
    CGContextBeginPath(context);
    
    // offset lines up - we are adding offset to font.leading so that line is drawn right below the characters and still characters are visible.
    //    CGContextMoveToPoint(context, self.bounds.origin.x, self.font.lineHeight + 2.0f);
    //    CGContextAddLineToPoint(context, self.bounds.size.width, self.font.lineHeight + 1.0f);
    
    CGContextMoveToPoint(context, self.bounds.origin.x, titleHeight);
    CGContextAddLineToPoint(context, self.bounds.size.width, titleHeight);
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
