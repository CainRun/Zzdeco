//
//  ZzdecoCaseInfoViewModel.h
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCaseInfoViewModel : NSObject

- (instancetype)initCaseInfoViewModel:(UIViewController *)controller;

- (void)caseInfoRequest;

@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, strong) NSMutableDictionary *parameter;

@end
