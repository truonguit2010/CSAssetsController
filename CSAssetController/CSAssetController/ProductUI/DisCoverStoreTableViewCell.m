//
//  DisCoverStoreTableViewCell.m
//  Capsule
//
//  Created by truongps on 7/4/15.
//  Copyright (c) 2015 Capsule. All rights reserved.
//

#import "DisCoverStoreTableViewCell.h"

NSString *const DISCOVER_STORE_VIEW_CELL_ID = @"DISCOVER_STORE_VIEW_CELL_ID";
static NSString *const TAG = @"DisCoverStoreTableViewCell";

@interface DisCoverStoreTableViewCell()

@property (nonatomic, strong) NSLayoutConstraint* topConstraint;
@property (nonatomic, strong) NSLayoutConstraint* bottomConstraint;
@property (nonatomic, strong) NSLayoutConstraint* rightConstraint;
@property (nonatomic, strong) NSLayoutConstraint* leftConstraint;

@end

@implementation DisCoverStoreTableViewCell

+(void)registerCellFor:(UITableView *)tableView {
    [tableView registerClass:[DisCoverStoreTableViewCell class] forCellReuseIdentifier:DISCOVER_STORE_VIEW_CELL_ID];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.discoverStoreView = [[DiscoverStoreView alloc] init];
        self.discoverStoreView.translatesAutoresizingMaskIntoConstraints = NO;
        self.discoverStoreView.layer.cornerRadius = 2;
        self.discoverStoreView.backgroundColor = [UIColor whiteColor];
        self.discoverStoreView.clipsToBounds = YES;
        [self.contentView addSubview:self.discoverStoreView];
        self.backgroundColor = [UIColor clearColor];
        
        int topPadding = 4;
        int leftPadding = 4;
        int rightPadding = -4;
        int bottomPadding = -4;
        self.topConstraint =[NSLayoutConstraint constraintWithItem:self.discoverStoreView
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:topPadding];
        self.bottomConstraint = [NSLayoutConstraint constraintWithItem:self.discoverStoreView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.contentView
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:bottomPadding];
        self.leftConstraint = [NSLayoutConstraint constraintWithItem:self.discoverStoreView
                                                           attribute:NSLayoutAttributeLeading
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.contentView
                                                           attribute:NSLayoutAttributeLeading
                                                          multiplier:1
                                                            constant:leftPadding];
        self.rightConstraint = [NSLayoutConstraint constraintWithItem:self.discoverStoreView
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
    }
    return self;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
