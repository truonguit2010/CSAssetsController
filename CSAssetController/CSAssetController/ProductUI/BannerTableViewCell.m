//
//  BannerTableViewCell.m
//  Capsule
//
//  Created by truongps on 7/5/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "BannerTableViewCell.h"

NSString *const BANNER_TABLE_VIEW_CELL_ID = @"BANNER_TABLE_VIEW_CELL";

@interface BannerTableViewCell()

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;

@end

@implementation BannerTableViewCell

+ (void)registerFor:(UITableView *)tableView {
    [tableView registerClass:[BannerTableViewCell class] forCellReuseIdentifier:BANNER_TABLE_VIEW_CELL_ID];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bannerView = [[BannerView alloc] init];
        self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.bannerView];
        
        int topPadding = 0;
        int leftPadding = 0;
        int rightPadding = 0;
        int bottomPadding = 0;
        self.topConstraint =[NSLayoutConstraint constraintWithItem:self.bannerView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:topPadding];
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:bottomPadding];
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.bannerView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.contentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1
                                                            constant:leftPadding];
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.bannerView
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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
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

@end
