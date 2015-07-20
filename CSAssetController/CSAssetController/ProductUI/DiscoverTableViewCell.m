//
//  DiscoverTableViewCell.m
//  CSAssetController
//
//  Created by truongps on 7/18/15.
//  Copyright (c) 2015 CS. All rights reserved.
//

#import "DiscoverTableViewCell.h"

@interface DiscoverView()

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;

@end

@implementation DiscoverView

- (instancetype)init {
    if (self = [super init]) {
        self.labelTitle = [[UILabel alloc] init];
        self.buttonBottom = [[UIButton alloc] init];
        [self addSubview:self.labelTitle];
        [self addSubview:self.buttonBottom];
    }
    return self;
}

@end

@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
