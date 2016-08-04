//
//  ZzdecoScreenContentViewController.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoScreenContentController.h"
#import "ZzdecoScreenContentTitleCell.h"
#import "ZzdecoScreenContentCell.h"

@interface ZzdecoScreenContentController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@property (nonatomic, weak) NSIndexPath *currentIndexPath;

@end

static ZzdecoScreenContentController *zzdecoScreenContentController = nil;

@implementation ZzdecoScreenContentController

+ (instancetype)zzdecoScreenContentController {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        zzdecoScreenContentController = (ZzdecoScreenContentController *)@"ZzdecoScreenContentController";
        zzdecoScreenContentController = [[ZzdecoScreenContentController alloc] init];
    });
    
    NSString *classString = NSStringFromClass([self class]);
    
    if ([classString isEqualToString:@"ZzdecoScreenContentController"] == NO) {
        NSParameterAssert(nil);
    }
    
    return zzdecoScreenContentController;
}

- (instancetype)init {
    
    NSString *string = (NSString *)zzdecoScreenContentController;
    
    if ([string isKindOfClass:[NSString class]] == YES && [string isEqualToString:@"ZzdecoScreenContentController"]) {
        
        if (self = [super init]) {
            [self preventInheritance];
        }
        
        return self;
    }
    
    return nil;
}

#pragma mark - Prevent Inheritance
- (void)preventInheritance {
    
    NSString *classString = NSStringFromClass([self class]);
    
    if ([classString isEqualToString:@"ZzdecoScreenContentController"] == NO) {
        NSParameterAssert(nil);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.backgroundImageView addSubview:self.blurView];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titleView];
    
    [self addConstraints];
    [self setTitleViewButtonActionBlock];
    
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.top.right;
        make.width.mas_equalTo(CAL_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
}

#pragma mark - Set Title View
- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView = [CALBaseControllerTitleView new];
    
    return _titleView;
}

- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Table View Data Source Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    CAL_WEAK_SELF(weakSelf);
    
    switch (indexPath.row) {
        case 0: {
            
            ZzdecoScreenContentTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"calScreenContentTitleCell"];
            
            titleCell = [[ZzdecoScreenContentTitleCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                            reuseIdentifier:@"calScreenContentTitleCell"];
            titleCell.titleString     = @"筛选";
            titleCell.backgroundColor = [UIColor clearColor];
            titleCell.selectionStyle  = UITableViewCellSelectionStyleNone;
            
            return titleCell;
        }

            
        case 3: {
            NSArray *spaceArray = @[@"不限", @"客厅", @"卧室", @"餐厅", @"厨房",
                                    @"吧台", @"儿童房", @"卫生间", @"衣帽间", @"书房",
                                    @"私人影院", @"吊顶", @"楼梯", @"地板", @"软装",
                                    @"阳台", @"门窗", @"走廊", @"玄关", @"墙面",
                                    @"庭院", @"车库", @"平面设计图", @"其他"];

            ZzdecoScreenContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"calScreenContentCell"];
            
            contentCell = [[ZzdecoScreenContentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:@"calScreenContentCell"];

            contentCell.typeString = @"空间:";
            contentCell.typeArray  = spaceArray;
            contentCell.indexPath  = indexPath.row - 1;

            contentCell.backgroundColor = [UIColor clearColor];
            contentCell.selectionStyle  = UITableViewCellSelectionStyleNone;

            [contentCell setLabelCollectionViewData];
            
            [contentCell setDidSelectedItemAction:^{
                [self tableViewCellSelectedChangeNotification:indexPath];
            }];
            
            [contentCell setZzdecoScreenContentCellBlock:^(NSInteger index, NSInteger typeID) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];

                if (self.zzdecoScreenContentBlock) {
                    self.zzdecoScreenContentBlock(index, typeID);
                }
            }];

            return contentCell;
        }
            
        default: {
            
            NSArray *typeString = @[@"风格:", @"类型:"];
            
            NSArray *styleArray = @[@"不限", @"简约现代", @"欧式", @"美式", @"工业",
                                    @"混搭", @"田园", @"地中海", @"东南亚", @"中式",
                                    @"日式", @"古典"];
            
            NSArray *typeArray  = @[@"不限", @"别墅", @"住宅", @"公寓", @"酒店", @"写字楼", @"商铺"];
            
            NSArray *dataArray = [NSArray arrayWithObjects:styleArray, typeArray, nil];

            ZzdecoScreenContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"calScreenContentCell"];
            
            contentCell = [[ZzdecoScreenContentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:@"calScreenContentCell"];
            
            contentCell.typeString = typeString[indexPath.row - 1];
            contentCell.typeArray  = dataArray[indexPath.row - 1];
            contentCell.isNeedLine = YES;
            contentCell.indexPath  = indexPath.row - 1;

            contentCell.selectionStyle         = UITableViewCellSelectionStyleNone;
            contentCell.backgroundColor        = [UIColor clearColor];
            contentCell.tableViewCellLineStyle = CALBaseTableViewCellTwoSpacingStyle;

            [contentCell setLabelCollectionViewData];
            
            [contentCell setDidSelectedItemAction:^{
                [self tableViewCellSelectedChangeNotification:indexPath];
            }];
            
            [contentCell setZzdecoScreenContentCellBlock:^(NSInteger index, NSInteger typeID) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
                
                if (self.zzdecoScreenContentBlock) {
                    self.zzdecoScreenContentBlock(index, typeID);
                }
            }];
            
            return contentCell;
        }
    }
    
    return nil;
}

- (void)tableViewCellSelectedChangeNotification:(NSIndexPath *)indexPath {
    
    NSAssert(indexPath.row > 0, @"your tableView layout did change or indexPath error");
    
    NSIndexPath *firstIndexPath  = nil;
    NSIndexPath *secondIndexPath = nil;
    
    NSInteger firstRow  = 0;
    NSInteger secondRow = 0;
    
    NSInteger section = 0;
    
    switch (indexPath.row) {
            
        case 1: {
            
            firstRow = 2;
            secondRow = 3;
        }
            break;
            
        case 2: {
            
            firstRow = 1;
            secondRow = 3;
        }
            break;
            
        case 3: {
            firstRow = 2;
            secondRow = 1;
        }
            break;
            
        default:
            break;
    }
    
    firstIndexPath  = [NSIndexPath indexPathForRow:firstRow inSection:section];
    secondIndexPath = [NSIndexPath indexPathForRow:secondRow inSection:section];
    
    ZzdecoScreenContentCell *firstCell = [self.tableView cellForRowAtIndexPath:firstIndexPath];
    ZzdecoScreenContentCell *secondCell = [self.tableView cellForRowAtIndexPath:secondIndexPath];
    
    [firstCell cancelCurrentItem];
    [secondCell cancelCurrentItem];
    
    [firstCell firstItemSelected:YES];
    [secondCell firstItemSelected:YES];
}

- (ZzdecoScreenContentCell *)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    NSArray *typeString = @[@"风格:", @"类型:"];
    
    NSArray *styleArray = @[@"不限", @"简约现代", @"欧式", @"美式", @"工业",
                            @"混搭", @"田园", @"地中海", @"东南亚", @"中式",
                            @"日式", @"古典"];
    
    NSArray *typeArray  = @[@"不限", @"别墅", @"住宅", @"公寓", @"酒店", @"写字楼", @"商铺"];
    
    NSArray *dataArray = [NSArray arrayWithObjects:styleArray, typeArray, nil];
    
    ZzdecoScreenContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"calScreenContentCell"];
    
    contentCell.typeString             = typeString[indexPath.row - 1];
    contentCell.typeArray              = dataArray[indexPath.row - 1];
    contentCell.isNeedLine             = YES;
    contentCell.tableViewCellLineStyle = CALBaseTableViewCellTwoSpacingStyle;
    contentCell.indexPath              = indexPath.row - 1;
    
    [contentCell setLabelCollectionViewData];
    
    [contentCell setDidSelectedItemAction:^{
        ZzdecoScreenContentCell *firstCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [firstCell cancelCurrentItem];
        [firstCell firstItemSelected:YES];
    }];
    
    return contentCell;
}

#pragma mark - TableView Delegate Method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            
            return CAL_WIDTH_TO_FIT(160);
            
        case 1:
            
            return CAL_SCREEN_WIDTH > 320 ? CAL_WIDTH_TO_FIT(260) : CAL_WIDTH_TO_FIT(300);
            
        case 2:
            
            return CAL_SCREEN_WIDTH > 320 ? CAL_WIDTH_TO_FIT(190) : CAL_WIDTH_TO_FIT(230);
            
        case 3:
            
            return CAL_WIDTH_TO_FIT(540);
            
        default:
            break;
    }
    
    return CAL_WIDTH_TO_FIT(220);
}

#pragma mark - Set blur View
- (FXBlurView *)blurView {
    
    CAL_GET_METHOD_RETURN_OBJC(_blurView);
    
    _blurView = [[FXBlurView alloc] init];
    
    _blurView.frame      = self.backgroundImageView.frame;
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 10.f;
    
    return _blurView;
}

- (UITableView *)tableView {
    
    CAL_GET_METHOD_RETURN_OBJC(_tableView);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT - 44)];
    
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    
    return _tableView;
}

- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT)];
    _backgroundImageView.image = [UIImage imageNamed:@"default_background_image"];
    _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView.clipsToBounds = YES;

    return _backgroundImageView;
}

@end
