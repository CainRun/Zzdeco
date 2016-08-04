//
//  ZzdecoCollectionPreviewViewModel.h
//  Zzdeco
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoCollectionPreviewViewModel : NSObject

- (instancetype)initCollectionPreviewViewModelWithController:(UIViewController *)controller;

- (void)collectionCaseInfoRequest:(NSString *)caseID;

@end
