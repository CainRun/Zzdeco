//
//  ZzdecoCaseInfoCollectionViewController.h
//  Zzdeco
//
//  Created by Cain on 5/16/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"

@interface ZzdecoCaseInfoCollectionViewController : CALBaseViewController

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
