//
//  ZzdecoMyCollectionViewController.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoMyCollectionViewController.h"
#import "ZzdecoMyCollectionViewCell.h"
#import "ZzdecoMyCollectionViewModel.h"

#import "ZzdecoCollectionPreviewController.h"
#import "ZzdecoMyCollectionDataListModel.h"

@interface ZzdecoMyCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic, readwrite) IBOutlet UICollectionView *CALMyCollectionCollectionView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;
@property (nonatomic, strong) ZzdecoMyCollectionViewModel *myCollectionViewModel;

@end

@implementation ZzdecoMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleView];
    
    [self setCollectionViewHeader];
    [self setTitleViewButtonActionBlock];
    
    [self.CALMyCollectionCollectionView.mj_header beginRefreshing];
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

#pragma mark - Collection View Data Source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSourceArray ? [self.dataSourceArray count] : 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZzdecoMyCollectionDataListModel *dataList = self.dataSourceArray[indexPath.row];

    ZzdecoMyCollectionViewCell *myCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"calMyCollectionViewCell" forIndexPath:indexPath];
    
    myCollectionViewCell.caseName = dataList.acprojectName;
    myCollectionViewCell.cellID   = dataList.id;
    
    NSURL *url = [NSURL URLWithString:dataList.acprojectPicture];
    
    [myCollectionViewCell.calCasePicture setImageWithURL:url
                                        placeholderImage:[UIImage imageNamed:@"Load-Fail"]];
    
    [myCollectionViewCell setCalCaseBackgroundView];
    
    return myCollectionViewCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZzdecoMyCollectionDataListModel *dataList = self.dataSourceArray[indexPath.row];
    
    ZzdecoCollectionPreviewController *collectionPreviewViewController = [[ZzdecoCollectionPreviewController alloc] init];
    
    collectionPreviewViewController.caseID = dataList.projectId;
    
    [self.navigationController pushViewController:collectionPreviewViewController animated:YES];
}

#pragma mark - Collection View Layout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.CALMyCollectionCollectionView.width / 2 - CAL_WIDTH_TO_FIT(50), CAL_WIDTH_TO_FIT(320));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(CAL_WIDTH_TO_FIT(30), CAL_WIDTH_TO_FIT(30), CAL_WIDTH_TO_FIT(10), CAL_WIDTH_TO_FIT(30));
}

- (void)setCollectionViewHeader {
    
    CAL_WEAK_SELF(weakSelf);
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf.myCollectionViewModel getMyCollectionList];
        
        [weakSelf.CALMyCollectionCollectionView.mj_header endRefreshing];
    }];
    
    refreshHeader.height = 50.f;
    
    self.CALMyCollectionCollectionView.mj_header = refreshHeader;
}

- (ZzdecoMyCollectionViewModel *)myCollectionViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_myCollectionViewModel);
    
    _myCollectionViewModel = [[ZzdecoMyCollectionViewModel alloc] initCollectionViewModelWithController:self];
    
    return _myCollectionViewModel;
}

@end
