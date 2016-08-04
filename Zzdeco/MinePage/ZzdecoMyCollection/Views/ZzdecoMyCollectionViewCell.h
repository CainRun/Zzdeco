//
//  ZzdecoMyCollectionViewCell.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoMyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic, readonly) IBOutlet UIImageView *calCasePicture;

@property (nonatomic, copy) NSString *caseName;

@property (nonatomic, assign) NSInteger cellID;

- (void)setCalCaseBackgroundView;

@end
