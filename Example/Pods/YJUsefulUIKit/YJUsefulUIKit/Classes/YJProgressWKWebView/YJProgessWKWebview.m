//
//  YJProgessWKWebview.m
//
//  Created by 杨玉京 on 2020/6/22.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "YJProgessWKWebview.h"
#import "Masonry.h"

@interface YJProgessWKWebview()

@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation YJProgessWKWebview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpProgessView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    self = [super initWithFrame:frame configuration:configuration];
    if (self) {
        [self setUpProgessView];
    }
    return self;
}
#pragma mark 进度条
- (void)setUpProgessView{
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self addSubview:self.progressView];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self);
        make.height.equalTo(@2);
        make.top.mas_equalTo(self.mas_top);
    }];
}
- (void)setTrackTintColor:(UIColor *)trackTintColor {
    _trackTintColor = trackTintColor;
    self.progressView.trackTintColor = trackTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor {
    _progressTintColor = progressTintColor;
    self.progressView.progressTintColor = progressTintColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
    }];
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.estimatedProgress > self.progressView.progress;
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];

        if(newprogress >= 1.0f) {
            // 首先加载到头
            [self.progressView setProgress:newprogress animated:YES];
            // 之后0.3秒延迟隐藏
            __weak typeof(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                weakSelf.progressView.hidden = YES;
                [weakSelf.progressView setProgress:0 animated:NO];
            });
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:animated];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    // 最后一步：移除监听
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark 懒加载
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, self.bounds.size.width, 2);
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}
@end
