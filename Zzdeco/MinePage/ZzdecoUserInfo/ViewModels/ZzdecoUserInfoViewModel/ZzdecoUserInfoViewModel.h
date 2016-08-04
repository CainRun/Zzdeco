//
//  ZzdecoViewModel.h
//  Zzdeco
//
//  Created by Cain on 14/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoUserInfoViewModel : NSObject

- (instancetype)initViewModelWithController:(UIViewController *)controller;

- (void)loginOutRequest:(NSInteger)loginOutTag;
- (void)getPasswordState;
- (void)getUserInfo;
- (void)uploadHeder:(UIImage *)parameters;

@end
