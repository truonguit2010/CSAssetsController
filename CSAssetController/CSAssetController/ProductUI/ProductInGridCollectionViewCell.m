//
//  ProductInGridCollectionViewCell.m
//  Capsule
//
//  Created by truongps on 7/4/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "ProductInGridCollectionViewCell.h"

NSString *const PRODUCT_IN_GRID_COLLECTION_VIEW_CELL_ID = @"PRODUCT_IN_GRID_COLLECTION_VIEW_CELL_ID";
static NSString *const TAG = @"ProductInGridCollectionViewCell";

@interface ProductInGridCollectionViewCell()

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;


@end

@implementation ProductInGridCollectionViewCell

+ (void)registerFor:(UICollectionView *)collectionView {
    [collectionView registerClass:[ProductInGridCollectionViewCell class] forCellWithReuseIdentifier:PRODUCT_IN_GRID_COLLECTION_VIEW_CELL_ID];
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.productView = [[ProductInGrid alloc] init];
        [self.contentView addSubview:self.productView];
        self.productView.translatesAutoresizingMaskIntoConstraints = NO;
        
        int topPadding = 4;
        int leftPadding = 4;
        int rightPadding = -4;
        int bottomPadding = -4;
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

// Take care this function when layout or draw wrong
- (void)drawRect:(CGRect)rect {
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
    
    CGContextMoveToPoint(context, self.bounds.size.width, self.bounds.origin.y);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
