//
//  ZzdecoCaseDataListModel.m
//  Zzdeco
//
//  Created by Cain on 11/6/2016.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoCaseDataListModel.h"

@implementation ZzdecoCaseDataListModel

- (void)setFileName:(NSString *)fileName {
    
    CGFloat width = CAL_SCREEN_WIDTH;
    
    _fileName = [NSString stringWithFormat:@"http://file.zzdeco.com/file/view/%@.jpg?size=%.f*%.f", fileName, width * 2, width * 2];
}

@end
