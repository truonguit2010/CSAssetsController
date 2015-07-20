//
//  ProductInGrid.m
//  Capsule
//
//  Created by truongps on 7/2/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "ProductInGrid.h"

@interface ProductInGrid()

@property (strong, nonatomic) NSLayoutConstraint* topImageToViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint* centerHorizontalImageToViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint* widthImageToViewConstraint;

@property (strong, nonatomic) NSLayoutConstraint* bottomPriceLabelToViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint* centerHorizontalPriceLabelToViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint* topPriceLabelToBottomNameLabelConstraint;

@property (strong, nonatomic) NSLayoutConstraint* centerHorizontalNameLabelToViewConstraint;
@property (strong, nonatomic) NSLayoutConstraint* topNameLabelToBottomImageConstraint;
@property (strong, nonatomic) NSLayoutConstraint* widthNameLableToViewConstraint;

@end

@implementation ProductInGrid

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView = [[UIImageView alloc] init];
        self.labelName = [[UILabel alloc] init];
        self.labelPrice = [[UILabel alloc] init];
        
        // Test code.
        self.imageView.image = [UIImage imageNamed:@"pro1"];
        self.labelName.text = @"Bep ga doi hong ngoai NAKA";
        self.labelPrice.text = @"400.000";
        // End test code.
        
        [self addSubview:self.imageView];
        [self addSubview:self.labelName];
        [self addSubview:self.labelPrice];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelName.translatesAutoresizingMaskIntoConstraints = NO;
        self.labelPrice.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.labelName.lineBreakMode = NSLineBreakByWordWrapping;
        self.labelName.numberOfLines = 2;
        self.labelName.textAlignment = NSTextAlignmentCenter;
        self.labelName.font = [UIFont systemFontOfSize:13];
        self.labelPrice.font = [UIFont systemFontOfSize:13];
        self.labelPrice.textColor = [UIColor redColor];
        
//        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.topImageToViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
        self.centerHorizontalImageToViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                  relatedBy:NSLayoutRelationEqual
                                                                                     toItem:self
                                                                                  attribute:NSLayoutAttributeCenterX
                                                                                 multiplier:1
                                                                                   constant:0];
        self.widthImageToViewConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        
        [self addConstraint:self.topImageToViewConstraint];
        [self addConstraint:self.centerHorizontalImageToViewConstraint];
        [self addConstraint:self.widthImageToViewConstraint];
        
        self.bottomPriceLabelToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        self.centerHorizontalPriceLabelToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice
                                                                                       attribute:NSLayoutAttributeCenterX
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:self
                                                                                       attribute:NSLayoutAttributeCenterX
                                                                                      multiplier:1
                                                                                        constant:0];
        self.topPriceLabelToBottomNameLabelConstraint = [NSLayoutConstraint constraintWithItem:self.labelPrice attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.labelName attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        
        [self addConstraint:self.bottomPriceLabelToViewConstraint];
        [self addConstraint:self.centerHorizontalPriceLabelToViewConstraint];
        [self addConstraint:self.topPriceLabelToBottomNameLabelConstraint];
        
        self.centerHorizontalNameLabelToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        self.topNameLabelToBottomImageConstraint = [NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        self.widthNameLableToViewConstraint = [NSLayoutConstraint constraintWithItem:self.labelName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        [self addConstraint:self.centerHorizontalNameLabelToViewConstraint];
        [self addConstraint:self.topNameLabelToBottomImageConstraint];
        [self addConstraint:self.widthNameLableToViewConstraint];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
