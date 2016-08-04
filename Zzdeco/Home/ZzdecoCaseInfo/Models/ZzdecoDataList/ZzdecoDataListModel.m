//
//  ZzdecoDataListModel.m
//  Zzdeco
//
//  Created by Cain on 1/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoDataListModel.h"

@implementation ZzdecoDataListModel

- (void)setFirstShow:(NSString *)firstShow {

    _firstShow = [NSString stringWithFormat:@"http://file.zzdeco.com/file/view/%@.jpg", firstShow];
}

@end
