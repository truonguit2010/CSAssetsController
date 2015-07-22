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
#import "CTAssetsViewController.h"
#import "CTAssetsViewCell.h"
#import "CTAssetsSupplementaryView.h"
#import "CTAssetsPageViewController.h"
#import "CTAssetsViewControllerTransition.h"
#import "NSBundle+CTAssetsPickerController.h"
#import "CSAssetGroupPopoverTableViewController.h"

NSString * const CTAssetsViewCellIdentifier = @"CTAssetsViewCellIdentifier";
NSString * const CTAssetsSupplementaryViewIdentifier = @"CTAssetsSupplementaryViewIdentifier";

@interface CTAssetsViewController () <CSAssetGroupPopoverViewControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray *loadingAssets;
@property (nonatomic, strong) NSMutableArray *assetGroups;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) UIButton* btnTitle;

@property (nonatomic, assign) BOOL isSystemSupportCamera;

@end

@implementation CTAssetsViewController

- (id)init {
    self.assetGroups = [[NSMutableArray alloc] init];
    self.loadingAssets = [[NSMutableArray alloc] init];
    self.isSystemSupportCamera = YES;
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UICollectionViewFlowLayout *layout = [self collectionViewFlowLayoutOfOrientation:interfaceOrientation];
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        self.collectionView.allowsMultipleSelection = YES;
        
        [self.collectionView registerClass:CTAssetsViewCell.class
                forCellWithReuseIdentifier:CTAssetsViewCellIdentifier];
        
//        [self.collectionView registerClass:CTAssetsSupplementaryView.class
//                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier];
        
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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

- (void) cancel {
    if ([self.delegate respondsToSelector:@selector(assetsControllerDidCancel:)]) {
        [self.delegate assetsControllerDidCancel:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
//// Check here: http://stackoverflow.com/questions/2798653/is-it-possible-to-determine-whether-viewcontroller-is-presented-as-modal
//-(BOOL)isModal {
//    
//    BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
//                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
//                    ( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
//                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
//                    [[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
//    
//    //iOS 5+
//    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
//        
//        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
//                   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
//                   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
//                   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
//                   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
//        
//    }
//    
//    return isModal;        
//    
//}

- (void) done {
    if ([self.delegate respondsToSelector:@selector(assetController:didSelect:)]) {
        [self.delegate assetController:self didSelect:self.selectedAssets];
    }
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
    [popover setModalPresentationStyle:UIModalPresentationOverFullScreen];
    popover.delegate = self;
    [self presentViewController:popover animated:NO completion:nil];
}

- (void)assetGroupPopover:(CSAssetGroupPopoverTableViewController *)controller didSelectAsset:(ALAssetsGroup *)group {
    self.assetsGroup = group;
    [self setupAssets];
}

- (void)setupGroup {
    NSMutableArray* groups = [[NSMutableArray alloc] init];
    ALAssetsFilter *assetsFilter = [ALAssetsFilter allPhotos];
    ALAssetsLibraryGroupsEnumerationResultsBlock resultsBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            NSLog(@"Loaded group %@", [group valueForProperty:ALAssetsGroupPropertyName]);
            [group setAssetsFilter:assetsFilter];
            int numberOfAsset = [group numberOfAssets];
            if (numberOfAsset > 0) {
                [groups addObject:group];
                if (([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos)) {
                    self.assetsGroup = group;
                    [self setupAssets];
                }
            }
        } else {
            self.assetGroups = groups;
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
//    NSUInteger type = ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupPhotoStream;
//    [[CTAssetsViewController defaultAssetsLibrary] enumerateGroupsWithTypes:type
//                                             usingBlock:resultsBlock
//                                           failureBlock:failureBlock];
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
//    self.navigationItem.rightBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:CTAssetsPickerControllerLocalizedString(@"Done")
//                                     style:UIBarButtonItemStyleDone
//                                    target:self.picker
//                                    action:@selector(finishPickingAssets:)];
//    
//    if (self.picker.alwaysEnableDoneButton)
//        self.navigationItem.rightBarButtonItem.enabled = YES;
//    else
//        self.navigationItem.rightBarButtonItem.enabled = (self.picker.selectedAssets.count > 0);
}

- (void)setupToolbar
{
//    self.toolbarItems = self.picker.toolbarItems;
}

- (void)setupAssets {
    NSLog(@"setupAssets");
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        NSLog(@"Getting asset");
        if (asset) {
            [self.assets addObject:asset];
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
        else {
            NSLog(@"Getted asset");
//            [self reloadData];
        }
    };
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
//    NSIndexSet* set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 5)];
//    [self.assetsGroup enumerateAssetsAtIndexes:set options:NSEnumerationConcurrent usingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
//        NSLog(@"Getting asset");
//                if (asset) {
//        //            [self.loadingAssets addObject:asset];
//        //            if () {
//        //
//        //            }
//                    [self.assets addObject:asset];
////                    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
////                    [self.collectionView reloadData];
//                }
//                else {
//                    NSLog(@"Getted asset");
//                    [self reloadData];
//                }
//        
//    }];
    
}


#pragma mark - Collection View Layout

- (UICollectionViewFlowLayout *)collectionViewFlowLayoutOfOrientation:(UIInterfaceOrientation)orientation
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize             = CTAssetThumbnailSize;
//
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
    layout.footerReferenceSize  = CGSizeMake(0, layout.minimumLineSpacing);
//    float w = self.view.frame.size.width / 3;
//    layout.itemSize = CGSizeMake(w, w);
    return layout;
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
    
//    [[self.toolbarItems objectAtIndex:1] setTitle:[self.picker toolbarTitle]];
    
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
    NSLog(@"Reload data");
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
//    self.collectionView.backgroundView = [self.picker noAssetsView];
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

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell for item");
    CTAssetsViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:CTAssetsViewCellIdentifier
                                              forIndexPath:indexPath];
    if (indexPath.item == 0 && self.isSystemSupportCamera) {
        [cell bindImage:[[UIImage imageNamed:@"ic_photo_camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        cell.backgroundColor = [UIColor grayColor];
        cell.tintColor = [UIColor blueColor];
    } else {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        [cell bind:asset];
    }
    return cell;
}

- (void) showCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Camera Unavailable"
                                                       message:@"Unable to find a camera on your device."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    CTAssetsSupplementaryView *view =
//    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier
//                                              forIndexPath:indexPath];
//    
//    [view bind:self.assets];
//    
//    if (self.assets.count == 0)
//        view.hidden = YES;
//    
//    return view;
//}


#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0 && self.isSystemSupportCamera) {
        
    } else {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        [self.selectedAssets removeObject:asset];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0 && self.isSystemSupportCamera) {
        NSLog(@"Open camera!");
        [self showCamera];
    } else {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        [self.selectedAssets addObject:asset];
    }
}

- (void)dealloc {
    [self removeNotificationObserver];
}

- (void)addNotificationObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(assetsLibraryChanged:)
                   name:ALAssetsLibraryChangedNotification
                 object:nil];
    
}

- (void)removeNotificationObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *originalImage, *imageToSave;
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    imageToSave = originalImage;
    // Save the new image (original or edited) to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
//    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
//
//    
//    // Handle a still image capture
//    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
//        == kCFCompareEqualTo) {
//
//        
//        imageToSave = originalImage;
//        NSLog(@"image Saved");
//        
//
//    }
//    
//    // Handle a movie capture
//    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0)
//        == kCFCompareEqualTo) {
//        
//        NSString *moviePath = [[info objectForKey:
//                                UIImagePickerControllerMediaURL] path];
//        
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
//            UISaveVideoAtPathToSavedPhotosAlbum (
//                                                 moviePath, nil, nil, nil);
//        }
//    }
//
    [picker dismissViewControllerAnimated:YES completion:nil];
//    [[picker parentViewController] dismissModalViewControllerAnimated: YES];
}


@end