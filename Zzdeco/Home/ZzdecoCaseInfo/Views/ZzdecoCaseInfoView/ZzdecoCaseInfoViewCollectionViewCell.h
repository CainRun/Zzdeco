//
//  ZzdecoCaseInfoViewCollectionViewCell.h
//  Zzdeco
//
//  Created by Cain on 5/9/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZzdecoCaseInfoViewCollectionViewCell : UIView

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, strong) NSArray *infoArray;

@property (nonatomic, strong, readonly) UITableView *infoTableView;

@end
