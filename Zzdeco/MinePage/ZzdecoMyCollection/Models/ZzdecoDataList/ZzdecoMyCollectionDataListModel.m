//
//  ZzdecoDataList.m
//  Zzdeco
//
//  Created by Cain on 2/7/16.
//  Copyright © 2016年 zzdeco. All rights reserved.
//

#import "ZzdecoMyCollectionDataListModel.h"

@implementation ZzdecoMyCollectionDataListModel

- (void)setAcprojectPicture:(NSString *)acprojectPicture {
    
    _acprojectPicture = [NSString stringWithFormat:@"http://file.zzdeco.com/file/view/%@.jpg", acprojectPicture];
}

@end
