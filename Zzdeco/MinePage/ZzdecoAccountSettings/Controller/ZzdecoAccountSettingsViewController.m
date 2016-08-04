//
//  ZzdecoAccountSettingsViewController.m
//  Zzdeco
//
//  Created by Cain on 5/6/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoAccountSettingsViewController.h"

@interface ZzdecoAccountSettingsViewController ()

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@end

@implementation ZzdecoAccountSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
    
    [self setTitleViewButtonActionBlock];
}

- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView = [CALBaseControllerTitleView new];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0: {

            UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALMyPage" bundle:nil];
            UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calMyCollectionViewController"];
            
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 1: {
            
            UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALMyPage" bundle:nil];
            UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calUserInfoViewController"];
            
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        default:
            break;
    }
    
}

@end
