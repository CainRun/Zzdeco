//
//  ZzdecoMyCollectionViewController.h
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"

@interface ZzdecoMyCollectionViewController : CALBaseViewController

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (weak, nonatomic, readonly) IBOutlet UICollectionView *CALMyCollectionCollectionView;

@end
