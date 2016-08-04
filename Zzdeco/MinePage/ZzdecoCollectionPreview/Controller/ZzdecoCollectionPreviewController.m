//
//  ZzdecoCollectionPreviewViewController.m
//  Zzdeco
//
//  Created by Cain on 5/11/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCollectionPreviewController.h"

#import "ZzdecoCaseShowImageCell.h"

#import "ZzdecoCaseShowViewController.h"

#import "ZzdecoCollectionPreviewViewModel.h"

@interface ZzdecoCollectionPreviewController ()

@property (nonatomic, strong, readwrite) ZzdecoCaseInfoView *infoView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, strong) ZzdecoCollectionPreviewViewModel *collectionPreviewViewModel;

@end

@implementation ZzdecoCollectionPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setinfoViewRefreshFooter];
    
    [self setTitleViewButtonActionBlock];
    
    [self.collectionPreviewViewModel collectionCaseInfoRequest:self.caseID];
    
    [self.view addSubview:self.infoView];
    [self.view addSubview:self.titleView];
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

#pragma mark - Set Sub Views
- (ZzdecoCaseInfoView *)infoView {
    
    CAL_GET_METHOD_RETURN_OBJC(_infoView);
    
    _infoView = [[ZzdecoCaseInfoView alloc] initWithFrame:self.view.frame];

    return _infoView;
}

#pragma mark - Set Refresh Footer View
- (void)setinfoViewRefreshFooter {
    
    CAL_WEAK_SELF(weakSelf);
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        ZzdecoCaseShowViewController *showViewController = [ZzdecoCaseShowViewController new];
        
        showViewController.caseID = weakSelf.caseID;
        
        [weakSelf.infoView.infoTableView.mj_footer endRefreshing];
        
        [weakSelf presentViewController:showViewController animated:YES completion:nil];
    }];
    
    refreshFooter.height                     = 50.f;
    refreshFooter.stateLabel.textColor       = [UIColor whiteColor];
    refreshFooter.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    self.infoView.infoTableView.mj_footer = refreshFooter;
}

- (ZzdecoCollectionPreviewViewModel *)collectionPreviewViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_collectionPreviewViewModel);
    
    _collectionPreviewViewModel = [[ZzdecoCollectionPreviewViewModel alloc] initCollectionPreviewViewModelWithController:self];
    
    return _collectionPreviewViewModel;
}

@end
