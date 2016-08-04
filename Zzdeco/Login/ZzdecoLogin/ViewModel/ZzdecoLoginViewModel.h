//
//  ZzdecoLoginViewModel.h
//  Zzdeco
//
//  Created by Cain on 27/5/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoLoginViewModel : NSObject

- (instancetype)initLoginViewModel:(UIViewController *)controller;

- (void)loginRequst:(NSDictionary *)parameters;

@end
