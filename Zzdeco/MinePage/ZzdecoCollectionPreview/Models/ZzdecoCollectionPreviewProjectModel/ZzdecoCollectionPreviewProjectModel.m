//
//  ZzdecoCollectionPreviewProjectModel.m
//  Zzdeco
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoCollectionPreviewProjectModel.h"

@implementation ZzdecoCollectionPreviewProjectModel

- (void)setCoverImg:(NSString *)coverImg {
    
    CGFloat width  = CAL_SCREEN_WIDTH;
    CGFloat height = CAL_SCREEN_HEIGHT;
    
    _coverImg = [NSString stringWithFormat:@"http://file.zzdeco.com/file/view/%@.jpg?size=%.f*%.f", coverImg, height * 2, width * 2];
}

@end
