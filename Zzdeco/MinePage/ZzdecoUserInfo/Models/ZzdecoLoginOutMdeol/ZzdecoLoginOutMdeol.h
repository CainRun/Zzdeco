//
//  ZzdecoLoginOutMdeol.h
//  Zzdeco
//
//  Created by Cain on 21/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoLoginOutMdeol : NSObject

@property (nonatomic, assign) NSInteger dateline;
@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *result;

@end
