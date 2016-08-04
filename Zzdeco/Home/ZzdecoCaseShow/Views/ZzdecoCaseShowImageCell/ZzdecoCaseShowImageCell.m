//
//  ZzdecoCaseShowImageCell.m
//  Zzdeco
//
//  Created by Cain on 5/8/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseShowImageCell.h"

@interface ZzdecoCaseShowImageCell()

@property (nonatomic, strong, readwrite) UIImageView *infoImage;

@end

@implementation ZzdecoCaseShowImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.infoImage];
        
        [self addConstraints];
    }
    
    return self;
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.infoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.bottom.right.equalTo(self.contentView).insets(UIEdgeInsetsMake(CAL_WIDTH_TO_FIT(20), CAL_WIDTH_TO_FIT(20), 0, CAL_WIDTH_TO_FIT(20)));
    }];
}

#pragma mark - Set Info Image
- (UIImageView *)infoImage {
    
    CAL_GET_METHOD_RETURN_OBJC(_infoImage);
    
    _infoImage = [[UIImageView alloc] init];
    _infoImage.backgroundColor = [UIColor clearColor];
    
    return _infoImage;
}

@end
