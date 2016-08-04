//
//  CALScreenContentCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoScreenContentCell.h"
#import "ZzdecoScreenContentLabelCollectionViewCell.h"

@interface ZzdecoScreenContentCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UICollectionView *labelCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, weak) ZzdecoScreenContentLabelCollectionViewCell *currentItem;
@end

static NSString *collectionViewCellID = @"calScreenContentLabelCollectionViewCell";

@implementation ZzdecoScreenContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.typeLabel];
        
    }
    
    return self;
}

- (void)setLabelCollectionViewData {
    
    [self configure];
    
    [self.contentView addSubview:self.labelCollectionView];
    
    [self addConstraints];
}

#pragma mark - Register UICollectionViewCell
- (void)configure {
    
    [self.labelCollectionView registerClass:ZzdecoScreenContentLabelCollectionViewCell.class
                 forCellWithReuseIdentifier:collectionViewCellID];
}

#pragma mark - Set UIKit Constraints
- (void)addConstraints {
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(CAL_WIDTH_TO_FIT(44));
        make.top.equalTo(self).offset(CAL_WIDTH_TO_FIT(20));
        make.width.mas_offset(50);
    }];
    
    [self.labelCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.typeLabel).offset(CAL_WIDTH_TO_FIT(-12));
        make.left.equalTo(self.typeLabel.mas_right).offset(CAL_WIDTH_TO_FIT(8));
        make.bottom.equalTo(self).offset(CAL_WIDTH_TO_FIT(-18));
        make.right.equalTo(self).offset(CAL_WIDTH_TO_FIT(-15));
    }];
}

#pragma mark - Set Type Label
- (UILabel *)typeLabel {
    
    CAL_GET_METHOD_RETURN_OBJC(_typeLabel);
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    
    return _typeLabel;
}

- (void)setTypeString:(NSString *)typeString {
    
    self.typeLabel.text = typeString;
}

#pragma mark - CollectionView Data Source Mothed
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.typeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZzdecoScreenContentLabelCollectionViewCell *labelCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    
    labelCollectionViewCell.layer.cornerRadius = 8;
    
    labelCollectionViewCell.typeString = self.typeArray[indexPath.row];
    labelCollectionViewCell.buttonTag  = indexPath.row;
    
    switch (self.indexPath) {
        case 0:
            
            labelCollectionViewCell.tag = (self.indexPath + 100) + indexPath.row;
            
            break;
            
        case 1:
            
            labelCollectionViewCell.tag = (self.indexPath + 200) + indexPath.row;
            
            break;
            
        case 2:
            
            labelCollectionViewCell.tag = (self.indexPath + 300) + indexPath.row;
            
            break;
            
        default:
            break;
    }
    
    if (indexPath.row == 0) {
        
        labelCollectionViewCell.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0x327acc);
        
    } else {
        
        labelCollectionViewCell.backgroundColor = [UIColor clearColor];
    }
    
    return labelCollectionViewCell;
}

#pragma mark - UICollectionView Delegate Method
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZzdecoScreenContentLabelCollectionViewCell *collectionViewCell = (ZzdecoScreenContentLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    collectionViewCell.backgroundColor = CAL_COLOR_FROM_HEX_CODE(0x327acc);
    
    NSLog(@"Item Tag: %zd, Set Tag: %zd", collectionViewCell.tag, self.indexPath);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%zd", collectionViewCell.tag]
                                              forKey:SELECT_ITEM_AT_INDEX];

    self.currentItem = collectionViewCell;
    
    if (indexPath.row != 0) {
        collectionViewCell = (ZzdecoScreenContentLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [collectionViewCell setBackgroundColor:[UIColor clearColor]];
    }
    
    if (self.zzdecoScreenContentCellBlock) {
        self.zzdecoScreenContentCellBlock(self.indexPath, indexPath.row);
    }
    
    if (self.didSelectedItemAction) return self.didSelectedItemAction();
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
        
    ZzdecoScreenContentLabelCollectionViewCell *collectionViewCell = (ZzdecoScreenContentLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [collectionViewCell setBackgroundColor:[UIColor clearColor]];
}

- (void)cancelCurrentItem {
    
    [self.currentItem setBackgroundColor:[UIColor clearColor]];
}

- (void)firstItemSelected:(BOOL)selected {

    ZzdecoScreenContentLabelCollectionViewCell *firstCell = (ZzdecoScreenContentLabelCollectionViewCell *)[self.labelCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (selected) {
        
        [firstCell setBackgroundColor:CAL_COLOR_FROM_HEX_CODE(0x327acc)];
        
    } else {
        
        [firstCell setBackgroundColor:[UIColor clearColor]];
    }
}

#pragma mark - Set Collection View
- (UICollectionView *)labelCollectionView {
    
    CAL_GET_METHOD_RETURN_OBJC(_labelCollectionView);
    
    _labelCollectionView                 = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    _labelCollectionView.backgroundColor = [UIColor clearColor];
    _labelCollectionView.delegate        = self;
    _labelCollectionView.dataSource      = self;
    _labelCollectionView.scrollEnabled   = NO;
    
    _labelCollectionView.showsVerticalScrollIndicator   = NO;
    _labelCollectionView.showsHorizontalScrollIndicator = NO;
    
    return _labelCollectionView;
}

#pragma mark - Set Collection Flow Layout
- (UICollectionViewFlowLayout *)flowLayout {
    
    CAL_GET_METHOD_RETURN_OBJC(_flowLayout);
    
    _flowLayout                 = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return _flowLayout;
}

#pragma mark - Collection Flow Layout Delegate Mothed
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize buttonSize = [(NSString*)[self.typeArray objectAtIndex:indexPath.row] sizeWithAttributes:NULL];
    
    buttonSize.width += CAL_WIDTH_TO_FIT(56);
    buttonSize.height += CAL_WIDTH_TO_FIT(36);
    
    return buttonSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5.0f;
}

@end
