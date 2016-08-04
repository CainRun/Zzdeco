//
//  ZzdecoCaseInfoViewCollectionViewCell.m
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseInfoViewCollectionViewCell.h"

@interface ZzdecoCaseInfoViewCollectionViewCell() <UITableViewDataSource>

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong, readwrite) UITableView *infoTableView;

@end

@implementation ZzdecoCaseInfoViewCollectionViewCell

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT);
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.infoTableView];
    }
    
    return self;
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.edges;
    }];
}

#pragma mark - Set BackgroundImageView
- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView       = [UIImageView new];
    _backgroundImageView.image = self.backgroundImage;
    
    return _backgroundImageView;
}

#pragma mark - Set TableVIew
- (UITableView *)infoTableView {
    
    CAL_GET_METHOD_RETURN_OBJC(_infoTableView);
    
    _infoTableView = [UITableView new];
    
    _infoTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _infoTableView.dataSource       = self;
    _infoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _infoTableView.backgroundColor  = [UIColor clearColor];
    
    _infoTableView.estimatedRowHeight = 100;
    _infoTableView.rowHeight          = UITableViewAutomaticDimension;
    
    _infoTableView.contentInset = UIEdgeInsetsMake(CAL_SCREEN_HEIGHT - 52, 0, 0, 0);
    
    return _infoTableView;
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor     = [UIColor clearColor];
        
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    if (indexPath.row == 0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    cell.textLabel.text          = self.infoArray[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

@end
