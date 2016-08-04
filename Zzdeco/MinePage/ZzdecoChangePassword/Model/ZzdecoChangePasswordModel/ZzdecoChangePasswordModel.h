//
//  ZzdecoChangePasswordModel.h
//  Zzdeco
//
//  Created by Cain on 18/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoChangePasswordModel : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) NSInteger result;
@property (nonatomic, assign) NSInteger dateline;

@property (nonatomic, copy) NSString *message;

@end
