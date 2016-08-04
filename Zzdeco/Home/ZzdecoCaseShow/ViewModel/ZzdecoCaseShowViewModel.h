//
//  ZzdecoCaseShowViewModel.h
//  Zzdeco
//
//  Created by Cain on 10/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCaseShowViewModel : NSObject

@property (nonatomic, copy) NSString *caseID;

- (instancetype)initCaseInfoViewModel:(UIViewController *)controller;

- (void)caseShowRequest;
- (void)collectionCase:(NSDictionary *)parameters;

@end
