//
//  ZzdecoUserInfoResultModel.m
//  Zzdeco
//
//  Created by Cain on 21/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoUserInfoResultModel.h"

@implementation ZzdecoUserInfoResultModel

- (void)setAuthPhoto:(NSString *)authPhoto {
    
    if (authPhoto) {
        
        _authPhoto = [NSString stringWithFormat:@"http://file.zzdeco.com/file/view/%@.jpg", authPhoto];
    }
}

@end
