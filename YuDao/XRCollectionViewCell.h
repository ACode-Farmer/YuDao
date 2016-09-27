//
//  XRCollectionViewCell.h
//
//  Created by 肖睿 on 16/3/29.
//  Copyright © 2016年 XR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) NSURL *imageURL;

@end
