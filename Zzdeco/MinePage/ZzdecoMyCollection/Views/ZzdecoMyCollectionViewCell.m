//
//  ZzdecoMyCollectionViewCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoMyCollectionViewCell.h"

@interface ZzdecoMyCollectionViewCell()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *calCasePicture;

@property (weak, nonatomic) IBOutlet UILabel     *calCaseName;
@property (weak, nonatomic) IBOutlet UIView      *calCaseBackgroundView;

@end

@implementation ZzdecoMyCollectionViewCell

- (void)setCaseName:(NSString *)caseName {
    
    self.calCaseName.text = caseName;
}

- (void)setCalCaseBackgroundView {

    self.calCaseBackgroundView.layer.masksToBounds = YES;
    self.calCaseBackgroundView.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;
}

@end
