//
//  YDDataTypeView.m
//  YuDao
//
//  Created by 汪杰 on 16/10/9.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDDataTypeView.h"
#import "CornerButton.h"

#define buttonWidthHeight 52 * widthHeight_ratio
#define margin 12 * widthHeight_ratio

@implementation YDDataTypeView
{
    NSArray *_titleArray;
    CornerButton *_selectedBtn;
}
- (instancetype)initWithTitleArray:(NSArray *)titleArray{
    if (self = [super init]) {
        
        _titleArray = [titleArray copy];
        for (NSString *s in _titleArray) {
            NSLog(@"s =- %@",s);
        }
        [self addButtons];
    }
    return self;
}

- (void)addButtons{
    NSMutableArray *btns = [NSMutableArray arrayWithCapacity:_titleArray.count];
    for (NSUInteger i = 0; i < _titleArray.count; i++) {
        NSString *title = _titleArray[i];
        CornerButton *btn = [CornerButton circularButtonWithTitle:title backgroundColor:[UIColor whiteColor]];
        btn.tag = 1000+i;
        if ([title isEqualToString:@"天气"]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"时速点击效果"] forState:0];
            _selectedBtn = btn;
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"时速未点击效果"] forState:0];
        }
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }
    
    CornerButton *weatherBtn = btns[0];
    CornerButton *speedBtn = btns[1];
    CornerButton *oilBtn = btns[2];
    CornerButton *mileageBtn = btns[3];
    CornerButton *testBtn = btns[4];
    
    oilBtn.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(buttonWidthHeight)
    .heightEqualToWidth();
    
    speedBtn.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(oilBtn,margin)
    .widthIs(buttonWidthHeight)
    .heightEqualToWidth();
    
    weatherBtn.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(speedBtn,margin)
    .widthIs(buttonWidthHeight)
    .heightEqualToWidth();
    
    mileageBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(oilBtn,margin)
    .widthIs(buttonWidthHeight)
    .heightEqualToWidth();
    
    testBtn.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(mileageBtn,margin)
    .widthIs(buttonWidthHeight)
    .heightEqualToWidth();
}

- (void)buttonAction:(CornerButton *)sender{
    if (sender == _selectedBtn) {
        return;
    }else{
        [_selectedBtn setBackgroundImage:[UIImage imageNamed:@"时速未点击效果"] forState:0];
        [sender setBackgroundImage:[UIImage imageNamed:@"时速点击效果"] forState:0];
        _selectedBtn = sender;
        if (self.buttonActionBlock) {
            self.buttonActionBlock(sender.tag - 1000);
        }
    }
}

@end
