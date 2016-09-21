//
//  AdviseController.m
//  YuDao
//
//  Created by 汪杰 on 16/9/21.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "AdviseController.h"

@interface AdviseController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (strong, nonatomic) UILabel *phLabel;

@end

@implementation AdviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    
    self.textView.layer.borderWidth = 1.f;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.delegate = self;
    [self.textView addSubview:self.phLabel];
    
    self.commitBtn.layer.cornerRadius = 5.f;
    [self.commitBtn addTarget:self action:@selector(commitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (UILabel *)phLabel{
    if (!_phLabel) {
        _phLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 300, 21)];
        _phLabel.text = @"你可以在这里输入对我们的建议...";
    }
    return _phLabel;
}

- (void)commitBtnAction:(UIButton *)sender{
    [self.textView resignFirstResponder];
}

#pragma mark - textView delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.phLabel.hidden = YES;//开始编辑时
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    //将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        self.phLabel.hidden = NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
