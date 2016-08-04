//
//  ZzdecoDataListModel.h
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZzdecoDataListModel : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, copy) NSString *idIos;
@property (nonatomic, copy) NSString *projectName;
@property (nonatomic, copy) NSString *firstShow;
@property (nonatomic, copy) NSString *projectContent;

@end
