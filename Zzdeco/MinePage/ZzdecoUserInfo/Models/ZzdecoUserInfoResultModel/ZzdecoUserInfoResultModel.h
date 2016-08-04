//
//  ZzdecoUserInfoResultModel.h
//  Zzdeco
//
//  Created by Cain on 21/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoUserInfoResultModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *authPhoto;
@property (nonatomic, copy) NSString *memberNo;

@property (nonatomic, assign) NSInteger userId;

@end
