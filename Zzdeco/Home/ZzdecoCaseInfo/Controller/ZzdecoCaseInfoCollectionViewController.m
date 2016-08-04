//
//  ZzdecoCaseInfoCollectionViewController.m
//  Zzdeco
//
//  Created by Cain on 5/16/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseInfoCollectionViewController.h"
#import "ZzdecoCaseInfoCollectionViewCell.h"
#import "ZzdecoCaseShowViewController.h"
#import "ZzdecoCaseInfoViewModel.h"

#import "ZzdecoScreenContentController.h"


#import "ZzdecoMyCollectionViewController.h"

@interface ZzdecoCaseInfoCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) UIImageView *backgroundImageView;
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;
@property (nonatomic, strong) ZzdecoCaseInfoViewModel    *caseInfoViewModel;

@property (nonatomic, strong) NSMutableDictionary *parameter;

@end

static NSString *collectionViewCellID = @"collectionViewCell";

@implementation ZzdecoCaseInfoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.caseInfoViewModel caseInfoRequest];

    [self setTitleViewButtonActionBlock];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.titleView];
        
    [self.collectionView registerClass:ZzdecoCaseInfoCollectionViewCell.class forCellWithReuseIdentifier:collectionViewCellID];
    
    [self addConstraints];
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.top.right;
        make.width.mas_equalTo(CAL_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
}

#pragma mark - Set Background Image View
- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView       = [UIImageView new];
    _backgroundImageView.image = [UIImage imageNamed:@"default_background_image"];
    
    return _backgroundImageView;
}

#pragma mark - Set Info Mutable Array
- (NSMutableArray *)dataSource {
    
    CAL_GET_METHOD_RETURN_OBJC(_dataSource);
    
    _dataSource = [NSMutableArray array];
    
    [_dataSource removeAllObjects];
    
    return _dataSource;
}

#pragma mark - Set Collection View
- (UICollectionView *)collectionView {
    
    CAL_GET_METHOD_RETURN_OBJC(_collectionView);
    
    _collectionView                 = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:self.flowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.delegate        = self;
    _collectionView.dataSource      = self;
    _collectionView.pagingEnabled   = YES;
    
    _collectionView.showsVerticalScrollIndicator   = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    return _collectionView;
}

#pragma mark - Set Collection Flow Layout
- (UICollectionViewFlowLayout *)flowLayout {
    
    CAL_GET_METHOD_RETURN_OBJC(_flowLayout);
    
    _flowLayout                         = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumLineSpacing      = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.itemSize                = CGSizeMake(CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT);
    _flowLayout.sectionInset            = UIEdgeInsetsMake(0, 0, 0, 0);
    
    return _flowLayout;
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                   = [CALBaseControllerTitleView new];
    _titleView.titleStyle        = CALBaseControllerTitleViewRightStyle;
    _titleView.hiddenRightButton = NO;
    
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-menu"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-menu-click"];
    
    _titleView.rightButtonTitle = @"筛选";
    
    return _titleView;
}

#pragma mark - View Controller Title View Block
- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(weakSelf);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        if (CAL_LOGIN_SUCCESS) {
            
            UIStoryboard *board = [UIStoryboard storyboardWithName:@"CALMyPage" bundle:nil];
            UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"calAccountSettingsViewController"];
            [weakSelf.navigationController pushViewController:viewController animated:YES];
            
            return;
        } else {
            
            UIStoryboard *board              = [UIStoryboard storyboardWithName:@"CALLoginRegister" bundle:nil];
            UIViewController *viewController = [board instantiateViewControllerWithIdentifier:@"zzdecoCheckPhoneController"];
            
            [weakSelf.navigationController pushViewController:viewController animated:YES];
            
            return;
        }
    }];
    
    [self.titleView setCalControllerTitleViewRightBlock:^(UIButton *rightButton) {
        
        ZzdecoScreenContentController *viewController = [ZzdecoScreenContentController zzdecoScreenContentController];
        
        [viewController setZzdecoScreenContentBlock:^(NSInteger index, NSInteger typeID) {
            
            [weakSelf.caseInfoViewModel.parameter removeAllObjects];

            if (typeID != 0) {
            
                switch (index) {
                    case 1:
                        
                        [weakSelf.caseInfoViewModel.parameter setObject:[NSString stringWithFormat:@"%ld", (long)typeID] forKey:@"propertyType"];
                        
                        break;
                    case 2:
                        
                        if (typeID == 23) {
                            
                            [weakSelf.caseInfoViewModel.parameter setObject:[NSString stringWithFormat:@"%d", 150] forKey:@"pftType"];
                            
                            break;
                        }

                        [weakSelf.caseInfoViewModel.parameter setObject:[NSString stringWithFormat:@"%ld", (long)typeID] forKey:@"pftType"];
                        break;
                    default:
                        
                        [weakSelf.caseInfoViewModel.parameter setObject:[NSString stringWithFormat:@"%ld", (long)typeID] forKey:@"houseStyle"];
                        
                        break;
                }
            }
            
            [weakSelf.dataSource removeAllObjects];
            
            weakSelf.caseInfoViewModel.pageCount = 1;
                        
            [weakSelf.caseInfoViewModel caseInfoRequest];
        }];
        
        [weakSelf presentViewController:viewController animated:YES completion:nil];
    }];
}

#pragma mark - UICollectionView Data Source Method
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZzdecoCaseInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    ZzdecoDataListModel *dataListModel = self.dataSource[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:dataListModel.firstShow];
    
    cell.backgroundColor = [UIColor clearColor];
    
    CAL_WEAK_SELF(weakSelf);
    
    [cell setZzdecoCaseInfoCollectionViewBlock:^{
        
        ZzdecoCaseShowViewController *caseShowView = [ZzdecoCaseShowViewController new];
        
        caseShowView.caseID = dataListModel.idIos;

        [caseShowView.backgroundImageView setImageWithURL:url placeholderImage:nil];

        [weakSelf presentViewController:caseShowView animated:YES completion:nil];
    }];
    
    [cell.backgroundImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_background_image"]];
        
    [AppDelegate userInfoAppDelegate].backgroundImageURL = url;
    
    cell.caseTitle = dataListModel.projectName;
    cell.caseInfo = dataListModel.projectContent;
    
    [cell reloadTableViewData];
        
    return cell;
}

#pragma mark - Set Case Info View Model
- (ZzdecoCaseInfoViewModel *)caseInfoViewModel {
    
    CAL_GET_METHOD_RETURN_OBJC(_caseInfoViewModel);
    
    _caseInfoViewModel = [[ZzdecoCaseInfoViewModel alloc] initCaseInfoViewModel:self];
    
    return _caseInfoViewModel;
}

#pragma mark - Set Request Parameter
- (NSMutableDictionary *)parameter {
    
    CAL_GET_METHOD_RETURN_OBJC(_parameter);
    
    _parameter = [NSMutableDictionary dictionary];
    
    return _parameter;
}

#pragma mark - ScrollView Delegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:) withObject:nil afterDelay:0.1];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.caseInfoViewModel caseInfoRequest];
}

@end
