//
//  BDSegmentItemView.m
//  BeiJingDailyInfomant_Example
//
//  Created by 杨玉京 on 2020/6/27.
//  Copyright © 2020 silverBullet. All rights reserved.
//

#import "BDSegmentItemView.h"

@implementation BDSegmentItemView

#pragma mark - life Cycle
- (instancetype)initWithFrame:(CGRect)frame  SegmentItems:(NSArray*)segmentItems {
    if (self = [super initWithFrame:frame]) {
        self.segmentModels = segmentItems;
        [self configUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

#pragma mark 布局UI
-(void)configUI{
    
    CGFloat width = self.width/ _segmentModels.count;//宽度
    CGFloat hight = self.height;
    
    WEAKSELF;
    
    [_segmentModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton * btn = [UIButton addCustomButtonTitle:obj font:PFRFont(13) backgroundColor:GM_Clear_Color titleColor:HEXCOLOR(0x333333) tapAction:^(UIButton *button) {
            
            [weakSelf btnClickAtIndex:button.tag];
        }];
        [btn setTitleColor:HEXCOLOR(0xEE3228) forState:UIControlStateSelected];
        [self addSubview:btn];
        btn.frame = CGRectMake(idx*width, 0, width, hight);
        [self.btns addObject:btn];
        self.lastBtn = idx==0? btn:self.lastBtn;
        self.lastBtn.selected = YES;
        btn.tag = 1000+idx;
        self.changeIndex = idx==0? 0:self.changeIndex;
    }];
    
    //下划线
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake((_lastBtn.width- 39*kWidthRatio)/2, hight-1.0, 39*kWidthRatio, 1.0)];
    _indicatorView.backgroundColor = HEXCOLOR(0xEE3228);
    [self addSubview:_indicatorView];
}

-(void)setChangeIndex:(NSInteger)changeIndex{
    _changeIndex = changeIndex;
    [self btnClickAtIndex:1000+changeIndex];
}

#pragma mark 按钮点击
-(void)btnClickAtIndex:(NSInteger)tag{
    
    _lastBtn .selected = !_lastBtn.selected;
    _lastBtn = [_btns objectAtIndex:tag-1000];
    _lastBtn.selected = !_lastBtn.selected;
    
    [UIView animateWithDuration:(0.3) animations:^{
        self->_indicatorView.left = self->_lastBtn.left+(self->_lastBtn.width-39*kWidthRatio)/2;
    }];
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(segmentBar:tapIndex:)]) {
        [self.delegate segmentBar:self tapIndex:tag-1000];
    }
}

@end
