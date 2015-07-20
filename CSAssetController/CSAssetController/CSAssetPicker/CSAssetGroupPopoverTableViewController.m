//
//  CSAssetGroupPopoverTableViewController.m
//  CSAssetController
//
//  Created by truongps on 7/19/15.
//  Copyright (c) 2015 CS. All rights reserved.
//

#import "CSAssetGroupPopoverTableViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CTAssetsPickerCommon.h"

@interface CSAssetGroupCell()

@property (nonatomic, weak) NSLayoutConstraint* imageCenterY;
@property (nonatomic, weak) NSLayoutConstraint* imageLeading;
@property (nonatomic, weak) NSLayoutConstraint* imageWidth;
@property (nonatomic, weak) NSLayoutConstraint* imageHeight;

@property (nonatomic, weak) NSLayoutConstraint* titleBottom;
@property (nonatomic, weak) NSLayoutConstraint* titleLeading;

@property (nonatomic, weak) NSLayoutConstraint* desTop;
@property (nonatomic, weak) NSLayoutConstraint* desLeading;

@property (nonatomic, weak) NSLayoutConstraint* rightImageCenterY;
@property (nonatomic, weak) NSLayoutConstraint* rightImageTrailing;

@end

@implementation CSAssetGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.desLabel = [[UILabel alloc] init];
        self.desLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.rightIconImageView = [[UIImageView alloc] init];
        self.rightIconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.rightIconImageView];
    
        self.imageCenterY = [NSLayoutConstraint constraintWithItem:self.iconImageView
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0];
        // Add to super view.
        [self.contentView addConstraint:self.imageCenterY];
        self.imageLeading = [NSLayoutConstraint constraintWithItem:self.iconImageView
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.contentView
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:10];
        // Add constraint to super view.
        [self.contentView addConstraint:self.imageLeading];
        self.imageWidth = [NSLayoutConstraint constraintWithItem:self.iconImageView
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1
                                                        constant:55];
        [self.contentView addConstraint:self.imageWidth];
        self.imageHeight = [NSLayoutConstraint constraintWithItem:self.iconImageView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.iconImageView
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:1
                                                         constant:0];
        [self.contentView addConstraint:self.imageHeight];
        self.titleBottom = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.contentView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1
                                                         constant:0];
        [self.contentView addConstraint:self.titleBottom];
        self.titleLeading = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.iconImageView
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1
                                                          constant:0];
        [self.contentView addConstraint:self.titleLeading];
        self.desLeading = [NSLayoutConstraint constraintWithItem:self.desLabel
                                                       attribute:NSLayoutAttributeLeading
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.iconImageView
                                                       attribute:NSLayoutAttributeTrailing
                                                      multiplier:1
                                                        constant:0];
        [self.contentView addConstraint:self.desLeading];
        self.desTop = [NSLayoutConstraint constraintWithItem:self.desLabel
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.contentView
                                                   attribute:NSLayoutAttributeCenterY
                                                  multiplier:1
                                                    constant:0];
        [self.contentView addConstraint:self.desTop];
        self.rightImageCenterY = [NSLayoutConstraint constraintWithItem:self.rightIconImageView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.contentView
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0];
        [self.contentView addConstraint:self.rightImageCenterY];
        self.rightImageTrailing = [NSLayoutConstraint constraintWithItem:self.rightIconImageView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentView
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1
                                                                constant:-10];
        [self.contentView addConstraint:self.rightImageTrailing];
    }
    return self;
}

@end

@interface CSAssetGroupPopoverTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIImageView* arrowView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIView *outView;
@property (nonatomic, strong) UIImage* checkIcon;

@end

@implementation CSAssetGroupPopoverTableViewController

- (instancetype)init {
    if (self = [super init]) {
        self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        [self.view addSubview:self.arrowView];
        self.outView = [[UIView alloc] init];
        self.outView.frame = self.view.frame;
        [self.outView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView)]];
        [self.view addSubview:self.outView];
        self.tableView = [[UITableView alloc] init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 6;
        [self.tableView registerClass:[CSAssetGroupCell class] forCellReuseIdentifier:@"CSAssetGroupCell"];
        [self.view addSubview:self.tableView];
        
        self.checkIcon = [[UIImage imageNamed:@"ic_check_circle_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.outView.frame = self.view.frame;
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
}

- (void) tapOnView {
    [UIView animateWithDuration:.3f animations:^{
        self.tableView.frame = CGRectMake(self.view.frame.size.width / 2, 68, 0, 0);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated {
    float x = 0;
    float y = 68;
    self.tableView.frame = CGRectMake(self.view.frame.size.width / 2, y, 0, 0);
    [UIView animateWithDuration:.3f animations:^{
        self.tableView.frame = CGRectMake(x, y, self.view.frame.size.width - (x * 2), self.view.frame.size.height / 2);
    } completion:^(BOOL finished) {
        
    }];
    self.arrowView.center = CGPointMake(self.view.center.x, y - self.arrowView.frame.size.height / 2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.assetGroup) {
        return self.assetGroup.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSAssetGroupCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CSAssetGroupCell" forIndexPath:indexPath];
    ALAssetsGroup* group = [self.assetGroup objectAtIndex:indexPath.row];
    CGImageRef posterImage      = group.posterImage;
    size_t height               = CGImageGetHeight(posterImage);
    float scale                 = height / (CTAssetThumbnailLength);
    cell.iconImageView.image = [UIImage imageWithCGImage:posterImage
                                                   scale:scale
                                             orientation:UIImageOrientationUp];
    cell.titleLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
    cell.desLabel.text = [NSString stringWithFormat:@"%ld", (long)group.numberOfAssets];
    if (group == self.selectedGroup) {
        cell.rightIconImageView.image = self.checkIcon;
        cell.rightIconImageView.tintColor = [UIColor blueColor];
    } else {
        cell.rightIconImageView.image = nil;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(assetGroupPopover:didSelectAsset:)]) {
        ALAssetsGroup* group = [self.assetGroup objectAtIndex:indexPath.row];
        [self tapOnView];
        [self.delegate assetGroupPopover:self didSelectAsset:group];
        
    }
}

@end
