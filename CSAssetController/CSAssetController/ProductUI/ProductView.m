//
//  ProductView.m
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "ProductView.h"

@interface ProductView()

@property (nonatomic, strong) NSLayoutConstraint* topLabelTitleConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leadingLabelTitleConstraint;
@property (nonatomic, strong) NSLayoutConstraint* heightLabelTitleConstraint;
@property (nonatomic, strong) NSLayoutConstraint* trailingLabelTitleConstraint;

@property (nonatomic, strong) NSLayoutConstraint* centerYButtonWishConstraint;
@property (nonatomic, strong) NSLayoutConstraint* trailingButtonWishConstraint;

@property (nonatomic, strong) NSLayoutConstraint* centerYButtonCartConstraint;
@property (nonatomic, strong) NSLayoutConstraint* trailingButtonCartConstraint;

@property (nonatomic, strong) NSLayoutConstraint* bottomButtonMoreConstraint;
@property (nonatomic, strong) NSLayoutConstraint* centerXButtonMoreConstraint;
@property (nonatomic, strong) NSLayoutConstraint* heightButtonMoreConstraint;

@property (nonatomic, strong) NSLayoutConstraint* topImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* centerXImageViewConstraint;
@property (nonatomic, strong) NSLayoutConstraint* widthImageViewConstraint;
// Label Price
@property (nonatomic, strong) NSLayoutConstraint* trailingLabelPriceConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomLabelPriceConstraint;
@property (nonatomic, strong) NSLayoutConstraint* heightLabelPriceConstraint;
// label old pice
@property (nonatomic, strong) NSLayoutConstraint* trailingLabelOldPriceConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomLabelOldPriceConstraint;

@end

@implementation ProductView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelTitle = [[UILabel alloc] init];
        self.labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        self.labelTitle.numberOfLines = 2;
        self.labelTitle.text = @"tiVi LED Sony 40inch Full HD - Bravia Model KDL-40R350B (Đen)";
        self.labelTitle.font = [UIFont systemFontOfSize:13];
        [self.labelTitle sizeToFit];
        [self addSubview:self.labelTitle];
        self.labelTitle.translatesAutoresizingMaskIntoConstraints = NO;

        self.imageView = [[UIImageView alloc] init];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.imageView.image = [UIImage imageNamed:@"pro3"];
        [self addSubview:self.imageView];

        self.labelPrice = [[UILabel alloc] init];
        self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelPrice.text = @"150.000 VND";
        self.labelPrice.font = [UIFont boldSystemFontOfSize:18];
        self.labelPrice.textColor = [UIColor orangeColor];
        [self.labelPrice sizeToFit];
        [self addSubview:self.labelPrice];

        self.labelOldPrice = [[UILabel alloc] init];
        self.labelOldPrice.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelOldPrice.text = @"200.000 VND";
        self.labelOldPrice.font = [UIFont italicSystemFontOfSize:13];
        [self  addSubview:self.labelOldPrice];
        
        self.buttonViewMore = [[UIButton alloc] init];
        self.buttonViewMore.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttonViewMore setTitle:@"Xem thêm các sản phẩm khác" forState:UIControlStateNormal];
        [self.buttonViewMore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.buttonViewMore.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.buttonViewMore sizeToFit];
        [self addSubview:self.buttonViewMore];
        
        self.buttonAddToCart = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buttonAddToCart.translatesAutoresizingMaskIntoConstraints = NO;
        self.buttonAddToCart.selected = YES;
        [self.buttonAddToCart setImage:[UIImage imageNamed:@"wish"] forState:UIControlStateNormal];
        [self.buttonAddToCart setImage:[UIImage imageNamed:@"wish_down"] forState:UIControlStateSelected];
        [self addSubview:self.buttonAddToCart];

        self.buttonAddToWishList = [[UIButton alloc] init];
        self.buttonAddToWishList.translatesAutoresizingMaskIntoConstraints = NO;
        [self.buttonAddToWishList setImage:[UIImage imageNamed:@"wish"] forState:UIControlStateNormal];
        [self.buttonAddToWishList setImage:[UIImage imageNamed:@"wish_down"] forState:UIControlStateHighlighted];
        [self addSubview:self.buttonAddToWishList];

        // Title label ----------------------------------------------
        self.topLabelTitleConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeTop
                                                                   multiplier:1
                                                                     constant:6];
        self.leadingLabelTitleConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                        attribute:NSLayoutAttributeLeading
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:6];
        self.heightLabelTitleConstraint  = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1
                                                                         constant:self.labelTitle.frame.size.height * 2];
        self.trailingLabelTitleConstraint =[NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                        attribute:NSLayoutAttributeTrailing
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.buttonAddToWishList
                                                                        attribute:NSLayoutAttributeLeading
                                                                       multiplier:1
                                                                         constant:1];
        // Button Add to cart --------------------------------------------------------
        self.centerYButtonCartConstraint = [NSLayoutConstraint constraintWithItem:self.buttonAddToCart
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.labelTitle
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1
                                                                     constant:0];
        self.trailingButtonCartConstraint = [NSLayoutConstraint constraintWithItem:self.buttonAddToCart
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:-6];
        // Button Wish List ---------------------------------------------------------
        self.centerYButtonWishConstraint = [NSLayoutConstraint constraintWithItem:self.buttonAddToWishList
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.labelTitle
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1
                                                                     constant:0];
        self.trailingButtonWishConstraint = [NSLayoutConstraint constraintWithItem:self.buttonAddToWishList
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.buttonAddToCart
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1
                                                                          constant:-6];
        // Button More -------------------------------------------------------------
        self.bottomButtonMoreConstraint = [NSLayoutConstraint constraintWithItem:self.buttonViewMore
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1
                                                                        constant:6];
        self.centerXButtonMoreConstraint = [NSLayoutConstraint constraintWithItem:self.buttonViewMore
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1
                                                                        constant:0];
        self.heightButtonMoreConstraint = [NSLayoutConstraint constraintWithItem:self.buttonViewMore
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1
                                                                        constant:40];
        // Image View --------------------------------------------------------------
        self.topImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelTitle
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.imageView
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                    constant:-1];
        self.bottomImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.labelPrice
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1
                                                                            constant:1];
        self.centerXImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0];
        self.widthImageViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                          attribute:NSLayoutAttributeWidth
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self
                                                                          attribute:NSLayoutAttributeWidth
                                                                         multiplier:1
                                                                           constant:0];
        // Label Price -------------------------------------------------------------
        self.trailingLabelPriceConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice
                                                                         attribute:NSLayoutAttributeTrailing
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self
                                                                         attribute:NSLayoutAttributeTrailing
                                                                        multiplier:1
                                                                          constant:-6];
        self.bottomLabelPriceConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.buttonViewMore
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1
                                                                        constant:-6];
        self.heightLabelPriceConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1
                                                                        constant:self.labelPrice.frame.size.height];
        // Label Old price -----------------------------------------------
        self.trailingLabelOldPriceConstraint = [NSLayoutConstraint constraintWithItem:self.labelOldPrice
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.labelPrice
                                                                            attribute:NSLayoutAttributeLeading
                                                                           multiplier:1
                                                                             constant:-15];
        self.bottomLabelOldPriceConstraint = [NSLayoutConstraint constraintWithItem:self.labelOldPrice
                                                                           attribute:NSLayoutAttributeBottom
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.labelPrice
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1
                                                                            constant:0];
        
        [self addConstraints:[NSArray arrayWithObjects:self.centerYButtonCartConstraint, self.trailingButtonCartConstraint, nil]];
        [self addConstraints:[NSArray arrayWithObjects:self.centerYButtonWishConstraint, self.trailingButtonWishConstraint, nil]];
        [self addConstraint:self.topLabelTitleConstraint];
        [self addConstraint:self.leadingLabelTitleConstraint];
        [self addConstraint:self.heightLabelTitleConstraint];
        [self addConstraint:self.trailingLabelTitleConstraint];
        [self addConstraint:self.topImageViewConstraint];
        
        
        [self addConstraints:[NSArray arrayWithObjects:self.bottomButtonMoreConstraint, self.centerXButtonMoreConstraint, nil]];
        [self addConstraint:self.heightButtonMoreConstraint];
        [self addConstraints:[NSArray arrayWithObjects: self.bottomImageViewConstraint, self.centerXImageViewConstraint, self.widthImageViewConstraint, nil]];
        // Price label
        [self addConstraint:self.trailingLabelPriceConstraint];
        [self addConstraint:self.bottomLabelPriceConstraint];
        [self addConstraint:self.heightLabelPriceConstraint];
        // Old price label
        [self addConstraint:self.bottomLabelOldPriceConstraint];
        [self addConstraint:self.trailingLabelOldPriceConstraint];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
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
    
    CGContextMoveToPoint(context, self.bounds.origin.x, self.buttonViewMore.frame.origin.y);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.buttonViewMore.frame.origin.y);
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

@end
