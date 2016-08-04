//
//  ZzdecoCaseCollection.h
//  Zzdeco
//
//  Created by Cain on 23/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCaseCollectionModel : NSObject

@property (nonatomic, assign) NSInteger dateline;
@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *result;

@end
