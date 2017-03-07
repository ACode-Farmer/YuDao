//
//  YDLoginInputView.m
//  YuDao
//
//  Created by 汪杰 on 16/11/15.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDLoginInputView.h"

@implementation YDLoginInputView

- (id)init{
    if (self = [super init]) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_input_backIcon"]];
        [self addSubview:imageV];
        imageV.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        [self sd_addSubviews:@[self.labelButton,self.label,self.textF,self.variableBtn]];
        [self y_layoutSubviews];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(labelTextFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.textF];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.label.text = [dataDic valueForKey:@"label"];
    if ([self.label.text isEqualToString:@"密码"]) {
        self.variableBtn.hidden = NO;
    }
    NSLog(@"self.label.font = %@",self.label.font);
}

- (void)y_layoutSubviews{
    self.label.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self,10)
    .heightIs(21);
    [self.label setSingleLineAutoResizeWithMaxWidth:60];
    
    self.textF.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self.label,15)
    .rightSpaceToView(self,0)
    .heightRatioToView(self,1);
    
    self.variableBtn.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self,kWidth(10))
    .heightIs(30)
    .widthIs(kWidth(150));
    
}

//MARK:监听标签栏的字数
- (void)labelTextFiledEditChanged:(NSNotification *)obj
{
    NSInteger length = 0;
    if ([self.label.text isEqualToString:@"帐号"]) {
        length = 11;
    }else{
        length = 4;
    }
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if (toBeString.length == length) {
        [textField resignFirstResponder];
    }
    if ([lang isEqualToString:@"zh-Hans"]){// 简体中文输入
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position){
            if (toBeString.length > length)
            {
                textField.text = [toBeString substringToIndex:length];
            }
        }
    }
    else{// 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > length){
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:length];
            if (rangeIndex.length == 1){
                textField.text = [toBeString substringToIndex:length];
            }else{
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, length)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
            
        }
    }
}

//MARK:Getters
- (UIButton *)labelButton{
    if (!_labelButton) {
        
        _labelButton = [YDUIKit buttonWithImage:[UIImage imageNamed:@""]   target:self];
    }
    return _labelButton;
}
- (UILabel *)label{
    if (!_label) {
        _label = [YDUIKit labelTextColor:[UIColor whiteColor] fontSize:kFontSize(17)];
        
    }
    return _label;
}

- (UITextField *)textF{
    if (!_textF) {
        _textF = [UITextField new];
        _textF.keyboardType = UIKeyboardTypePhonePad;
        _textF.delegate = self;
        [_textF setFont:kFont(16)];
    }
    return _textF;
}

- (UIButton *)variableBtn{
    if (!_variableBtn) {
        _variableBtn = [UIButton new];
        [_variableBtn.titleLabel setFont:kFont(16)];
        [_variableBtn setTitle:@"获取动态密码" forState:0];
        [_variableBtn setTitleColor:[UIColor whiteColor] forState:0];
        [_variableBtn setTitleColor:[UIColor colorGrayBG] forState:UIControlStateHighlighted];
        _variableBtn.hidden = YES;
        [_variableBtn addTarget:self action:@selector(variableBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _variableBtn;
}

- (void)variableBtnAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginInputView:getPassword:)]) {
        [self.delegate loginInputView:self getPassword:self.variableBtn];
    }
    
}


@end
