//
//  YDMoreKeyboard.m
//  YuDao
//
//  Created by 汪杰 on 16/10/19.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "YDMoreKeyboard.h"
#import "YDMoreKeyboard+CollectionView.h"

static YDMoreKeyboard *moreKB;
@implementation YDMoreKeyboard

+ (YDMoreKeyboard *)keyboard{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        moreKB = [YDMoreKeyboard new];
    });
    return moreKB;
}

- (id)init{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorGrayForChatBar]];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self y_addMasonry];
        
        [self registerCellClass];
    }
    return self;
}

- (CGFloat)keyboardHeight
{
    return HEIGHT_CHAT_KEYBOARD;
}

#pragma mark - Public Methods
- (void)setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData{
    _chatMoreKeyboardData = chatMoreKeyboardData;
    [self.collectionView reloadData];
    NSUInteger pageNumber = chatMoreKeyboardData.count / self.pageItemCount + (chatMoreKeyboardData.count % self.pageItemCount == 0 ? 0 : 1);
    [self.pageControl setNumberOfPages:pageNumber];
}

- (void)reset
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

#pragma mark - # Event Response
- (void)pageControlChanged:(UIPageControl *)pageControl
{
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.width * pageControl.currentPage, 0, self.collectionView.width, self.collectionView.height) animated:YES];
}

#pragma mark - Private Methods -
- (void)y_addMasonry
{
    self.collectionView.sd_layout
    .topSpaceToView(self,0)
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .bottomSpaceToView(self,25);

    self.pageControl.sd_layout
    .leftEqualToView(self.collectionView)
    .rightEqualToView(self.collectionView)
    .heightIs(20)
    .bottomSpaceToView(self,2);
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, screen_width, 0);
    CGContextStrokePath(context);
}
#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setScrollsToTop:NO];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setPageIndicatorTintColor:[UIColor colorGrayLine]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
