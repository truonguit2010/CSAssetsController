//
//  ViewController.m
//  CSAssetController
//
//  Created by truongps on 7/18/15.
//  Copyright (c) 2015 CS. All rights reserved.
//

#import "ViewController.h"
#import "NYTViewController.h"
#import "TableViewController.h"
#import "CSAssetPicker/CTAssetsViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIStoryboard* a = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        NYTViewController* controller = (NYTViewController*)[a instantiateViewControllerWithIdentifier:@"Main_iPhone"];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 1) {
        TableViewController* controller = [[TableViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (indexPath.row == 2) {
        CTAssetsViewController *picker = [[CTAssetsViewController alloc] init];
        [self.navigationController pushViewController:picker animated:YES];
//        picker.delegate = self;
//        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:picker];
//        [self presentViewController:nav animated:YES completion:nil];
    }
}



@end
