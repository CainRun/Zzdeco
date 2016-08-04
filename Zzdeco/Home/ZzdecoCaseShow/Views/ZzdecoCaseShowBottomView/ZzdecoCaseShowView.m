//
//  ZzdecoCaseShowView.m
//  Zzdeco
//
//  Created by Cain on 5/15/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseShowView.h"
#import "ZzdecoCaseShowImageCell.h"
#import "ZzdecoCaseDataListModel.h"

static NSString *imageCellIdentifier = @"imageCell";

@interface ZzdecoCaseShowView() <UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *imageTableView;

@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIButton *collectionButton;

@end

@implementation ZzdecoCaseShowView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageTableView];
        
        [self addConstraints];
        [self setImageTableViewRefreshHeader];
    }
    
    return self;
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.imageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.top.left.right;
        make.height.mas_equalTo(CAL_SCREEN_HEIGHT - CAL_WIDTH_TO_FIT(88));
    }];    
}

- (NSMutableArray *)imageArray {
    
    CAL_GET_METHOD_RETURN_OBJC(_imageArray);
    
    _imageArray = [NSMutableArray array];
    
    [_imageArray removeAllObjects];
    
    return _imageArray;
}

#pragma mark - Set TableView
- (UITableView *)imageTableView {
    
    CAL_GET_METHOD_RETURN_OBJC(_imageTableView);
    
    _imageTableView                 = [[UITableView alloc] init];
    _imageTableView.dataSource      = self;
    _imageTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _imageTableView.backgroundColor = [UIColor clearColor];
    
    _imageTableView.showsVerticalScrollIndicator = NO;
    
    _imageTableView.estimatedRowHeight = 100;
    _imageTableView.rowHeight = UITableViewAutomaticDimension;

    return _imageTableView;
}

#pragma mark - Table View Data Source Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ZzdecoCaseDataListModel *dataListModel = self.imageArray[indexPath.row];

    ZzdecoCaseShowImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:imageCellIdentifier];
    
    imageCell = [[ZzdecoCaseShowImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:imageCellIdentifier];
    
    imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    imageCell.backgroundColor = [UIColor clearColor];
    
    [imageCell.infoImage setImageWithURL:[NSURL URLWithString:dataListModel.fileName]];
    
    return imageCell;
}

#pragma mark - Set Table View Refresh Header
- (void)setImageTableViewRefreshHeader {
    
    CAL_WEAK_SELF(weakSelf);
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (weakSelf.zzdecoCaseShowDissmissBlock) {
            weakSelf.zzdecoCaseShowDissmissBlock();
        }
    }];
    
    refreshHeader.height                      = 50.f;
    refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    refreshHeader.stateLabel.textColor        = [UIColor whiteColor];
    refreshHeader.activityIndicatorViewStyle  = UIActivityIndicatorViewStyleWhite;
    
    self.imageTableView.mj_header = refreshHeader;
}

@end
