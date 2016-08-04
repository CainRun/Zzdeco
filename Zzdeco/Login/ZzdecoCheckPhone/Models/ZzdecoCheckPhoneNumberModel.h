//
//  ZzdecoLoginModel.h
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCheckPhoneNumberModel : NSObject

@property (nonatomic, assign) NSInteger dateline;
@property (nonatomic, assign) NSInteger result;

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *message;

@end