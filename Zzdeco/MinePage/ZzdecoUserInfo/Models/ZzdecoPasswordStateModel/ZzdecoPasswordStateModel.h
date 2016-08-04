//
//  ZzdecoPasswordStateModel.h
//  Zzdeco
//
//  Created by Cain on 17/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoPasswordStateModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, assign) NSInteger result;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *dateline;

@end
