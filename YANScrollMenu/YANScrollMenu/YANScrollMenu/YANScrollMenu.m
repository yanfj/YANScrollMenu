//
//  YANScrollMenu.m
//  YANScrollMenu
//
//  Created by Yan. on 2017/6/28.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import "YANScrollMenu.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

/**********************  YANMenuItem ***************************/
@interface YANMenuItem ()
/**
 *  The icon.
 */
@property (nonatomic, strong) UIImageView *icon;
/**
 *  The label.
 */
@property (nonatomic, strong) UILabel *label;
/**
 *  The edge of item.
 */
@property (nonatomic, assign) YANEdgeInsets edgeInsets; //default is {5,0,5,0,5}

@end

@implementation YANMenuItem
#pragma mark - Life Cycle
+ (void)initialize{
    
    YANMenuItem *item = [self appearance];
    item.iconSize = kScale(40);
    item.iconCornerRadius = kScale(20);
    item.textColor = [UIColor darkTextColor];
    item.textFont = [UIFont systemFontOfSize:kScale(14)];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    
    return self;
    
}
#pragma mark - Getter&Setter
- (void)setIconSize:(CGFloat)iconSize{
    
    if (iconSize >= 0) {
        
        _iconSize = iconSize;
        
        [self updateIconConstraints];
    }
    
}
- (void)setIconCornerRadius:(CGFloat)iconCornerRadius{
    
    if (iconCornerRadius >= 0) {
        
        _iconCornerRadius = iconCornerRadius;
        
        self.icon.layer.cornerRadius = iconCornerRadius;
    }
}
- (void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    
    self.label.textColor = textColor;
    
}
- (void)setTextFont:(UIFont *)textFont{
    
    _textFont = textFont;
    
    self.label.font = textFont;
    
}
- (void)setEdgeInsets:(YANEdgeInsets)edgeInsets{
    
    _edgeInsets = edgeInsets;
    
    [self updateItemEdgeInsets];
    
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.icon = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = self.iconCornerRadius;
        imageView;
    });
    
    self.label = ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = self.textColor;
        label.font = self.textFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    });
    
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.label];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //The constraint of icon.
    [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.edgeInsets.top);
        make.centerX.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(self.iconSize);
    }];

    //The constraint of label.
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(self.edgeInsets.middle);
        make.left.mas_equalTo(self.edgeInsets.left);
        make.right.mas_equalTo(- self.edgeInsets.right);
        make.bottom.mas_equalTo(- self.edgeInsets.bottom);
    }];
    
}
- (void)updateIconConstraints{
    
    if (self.icon) {
                
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(self.iconSize);
        }];
    }
    
}
- (void)updateItemEdgeInsets{
    
    if (self.icon && self.label) {
        
        [self.icon mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.edgeInsets.top);
        }];
        
        [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.icon.mas_bottom).offset(self.edgeInsets.middle);
            make.left.mas_equalTo(self.edgeInsets.left);
            make.right.mas_equalTo(- self.edgeInsets.right);
            make.bottom.mas_equalTo(- self.edgeInsets.bottom);
        }];
    }
}
#pragma mark - Customize
- (void)customizeItemWithObject:(id<YANMenuObject>)object{
    
    if (object == nil) return;
    
    self.label.text = object.text;
    
    if ([object.image isKindOfClass:[NSString class]]) {
        
        NSURL *url = [NSURL URLWithString:(NSString *)object.image];
        [self.icon sd_setImageWithURL:url placeholderImage:object.placeholderImage];
        
    }else if ([object.image isKindOfClass:[NSURL class]]){
        
        [self.icon sd_setImageWithURL:(NSURL *)object.image placeholderImage:object.placeholderImage];
        
    }else if ([object.image isKindOfClass:[UIImage class]]){
        
        self.icon.image = (UIImage *)object.image;
    }
}
#pragma mark - Identifier
+ (NSString *)identifier{
    
    return NSStringFromClass([self class]);
    
}
@end


/**********************  YANMenuSectionProtocol ***************************/
@class YANMenuSection;

@protocol YANMenuSectionProtocol <NSObject>
/**
 Size of items.

 @param menuSection YANMenuSection
 @return CGSize
 */
- (CGSize)sizeOfItemsInMenuSection:(YANMenuSection *)menuSection;
/**
 Number of items.

 @param menuSection YANMenuSection
 @return NSUInteger
 */
- (NSUInteger)numberOfItemsInMenuSection:(YANMenuSection *)menuSection;
/**
 Object at indexPath.

 @param menuSection YANMenuSection
 @param indexPath NSIndexPath
 @return id<YANMenuObject>
 */
- (id<YANMenuObject>)menuSection:(YANMenuSection *)menuSection objectAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 EdgeInsets of item.

 @param menuSection YANMenuSection
 @return YANEdgeInsets
 */
- (YANEdgeInsets)edgeInsetsOfItemMenuSection:(YANMenuSection *)menuSection;
/**
 Did select item at indexPath.

 @param menuSection YANMenuSection
 @param indexPath NSIndexPath
 */
- (void)menuSection:(YANMenuSection *)menuSection didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end

/**********************  YANMenuSection ***************************/
NS_CLASS_AVAILABLE_IOS(8_0) @interface YANMenuSection : UICollectionViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  The collectionView.
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  The delegate.
 */
@property (nonatomic, weak) id<YANMenuSectionProtocol> delegate;
/**
 *  The section.
 */
@property (nonatomic, assign) NSUInteger section;

@end

@implementation YANMenuSection
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
        
    }
    return self;
}
#pragma mark - Getter&Setter
- (void)setDelegate:(id<YANMenuSectionProtocol>)delegate{
    
    _delegate = delegate;
    
    if (self.collectionView) {
        [self.collectionView reloadData];
    }
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    
    self.collectionView = ({
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        
        [collectionView registerClass:[YANMenuItem class] forCellWithReuseIdentifier:[YANMenuItem identifier]];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView;
    
    });
    
    [self.contentView addSubview:self.collectionView];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark - Identifier
+ (NSString *)identifier{
    
    return NSStringFromClass([self class]);
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(sizeOfItemsInMenuSection:)]) {
        
        return [self.delegate sizeOfItemsInMenuSection:self];
    }
    
    return CGSizeZero;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemsInMenuSection:)]) {
        
        return [self.delegate numberOfItemsInMenuSection:self];
    }
    
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
 
    YANMenuItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:[YANMenuItem identifier] forIndexPath:indexPath];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsOfItemMenuSection:)]) {
        item.edgeInsets = [self.delegate edgeInsetsOfItemMenuSection:self];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuSection:objectAtIndexPath:)]) {
        
        id<YANMenuObject> object = [self.delegate menuSection:self objectAtIndexPath:indexPath];
        [item customizeItemWithObject:object];
    }
    
    return item;
    
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(menuSection:didSelectItemAtIndexPath:)]) {
        
        [self.delegate menuSection:self didSelectItemAtIndexPath:indexPath];
    }
}

@end

/**********************  YANScrollMenu ***************************/
@interface YANScrollMenu ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YANMenuSectionProtocol>
/**
 *  The collectionView.
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/**
 *  The pageControl.
 */
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YANScrollMenu
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self prepareUI];
    }
    return self;
}
#pragma mark - Getter&Setter
- (void)setDelegate:(id<YANScrollMenuProtocol>)delegate{
    
    _delegate = delegate;
    
    if (self.collectionView) {
        
        [self.collectionView reloadData];
    }
    
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor{
    
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    
    if (self.pageControl) {
        
        self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    }
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor{
    
    _pageIndicatorTintColor = pageIndicatorTintColor;
    
    if (self.pageIndicatorTintColor) {
        
        self.pageIndicatorTintColor = pageIndicatorTintColor;
    }
}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.collectionView = ({
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        
        [collectionView registerClass:[YANMenuSection class] forCellWithReuseIdentifier:[YANMenuSection identifier]];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"log"];
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView;
        
    });
    
    self.pageControl = ({
        UIPageControl * pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        pageControl.currentPageIndicatorTintColor = [UIColor darkTextColor];
        pageControl.pageIndicatorTintColor =  [UIColor groupTableViewBackgroundColor];
        [pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
        pageControl;
    });
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.pageControl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(kPageControlHeight);
    }];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.pageControl.mas_top);
    }];
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
        
        NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
        
        CGFloat height = (CGRectGetHeight(self.frame) - kPageControlHeight)/rows;
        
        return CGSizeMake(CGRectGetWidth(self.frame), height);
        
    }
    return CGSizeZero;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemsForEachRowInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfMenusInScrollMenu:)]) {
        
        NSUInteger total = [self.delegate numberOfMenusInScrollMenu:self];
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        CGFloat rows = (CGFloat)total * 1.f /items;
        
        if ([self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
            
            NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
            
            NSUInteger numberOfPages = ceil(total*1.f/(rows * items));
            
            self.pageControl.numberOfPages = numberOfPages;
            self.pageControl.hidden = numberOfPages < 2;
            
        }
        
        return ceil(rows);
    }
    
    return 0;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    YANMenuSection *section = [collectionView dequeueReusableCellWithReuseIdentifier:[YANMenuSection identifier] forIndexPath:indexPath];
    section.section = indexPath.row;
    section.delegate = self;
    return section;
}
#pragma mark - YANMenuSectionProtocol
- (CGSize)sizeOfItemsInMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfItemsForEachRowInScrollMenu:)]) {
        
        NSUInteger rows = [self.delegate numberOfRowsForEachPageInScrollMenu:self];
        
        CGFloat height = (CGRectGetHeight(self.frame) - kPageControlHeight)/rows;
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        CGFloat width =  CGRectGetWidth(self.frame)/items;
        
        return CGSizeMake(width, height);
        
    }
    
    return CGSizeZero;
    
}
- (NSUInteger)numberOfItemsInMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfMenusInScrollMenu:)] && [self.delegate respondsToSelector:@selector(numberOfRowsForEachPageInScrollMenu:)]) {
        
        NSUInteger total = [self.delegate numberOfMenusInScrollMenu:self];
        
        NSUInteger items = [self.delegate numberOfItemsForEachRowInScrollMenu:self];
        
        NSUInteger number = total - items * menuSection.section;
    
        
        return MIN(number, items);
      
    }
    
    return 0;
}
- (id<YANMenuObject>)menuSection:(YANMenuSection *)menuSection objectAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenu:objectAtIndexPath:)]) {
        
        NSIndexPath *idx = [NSIndexPath indexPathForRow:indexPath.row inSection:menuSection.section];
        
        return [self.delegate scrollMenu:self objectAtIndexPath:idx];
    }
    
    return nil;
}
- (void)menuSection:(YANMenuSection *)menuSection didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenu:didSelectItemAtIndexPath:)]) {
        
        NSIndexPath *idx = [NSIndexPath indexPathForRow:indexPath.row inSection:menuSection.section];
        
        [self.delegate scrollMenu:self didSelectItemAtIndexPath:idx];
    }
    
}
- (YANEdgeInsets)edgeInsetsOfItemMenuSection:(YANMenuSection *)menuSection{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(edgeInsetsOfItemInScrollMenu:)]) {
        
        return [self.delegate edgeInsetsOfItemInScrollMenu:self];
    }
    
    return YANEdgeInsetsMake(kScale(5), 0, kScale(5), 0, kScale(5));
}
#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [self.pageControl setCurrentPage:offset.x / bounds.size.width];
}
#pragma mark - PageCotrolTurn
- (void)pageTurn:(UIPageControl*)sender{
    
    CGSize viewSize = self.collectionView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.collectionView scrollRectToVisible:rect animated:YES];
    
}
#pragma mark - Public
- (void)reloadData{
    
    if (self.collectionView) {
        
        [self.collectionView reloadData];
        
    }
}



@end
