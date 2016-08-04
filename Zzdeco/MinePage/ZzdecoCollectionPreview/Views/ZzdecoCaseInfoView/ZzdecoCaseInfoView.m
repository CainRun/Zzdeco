//
//  ZzdecoCaseInfoView.m
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseInfoView.h"

static NSString *cellIdentifier = @"infoCellIdentifier";

@interface ZzdecoCaseInfoView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *infoTableView;

@property (nonatomic, strong, readwrite) UIImageView *backgroundImageView;

@property (nonatomic, strong) FXBlurView *blurView;

@end

@implementation ZzdecoCaseInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = CGRectMake(0, 0, CAL_SCREEN_WIDTH, CAL_SCREEN_HEIGHT);
        
        [self.backgroundImageView addSubview:self.blurView];
        
        [self addSubview:self.backgroundImageView];
        [self addSubview:self.infoTableView];
    }
    
    return self;
}

#pragma mark - Set TableVIew
- (UITableView *)infoTableView {
    
    CAL_GET_METHOD_RETURN_OBJC(_infoTableView);
    
    _infoTableView = [[UITableView alloc] initWithFrame:self.frame];
    
    _infoTableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _infoTableView.dataSource       = self;
    _infoTableView.delegate         = self;
    _infoTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _infoTableView.backgroundColor  = [UIColor clearColor];
    
    _infoTableView.estimatedRowHeight = 100;
    _infoTableView.rowHeight          = UITableViewAutomaticDimension;
    
    _infoTableView.showsVerticalScrollIndicator = NO;

    _infoTableView.contentInset = UIEdgeInsetsMake(CAL_SCREEN_HEIGHT - 52, 0, 0, 0);
    
    return _infoTableView;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor     = [UIColor clearColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    if (indexPath.row == 0) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        cell.textLabel.text = self.caseName;
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.caseInfo;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
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
    
    _blurView.frame      = self.backgroundImageView.frame;
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 10.f;
    
    return _blurView;
}

- (UIImageView *)backgroundImageView {
    
    CAL_GET_METHOD_RETURN_OBJC(_backgroundImageView);
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
    _backgroundImageView.image = [UIImage imageNamed:@"default_background_image"];
    
    return _backgroundImageView;
}

@end
