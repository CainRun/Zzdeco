//
//  ZzdecoRestUserNameViewController.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoChangeUserNameController.h"
#import "ZzdecoChangeUserNameViewModel.h"
#import "ZzdecoChangeUserNameView.h"

@interface ZzdecoChangeUserNameController ()

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;
@property (nonatomic, strong) ZzdecoChangeUserNameViewModel *restUserNameViewModel;
@property (nonatomic, strong) ZzdecoChangeUserNameView *restUserNameView;

@end

@implementation ZzdecoChangeUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.restUserNameView];

    [self addConstraints];
    
    [self setTitleViewReturnBlock];
}

- (void)addConstraints {
    
    [self.restUserNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        (void)make.left.right.bottom;
    }];
}

- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                = [CALBaseControllerTitleView new];
    
    _titleView.backgroundColor            = CAL_COLOR_FROM_HEX_CODE(0x3c3c3c);
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-return"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-return-click"];
    _titleView.titleViewTitle             = @"用户名";
    _titleView.titleStyle                 = CALBaseControllerTitleViewCenterStyle;
    _titleView.titleTextColor             = [UIColor whiteColor];
    
    return _titleView;
}

#pragma mark - Set Rest User Name View
- (ZzdecoChangeUserNameView *)restUserNameView {
    
    CAL_GET_METHOD_RETURN_OBJC(_restUserNameView);
    
    _restUserNameView = [[ZzdecoChangeUserNameView alloc] init];
    _restUserNameView.userName = self.userNameString;
    
    CAL_WEAK_SELF(weakSelf);
    
    [_restUserNameView setZzdecoCompleteButtonBlock:^(NSString *userName){
        
         if (userName) {
         
             [weakSelf.restUserNameViewModel restUserNameRequest:userName];
             
             if (weakSelf.calRestUserNameBlock) {
             
                 weakSelf.calRestUserNameBlock();
             }
         }
    }];
    
    return _restUserNameView;
}

- (void)setTitleViewReturnBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        [weakSelf popViewController];
    }];
}

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Set Rest User Name View Model
- (ZzdecoChangeUserNameViewModel *)restUserNameViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_restUserNameViewModel);
    
    _restUserNameViewModel = [[ZzdecoChangeUserNameViewModel alloc] initRestUserNameViewModelWithController:self];
    
    return _restUserNameViewModel;
}

@end
