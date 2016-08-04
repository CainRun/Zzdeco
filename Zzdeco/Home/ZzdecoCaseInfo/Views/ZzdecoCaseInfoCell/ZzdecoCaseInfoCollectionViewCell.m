//
//  ZzdecoCaseInfoCollectionViewCell.m
//  Zzdeco
//
//  Created by Cain on 5/16/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseInfoCollectionViewCell.h"
#import "ZzdecoCaseShowViewController.h"
#import "ZzdecoCaseInfoViewCollectionViewCell.h"

static NSString *cellIdentifier = @"infoCellIdentifier";
@interface ZzdecoCaseInfoCollectionViewCell () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) UIImage *blurImage;

@property (nonatomic, strong) FXBlurView *blurView;

@end

@implementation ZzdecoCaseInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.backgroundImageView addSubview:self.blurView];

        [self.contentView addSubview:self.backgroundImageView];
        [self.contentView addSubview:self.infoTableView];
        
        self.infoTableView.delegate = self;
        
        [self.infoTableView reloadData];
        
        [self setInfoViewRefreshFooter];        
    }
    
    return self;
}

#pragma mark - Set Background Image View
- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT)];
    _backgroundImageView.image = [UIImage imageNamed:@"default_background_image"];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.clipsToBounds = YES;

    return _backgroundImageView;
}

#pragma mark - Set Table View
- (UITableView *)infoTableView {

    CAL_GET_METHOD_RETURN_OBJC(_infoTableView);
    
    _infoTableView = [[UITableView alloc] initWithFrame:self.bounds];
    
    _infoTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _infoTableView.dataSource       = self;
    _infoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _infoTableView.backgroundColor  = [UIColor clearColor];
    
    _infoTableView.estimatedRowHeight = 100;
    _infoTableView.rowHeight          = UITableViewAutomaticDimension;
    
    _infoTableView.showsVerticalScrollIndicator = NO;
    
    _infoTableView.contentInset = UIEdgeInsetsMake(CAL_SCREEN_HEIGHT - 52, 0, 0, 0);
    
    return _infoTableView;
}

#pragma mark - Table View Data Source Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor     = [UIColor clearColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
        
    if (indexPath.row == 0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        cell.textLabel.text = self.caseTitle;

    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.caseInfo;
    }
    
    return cell;
}

#pragma mark - Set Refresh Footer View
- (void)setInfoViewRefreshFooter {
    
    CAL_WEAK_SELF(weakSelf);
    
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (self.zzdecoCaseInfoCollectionViewBlock) {
            
            self.zzdecoCaseInfoCollectionViewBlock();
        }
        
        [weakSelf.infoTableView.mj_footer endRefreshing];
    }];
    
    refreshFooter.height                     = 50.f;
    refreshFooter.stateLabel.textColor       = [UIColor whiteColor];
    refreshFooter.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    self.infoTableView.mj_footer = refreshFooter;
}

- (void)reloadTableViewData {
    [self.infoTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.backgroundImageView.image) {
        
        CGFloat radius = (scrollView.contentOffset.y + (CAL_SCREEN_HEIGHT - 52)) / 10 - CAL_WIDTH_TO_FIT(0.6);
        
        if (radius <= 0) {
            
            self.blurView.hidden = YES;
            
        } else {

            self.blurView.hidden = NO;
            self.blurView.blurRadius = radius;
        }
    }
}

#pragma mark - Set blur View
- (FXBlurView *)blurView {
    
    CAL_GET_METHOD_RETURN_OBJC(_blurView);
    
    _blurView = [[FXBlurView alloc] init];
    
    _blurView.hidden     = YES;
    _blurView.frame      = self.backgroundImageView.frame;
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 0.f;
    
    return _blurView;
}

@end
