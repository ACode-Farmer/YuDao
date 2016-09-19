//
//  APCell.m
//  YuDao
//
//  Created by 汪杰 on 16/9/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "APCell.h"
#import "APModel.h"

@implementation APCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
    }
    return self;
}

- (void)setModel:(APModel *)model{
    _model = model;
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.subTitle;
    
    switch (model.type) {
        case CellTypeSubTitle:
            self.accessoryType = 0;
            break;
        case CellTypeSwitch:
        {
            UISwitch *swit = [UISwitch new];
            [swit addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            swit.on = [[NSUserDefaults standardUserDefaults] boolForKey:model.title];
            self.accessoryView = swit;
            break;}
        case CellTypeArrow:
            self.accessoryType = 1;
            break;
        case CellTypeCheckmark:
            self.accessoryType = 3;
            break;
        default:
            break;
    }
}

- (void)switchAction:(UISwitch *)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:sender.isOn forKey:self.model.title];
    [defaults synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
