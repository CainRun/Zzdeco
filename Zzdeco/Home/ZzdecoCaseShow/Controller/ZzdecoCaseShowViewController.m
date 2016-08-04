//
//  ZzdecoCaseShowViewController.m
//  Zzdeco
//
//  Created by Cain on 5/15/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseShowViewController.h"
#import "ZzdecoCaseShowViewModel.h"

@interface ZzdecoCaseShowViewController ()

@property (nonatomic, strong, readwrite) ZzdecoCaseShowView *showImageView;
@property (nonatomic, strong) ZzdecoCaseShowViewModel *caseShowViewModel;
@property (nonatomic, strong, readwrite) CALBaseControllerSubTitleView *subTitleView;

@property (nonatomic, strong) FXBlurView *blurView;

@end

@implementation ZzdecoCaseShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backgroundImageView addSubview:self.blurView];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.showImageView];
    [self.view addSubview:self.subTitleView];
    
    [self setSubTitleButtonBlock];
    [self addConstraints];
    
    [self.caseShowViewModel caseShowRequest];
}

#pragma mark - Add Show Image View Constraints
- (void)addConstraints {
    
    [self.showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
       (void)make.edges;
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
    
    [self.subTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.right;
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(CAL_WIDTH_TO_FIT(88));
    }];
    
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        (void)make.edges;
    }];
}


#pragma mark - Set Sub Title View
- (CALBaseControllerSubTitleView *)subTitleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_subTitleView);
    
    _subTitleView = [[CALBaseControllerSubTitleView alloc] init];
    
    CAL_WEAK_SELF(weakSelf);

    [_subTitleView setCalControllerSubTitleViewLeftBlock:^(UIButton *dismissButton) {
        
        [weakSelf.showImageView.imageTableView.mj_header endRefreshing];

        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [_subTitleView setCalControllerSubTitleViewRightBlock:^(UIButton *collectionButton) {

        NSDictionary *parameters = @{@"projectId" : weakSelf.caseID,
                                     @"acstate" : [NSString stringWithFormat:@"%d", !weakSelf.subTitleView.isAcstate]};
        
        [weakSelf.caseShowViewModel collectionCase:parameters];        
    }];

    return _subTitleView;
}

#pragma mark - Set Show Case Image View
- (ZzdecoCaseShowView *)showImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_showImageView);
    
    _showImageView = [[ZzdecoCaseShowView alloc] initWithFrame:CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT - CAL_WIDTH_TO_FIT(64))];

    CAL_WEAK_SELF(weakSelf);
    
    [_showImageView setZzdecoCaseShowLoadDataBlock:^{
        
        [weakSelf.caseShowViewModel caseShowRequest];
        
        [weakSelf.showImageView.imageTableView.mj_footer endRefreshing];
    }];
    
    return _showImageView;
}

#pragma mark - Set Background Image View
- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView = [[UIImageView alloc] init];

    return _backgroundImageView;
}

#pragma mark - Set Sub Title Button Block
- (void)setSubTitleButtonBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.showImageView setZzdecoCaseShowDissmissBlock:^{
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (FXBlurView *)blurView {
    
    CAL_GET_METHOD_RETURN_OBJC(_blurView);
    
    _blurView = [[FXBlurView alloc] init];
    
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 10.f;
    
    return _blurView;
}

#pragma mark - Set Case View Model
- (ZzdecoCaseShowViewModel *)caseShowViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_caseShowViewModel);
    
    _caseShowViewModel = [[ZzdecoCaseShowViewModel alloc] initCaseInfoViewModel:self];
    
    _caseShowViewModel.caseID = self.caseID;

    return _caseShowViewModel;
}

@end
