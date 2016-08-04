//
//  ZzdecoProtocolViewController.m
//  Zzdeco
//
//  Created by Cain on 5/5/16.
//  Copyright © 2016 zzdeco. All rights reserved.
//

#import "ZzdecoProtocolViewController.h"

@interface ZzdecoProtocolViewController ()

@property (weak, nonatomic) IBOutlet UIButton   *disagreeButton;
@property (weak, nonatomic) IBOutlet UITextView *protocolTextView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) FXBlurView *blurView;

@property (nonatomic, strong) CALBaseControllerTitleView *titleView;

@end

@implementation ZzdecoProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLoginButton];
    [self setTitleViewButtonActionBlock];
    
    [self setProtocolTextView];
    
    [self.view addSubview:self.titleView];
    [self addConstraints];
    
    [self.backgroundImageView addSubview:self.blurView];
    [self.backgroundImageView setImageWithURL:BACKGROUND_IMAGE_URL];
}

#pragma mark - Set Title View
- (void)addConstraints {
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        (void)make.left.top.right;
        make.width.mas_equalTo(CAL_SCREEN_WIDTH);
        make.height.mas_equalTo(64);
    }];
}

- (CALBaseControllerTitleView *)titleView {
    
    CAL_GET_METHOD_RETURN_OBJC(_titleView);
    
    _titleView                = [CALBaseControllerTitleView new];
    _titleView.titleViewTitle = @"登录注册";
    
    _titleView.leftButtonImage            = [UIImage imageNamed:@"button-return"];
    _titleView.leftButtonHighlightedImage = [UIImage imageNamed:@"button-return-click"];
    
    return _titleView;
}

- (void)setLoginButton {
    
    self.disagreeButton.layer.masksToBounds = YES;
    self.disagreeButton.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;

    self.protocolTextView.layer.masksToBounds = YES;
    self.protocolTextView.layer.borderColor   = CAL_COLOR_FROM_HEX_CODE(0xAAAAAA).CGColor;
}

#pragma mark -  Set Left Block
- (void)setTitleViewButtonActionBlock {
    
    CAL_WEAK_SELF(ws);
    
    [self.titleView setCalControllerTitleViewLeftBlock:^(UIButton *leftButton) {
        
        [ws dismissViewControllerAnimated:YES completion:nil];
    }];
}

#pragma mark - Button Action
- (IBAction)disagreeButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginPopToRootViewController" object:nil];
}

- (IBAction)agreeButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Set Protocol Text View Content
- (void)setProtocolTextView {
    
    [self.protocolTextView setAttributedText:[[self class] attributedStringWithString:self.protocolTextView.text]];
    [self.protocolTextView setTextColor:[UIColor whiteColor]];
}

#pragma mark - Return Text View Attributed String
+ (NSAttributedString *)attributedStringWithString:(NSString *)string {
    
    NSRange range    = [string rangeOfString:@"遇道装修"];
    NSRange protocol = [string rangeOfString:@"本协议最终解释权归深圳中征装饰科技有限公司所有。"];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple  = 50.f;
    paragraphStyle.maximumLineHeight   = 25.f;
    paragraphStyle.minimumLineHeight   = 25.f;
    paragraphStyle.alignment           = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle,};

    NSDictionary *protocolAttributes = @{NSParagraphStyleAttributeName:paragraphStyle,};

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineSpacing              = 3;

    
    NSMutableAttributedString *touchString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [touchString addAttribute:NSParagraphStyleAttributeName value:paragraph range:[string rangeOfString:string]];
    [touchString addAttributes:attributes range:range];
    [touchString addAttributes:protocolAttributes range:protocol];

    return touchString;
}

#pragma mark - Set blur View
- (FXBlurView *)blurView {
    
    CAL_GET_METHOD_RETURN_OBJC(_blurView);
    
    _blurView = [[FXBlurView alloc] init];
    
    _blurView.frame      = self.backgroundImageView.frame;
    _blurView.dynamic    = YES;
    _blurView.tintColor  = [UIColor blackColor];
    _blurView.blurRadius = 10.f;
    
    return _blurView;
}

@end
