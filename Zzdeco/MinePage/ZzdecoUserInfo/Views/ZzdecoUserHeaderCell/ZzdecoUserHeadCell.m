//
//  ZzdecoUserHeadCell.m
//  Zzdeco
//
//  Created by Cain on 5/7/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoUserHeadCell.h"

@interface ZzdecoUserHeadCell()

@property (weak, nonatomic, readwrite) IBOutlet UIImageView *userHeaderImageView;

@end

@implementation ZzdecoUserHeadCell

- (void)setUserHead:(UIImage *)userHead {
    
    self.userHeaderImageView.image = userHead;    
}

@end
