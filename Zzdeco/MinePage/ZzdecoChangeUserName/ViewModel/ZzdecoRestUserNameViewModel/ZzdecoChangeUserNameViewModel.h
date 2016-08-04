//
//  ZzdecoRestUserNameViewModel.h
//  Zzdeco
//
//  Created by Cain on 18/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoChangeUserNameViewModel : NSObject

- (instancetype)initRestUserNameViewModelWithController:(UIViewController *)controller;

- (void)restUserNameRequest:(NSString *)userName;

@end
