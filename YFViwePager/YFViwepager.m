//
//  YFViwepager.m
//  YFViwePager
//
//  Created by HO on 16/4/4.
//  Copyright © 2016年 HO. All rights reserved.
//

#import "YFViwepager.h"
#import <UIImageView+WebCache.h>

@interface YFViwepager ()<UIScrollViewDelegate>{
    CGRect _scrollViewRect;
    CGSize _contentSize;
}

/** 页面器*/
@property (weak, nonatomic) UIPageControl *pageControl;

/** 计时器*/
@property (nonatomic, weak) NSTimer *timer;

/** 点击手势 记录tag*/
@property (nonatomic,assign) NSInteger  flag;

@end


@implementation YFViwepager

+ (instancetype)viwepagerWithFrame:(CGRect)frame{
    
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self.flag = 100;//设置初始值
    
    if (self = [super initWithFrame:frame]) {
        self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.2 blue:0.9 alpha:0.7];
        self.userInteractionEnabled = YES;
        
        UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:frame];
        scrollV.delegate = self;
        scrollV.pagingEnabled = YES;
        self.scrollView = scrollV;
        [self addSubview:scrollV];
        
        UIPageControl *pageC = [[UIPageControl alloc] init];
        pageC.center = CGPointMake(frame.size.width/2, frame.size.height-30);
        self.pageControl = pageC;
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)setImageNames:(NSArray *)imageNames
{
    _imageNames = imageNames;
    
    NSInteger imageCount = [imageNames count];
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    self.scrollView.contentSize = CGSizeMake(width*(imageCount+2), height);
    _contentSize = CGSizeMake(width*(imageCount+2), height);
    
    NSInteger x = 0;
    
    
    for (UIImageView *imageV in self.scrollView.subviews) {
        [imageV removeFromSuperview];
    }
    
    // 在第一个前边加上最后一个的图片
    UIImageView *firstView = [[UIImageView alloc] initWithFrame:CGRectMake(x*width, 0, width, height)];
    [firstView sd_setImageWithURL:[NSURL URLWithString:[imageNames lastObject]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];
    [self.scrollView addSubview:firstView];
    ++x;
    
    // 设置scrollView偏移到第二张图片， 也就是真正的第一张图片
    self.scrollView.contentOffset = CGPointMake(x*width, 0);
    
    // 正常添加中间图片
    for (NSString *imageName in imageNames) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x*width, 0, width, height)];
        
        if (self.imageType == YES) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];
        }else{
            imageView.image = [UIImage imageNamed:imageName];
        }
        
        //当是本地图片时不能点击
        imageView.userInteractionEnabled = self.imageType;
        
        //添加点击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapClick:)];
        [imageView addGestureRecognizer:tap];
        UIView *singleTapView = [tap view];
        singleTapView.tag = self.flag;
        self.flag ++;
        
        [self.scrollView addSubview:imageView];
        
        ++x;
    }
    // 在最后一个后边加上第一个图片
    UIImageView *lastView = [[UIImageView alloc] initWithFrame:CGRectMake(x*width, 0, width, height)];
    
    if (self.imageType == YES) {
        [lastView sd_setImageWithURL:[NSURL URLWithString:[imageNames firstObject]] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageCacheMemoryOnly];
    }else{
        lastView.image = [UIImage imageNamed:[imageNames firstObject]];
    }
    
    [self.scrollView addSubview:lastView];
    
    self.pageControl.numberOfPages = imageNames.count;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = self.color;
    
    //启动计时器，图片自动滚动
    [self startTimer];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTimer
{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoScoll) userInfo:nil repeats:YES];
    }
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 自动滚动
- (void)autoScoll
{
    NSInteger currentPage = self.pageControl.currentPage+1;
    
    ++currentPage;
    CGFloat pointX = currentPage * self.scrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.scrollView.contentOffset = CGPointMake(pointX, 0);
    } completion:^(BOOL finished) {
        if (currentPage > self.pageControl.numberOfPages) {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        }
    }];
}



#pragma mark -- UIScrollViewDelegate方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width*0.5) / scrollView.frame.size.width;
    if (page == (int)self.pageControl.numberOfPages+1) {
        page = 0;
    } else if (page == 0) {
        page = (int)self.pageControl.numberOfPages;
    } else {
        page = page - 1;
    }
    self.pageControl.currentPage = page;
}

// 手动划才能触发该方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width*0.5) / scrollView.frame.size.width;
    if (page == (int)self.pageControl.numberOfPages+1) {
        page = 0;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    } else if (page == 0) {
        page = (int)self.pageControl.numberOfPages;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width*page, 0);
    } else {
        page = page - 1;
    }
    self.pageControl.currentPage = page;
    [self startTimer];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}


#pragma mark - tap 点击事件
- (void)TapClick:(UITapGestureRecognizer *)tap{
    
    [self.delegate returnFlog:[tap view].tag];
}


@end
