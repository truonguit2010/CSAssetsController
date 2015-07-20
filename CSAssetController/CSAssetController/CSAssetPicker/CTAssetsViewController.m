/*
 CTAssetsViewController.m
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "CTAssetsPickerCommon.h"
#import "CTAssetsPickerController.h"
#import "CTAssetsViewController.h"
#import "CTAssetsViewCell.h"
#import "CTAssetsSupplementaryView.h"
#import "CTAssetsPageViewController.h"
#import "CTAssetsViewControllerTransition.h"
#import "NSBundle+CTAssetsPickerController.h"
#import "CSAssetGroupPopoverTableViewController.h"

NSString * const CTAssetsViewCellIdentifier = @"CTAssetsViewCellIdentifier";
NSString * const CTAssetsSupplementaryViewIdentifier = @"CTAssetsSupplementaryViewIdentifier";

@interface CTAssetsPickerController ()

- (void)finishPickingAssets:(id)sender;

- (NSString *)toolbarTitle;
- (UIView *)noAssetsView;

@end



@interface CTAssetsViewController () <CSAssetGroupPopoverViewControllerDelegate>

@property (nonatomic, weak) CTAssetsPickerController *picker;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray *assetGroups;
@property (nonatomic, strong) UIButton* btnTitle;

@end

@implementation CTAssetsViewController


- (id)init
{
    self.assetGroups = [[NSMutableArray alloc] init];
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UICollectionViewFlowLayout *layout = [self collectionViewFlowLayoutOfOrientation:interfaceOrientation];
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.collectionView.allowsMultipleSelection = YES;
        
        [self.collectionView registerClass:CTAssetsViewCell.class
                forCellWithReuseIdentifier:CTAssetsViewCellIdentifier];
        
        [self.collectionView registerClass:CTAssetsSupplementaryView.class
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier];
        
        self.preferredContentSize = CTAssetPickerPopoverContentSize;
    }
    
    [self addNotificationObserver];
    [self addGestureRecognizer];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
    
    self.btnTitle = [[UIButton alloc] init];
    [self.btnTitle setTitle:@"Camera Roll" forState:UIControlStateNormal];
    [self.btnTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnTitle sizeToFit];
    UITapGestureRecognizer* titleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTitleTapped)];
    [self.btnTitle addGestureRecognizer:titleTapGesture];
    self.navigationItem.titleView = self.btnTitle;
}

- (void)setTitle:(NSString *)title {
    [self.btnTitle setTitle:title forState:UIControlStateNormal];
}

- (void) onTitleTapped {
// Check here: http://www.raywenderlich.com/forums/viewtopic.php?f=2&t=18661
//    Before iOS 8, you do this:
//        
//        [backgroundViewController setModalPresentationStyle:UIModalPresentationCurrentContext];
//    [backgroundViewController presentViewController:_myMoreAppsViewController animated:NO completion:nil];
//    
//    in iOS 8, you have to do this:
//        
//        backgroundViewController.providesPresentationContextTransitionStyle = YES;
//    backgroundController.definesPresentationContext = YES;
//    [overlayViewController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    CSAssetGroupPopoverTableViewController* popover = [[CSAssetGroupPopoverTableViewController alloc] init];
    popover.assetGroup = self.assetGroups;
    popover.selectedGroup = self.assetsGroup;
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
//    self.modalTransitionStyle = UIModalPresentationCurrentContext;
    [popover setModalPresentationStyle:UIModalPresentationOverFullScreen];
    popover.delegate = self;
    [self presentViewController:popover animated:NO completion:^{
        
    }];
}

- (void)assetGroupPopover:(CSAssetGroupPopoverTableViewController *)controller didSelectAsset:(ALAssetsGroup *)group {
    self.assetsGroup = group;
    [self setupAssets];
}

- (void)setupGroup
{
    NSMutableArray* groups = [[NSMutableArray alloc] init];
    
    ALAssetsFilter *assetsFilter = [ALAssetsFilter allPhotos];//self.picker.assetsFilter;
    
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            int val = [[group valueForProperty:ALAssetsGroupPropertyType] integerValue];
            NSString *title = [group valueForProperty:ALAssetsGroupPropertyName];
            if ([group isEditable]) {
                NSLog(@"Group title: %@ - Editable", title);
            } else {
                NSLog(@"Group title: %@ - Cannot edit", title);
            }
            
            switch (val) {
                case ALAssetsGroupSavedPhotos:
                    NSLog(@"ALAssetsGroupSavedPhotos");
                    break;
                case ALAssetsGroupAlbum:
                    NSLog(@"ALAssetsGroupAlbum");
                    break;
                case ALAssetsGroupAll:
                    NSLog(@"ALAssetsGroupAll");
                    break;
                case ALAssetsGroupEvent:
                    NSLog(@"ALAssetsGroupEvent");
                    break;
                case ALAssetsGroupFaces:
                    NSLog(@"ALAssetsGroupFaces");
                    break;
                case ALAssetsGroupLibrary:
                    NSLog(@"ALAssetsGroupLibrary");
                    break;
                case ALAssetsGroupPhotoStream:
                    NSLog(@"ALAssetsGroupPhotoStream");
                    break;

            }
            [group setAssetsFilter:assetsFilter];
            
            BOOL shouldShowGroup;
            
//            if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldShowAssetsGroup:)])
//                shouldShowGroup = [self.picker.delegate assetsPickerController:self.picker shouldShowAssetsGroup:group];
//            else
                shouldShowGroup = YES;
            
            if (shouldShowGroup)
            {
                [groups addObject:group];
                
                if (([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos)) {
                    self.assetsGroup = group;
                }
//                if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:isDefaultAssetsGroup:)])
//                {
//                    if ([self.picker.delegate assetsPickerController:self.picker isDefaultAssetsGroup:group])
//                        self.defaultGroup = group;
//                }
            }
        }
        else
        {
            // Lay toan bo album o day roi
//            [self reloadData];
            self.assetGroups = groups;
            [self setupAssets];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error)
    {
//        [self showNotAllowed];
    };
    
    // Enumerate Camera roll first
    [[CTAssetsViewController defaultAssetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                                             usingBlock:resultsBlock
                                           failureBlock:failureBlock];
    
    // Then all other groups
    NSUInteger type =
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
    
    [[CTAssetsViewController defaultAssetsLibrary] enumerateGroupsWithTypes:type
                                             usingBlock:resultsBlock
                                           failureBlock:failureBlock];
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred,^
                  {
                      library = [[ALAssetsLibrary alloc] init];
                  });
    return library;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupButtons];
    [self setupToolbar];
    [self setupGroup];
//    [self setupAssets];
}

- (void)dealloc
{
    [self removeNotificationObserver];
}


#pragma mark - Accessors

- (CTAssetsPickerController *)picker
{
    return (CTAssetsPickerController *)self.navigationController.parentViewController;
}


#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UICollectionViewFlowLayout *layout = [self collectionViewFlowLayoutOfOrientation:toInterfaceOrientation];
    [self.collectionView setCollectionViewLayout:layout animated:YES];
}


#pragma mark - Setup

- (void)setupViews
{
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)setupButtons
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:CTAssetsPickerControllerLocalizedString(@"Done")
                                     style:UIBarButtonItemStyleDone
                                    target:self.picker
                                    action:@selector(finishPickingAssets:)];
    
    if (self.picker.alwaysEnableDoneButton)
        self.navigationItem.rightBarButtonItem.enabled = YES;
    else
        self.navigationItem.rightBarButtonItem.enabled = (self.picker.selectedAssets.count > 0);
}

- (void)setupToolbar
{
    self.toolbarItems = self.picker.toolbarItems;
}

- (void)setupAssets
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
//        return;
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop)
    {
        if (asset)
        {
            BOOL shouldShowAsset;
            
            if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldShowAsset:)])
                shouldShowAsset = [self.picker.delegate assetsPickerController:self.picker shouldShowAsset:asset];
            else
                shouldShowAsset = YES;
            
            if (shouldShowAsset)
                [self.assets addObject:asset];
        }
        else
        {
            [self reloadData];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}


#pragma mark - Collection View Layout

- (UICollectionViewFlowLayout *)collectionViewFlowLayoutOfOrientation:(UIInterfaceOrientation)orientation
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize             = CTAssetThumbnailSize;
    layout.footerReferenceSize  = CGSizeMake(0, 47.0);
    
    if (UIInterfaceOrientationIsLandscape(orientation) && (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad))
    {
        layout.sectionInset            = UIEdgeInsetsMake(9.0, 2.0, 0, 2.0);
        layout.minimumInteritemSpacing = (CTIPhone6Plus) ? 1.0 : ( (CTIPhone6) ? 2.0 : 3.0 );
        layout.minimumLineSpacing      = (CTIPhone6Plus) ? 1.0 : ( (CTIPhone6) ? 2.0 : 3.0 );
    }
    else
    {
        layout.sectionInset            = UIEdgeInsetsMake(9.0, 0, 0, 0);
        layout.minimumInteritemSpacing = (CTIPhone6Plus) ? 0.5 : ( (CTIPhone6) ? 1.0 : 2.0 );
        layout.minimumLineSpacing      = (CTIPhone6Plus) ? 0.5 : ( (CTIPhone6) ? 1.0 : 2.0 );
    }
    
    return layout;
}


#pragma mark - Notifications

- (void)addNotificationObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(assetsLibraryChanged:)
                   name:ALAssetsLibraryChangedNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(selectedAssetsChanged:)
                   name:CTAssetsPickerSelectedAssetsChangedNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(didSelectAsset:)
                   name:CTAssetsPickerDidSelectAssetNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(didDeselectAsset:)
                   name:CTAssetsPickerDidDeselectAssetNotification
                 object:nil];
    
}

- (void)removeNotificationObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
    [center removeObserver:self name:CTAssetsPickerSelectedAssetsChangedNotification object:nil];
    [center removeObserver:self name:CTAssetsPickerDidSelectAssetNotification object:nil];
    [center removeObserver:self name:CTAssetsPickerDidDeselectAssetNotification object:nil];
}


#pragma mark - Assets Library Changed

- (void)assetsLibraryChanged:(NSNotification *)notification
{
    // Reload all assets
    if (notification.userInfo == nil)
        [self performSelectorOnMainThread:@selector(reloadAssets) withObject:nil waitUntilDone:NO];
    
    // Reload effected assets groups
    if (notification.userInfo.count > 0)
        [self reloadAssetsGroupForUserInfo:notification.userInfo];
}


#pragma mark - Reload Assets Group

- (void)reloadAssetsGroupForUserInfo:(NSDictionary *)userInfo
{
    NSSet *URLs = [userInfo objectForKey:ALAssetLibraryUpdatedAssetGroupsKey];
    NSURL *URL  = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyURL];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", URL];
    NSArray *matchedGroups = [URLs.allObjects filteredArrayUsingPredicate:predicate];
    
    // Reload assets if current assets group is updated
    if (matchedGroups.count > 0)
        [self performSelectorOnMainThread:@selector(reloadAssets) withObject:nil waitUntilDone:NO];
}



#pragma mark - Selected Assets Changed

- (void)selectedAssetsChanged:(NSNotification *)notification
{
    NSArray *selectedAssets = (NSArray *)notification.object;
    
    [[self.toolbarItems objectAtIndex:1] setTitle:[self.picker toolbarTitle]];
    
    [self.navigationController setToolbarHidden:(selectedAssets.count == 0) animated:YES];
    
    // Reload assets for calling de/selectAsset method programmatically
    [self.collectionView reloadData];
}

- (void)didSelectAsset:(NSNotification *)notification
{
    ALAsset *asset = (ALAsset *)notification.object;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.assets indexOfObject:asset] inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

- (void)didDeselectAsset:(NSNotification *)notification
{
    ALAsset *asset = (ALAsset *)notification.object;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.assets indexOfObject:asset] inSection:0];
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
}



#pragma mark - Gesture Recognizer

- (void)addGestureRecognizer
{
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pushPageViewController:)];
    
    [self.collectionView addGestureRecognizer:longPress];
}


#pragma mark - Push Assets Page View Controller

- (void)pushPageViewController:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point           = [longPress locationInView:self.collectionView];
        NSIndexPath *indexPath  = [self.collectionView indexPathForItemAtPoint:point];

        CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAssets:self.assets];
        vc.pageIndex = indexPath.item;

        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - Reload Assets

- (void)reloadAssets
{
    self.assets = nil;
    [self setupAssets];
}



#pragma mark - Reload Data

- (void)reloadData
{
    if (self.assets.count > 0)
    {
        [self.collectionView reloadData];
        
        if (self.collectionView.contentOffset.y <= 0)
            [self.collectionView setContentOffset:CGPointMake(0, self.collectionViewLayout.collectionViewContentSize.height)];
    }
    else
    {
        [self showNoAssets];
    }
}


#pragma mark - No assets

- (void)showNoAssets
{
    self.collectionView.backgroundView = [self.picker noAssetsView];
    [self setAccessibilityFocus];
}

- (void)setAccessibilityFocus
{
    self.collectionView.isAccessibilityElement  = YES;
    self.collectionView.accessibilityLabel      = self.collectionView.backgroundView.accessibilityLabel;
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.collectionView);
}


#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTAssetsViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:CTAssetsViewCellIdentifier
                                              forIndexPath:indexPath];
    
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldEnableAsset:)])
        cell.enabled = [self.picker.delegate assetsPickerController:self.picker shouldEnableAsset:asset];
    else
        cell.enabled = YES;
    
    // XXX
    // Setting `selected` property blocks further deselection.
    // Have to call selectItemAtIndexPath too. ( ref: http://stackoverflow.com/a/17812116/1648333 )
    if ([self.picker.selectedAssets containsObject:asset])
    {
        cell.selected = YES;
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    [cell bind:asset];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CTAssetsSupplementaryView *view =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier
                                              forIndexPath:indexPath];
    
    [view bind:self.assets];
    
    if (self.assets.count == 0)
        view.hidden = YES;
    
    return view;
}


#pragma mark - Collection View Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    CTAssetsViewCell *cell = (CTAssetsViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (!cell.isEnabled)
        return NO;
    else if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldSelectAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldSelectAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    [self.picker selectAsset:asset];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didSelectAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didSelectAsset:asset];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldDeselectAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldDeselectAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    [self.picker deselectAsset:asset];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didDeselectAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didDeselectAsset:asset];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldHighlightAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldHighlightAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didHighlightAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didHighlightAsset:asset];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didUnhighlightAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didUnhighlightAsset:asset];
}


@end