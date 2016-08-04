//
//  ZzdecoCollectionPreviewViewController.h
//  Zzdeco
//
//  Created by Cain on 5/11/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "CALBaseViewController.h"
#import "ZzdecoCaseInfoView.h"

@interface ZzdecoCollectionPreviewController : CALBaseViewController

@property (nonatomic, copy) NSString *caseID;

@property (nonatomic, strong, readonly) ZzdecoCaseInfoView *infoView;

@end
