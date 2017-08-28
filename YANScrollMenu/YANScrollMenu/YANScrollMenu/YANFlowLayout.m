//
//  YANFlowLayout.m
//  YANScrollMenu
//
//  Created by Yan. on 2017/8/28.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import "YANFlowLayout.h"

@interface YANFlowLayout ()
/**
 *  装载每个Section的Item数量的容器
 */
@property (nonatomic, strong) NSMutableDictionary *secitonDic;
/**
 *  装载每个Item的attributes的容器
 */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributesArray;

@end

@implementation YANFlowLayout
#pragma mark - Getter&Setter
- (NSMutableDictionary *)secitonDic{
    
    if (_secitonDic == nil) {
        _secitonDic = [NSMutableDictionary dictionary];
    }
    return _secitonDic;
}
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)attributesArray{
    
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}
#pragma mark - Override
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}
- (void)prepareLayout{
    
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //重置
    [self.secitonDic removeAllObjects];
    [self.attributesArray removeAllObjects];
    
    //获取section的总数
    NSUInteger section = [self.collectionView numberOfSections];
    
    for (int idx = 0; idx < section; idx++) {
        //获取每个section的cell个数
        NSUInteger count = [self.collectionView numberOfItemsInSection:idx];
        
        for (NSUInteger item = 0; item < count; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:idx];
            //重新排列
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [self.attributesArray addObject:attributes];
            
        }
    }
    
}
- (CGSize)collectionViewContentSize{
    
    //每个section的页码的总数
    NSInteger actualLo = 0;
    for (NSString *key in [self.secitonDic allKeys]) {
        actualLo += [self.secitonDic[key] integerValue];
    }
    
    //collectionView 的宽度
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    //collectionView 的高度
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    
    
    return CGSizeMake( actualLo*width , height);
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    [self updateLayoutAttributes:attr];
    
    return attr;
}
- (void)updateLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes{
    
    if(attributes.representedElementKind != nil){
        
        return;
    }
    
    //attributes 的宽度
    CGFloat itemW = CGRectGetWidth(attributes.frame);
    //attributes 的高度
    CGFloat itemH = CGRectGetHeight(attributes.frame);
    
    //collectionView 的宽度
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    //collectionView 的高度
    CGFloat height = CGRectGetHeight(self.collectionView.frame);
    //每个attributes的下标值 从0开始
    NSInteger itemIndex = attributes.indexPath.item;
    
    CGFloat stride = (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) ? width : height;
    
    
    //获取现在的attributes是第几组
    NSInteger section = attributes.indexPath.section;
    //获取每个section的item的个数
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
    
    
    CGFloat offset = section * stride;
    
    //计算x方向item个数
    NSInteger xCount = (width / itemW);
    //计算y方向item个数
    NSInteger yCount = (height / itemH);
    //计算一页总个数
    NSInteger allCount = (xCount * yCount);
    //获取每个section的页数，从0开始
    NSInteger page = itemIndex / allCount;
    
    //余数，用来计算item的x的偏移量
    NSInteger remain = (itemIndex % xCount);
    
    //取商，用来计算item的y的偏移量
    NSInteger merchant = (itemIndex - page*allCount)/xCount;
    
    
    //x方向每个item的偏移量
    CGFloat xCellOffset = remain * itemW;
    //y方向每个item的偏移量
    CGFloat yCellOffset = merchant * itemH;
    
    //获取每个section中item占了几页
    NSInteger pageRe = (itemCount % allCount == 0)? (itemCount / allCount) : (itemCount / allCount) + 1;
    //将每个section与pageRe对应，计算下面的位置
    [self.secitonDic setValue:@(pageRe) forKey:@(section).stringValue];
    
    if(self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        NSInteger actualLo = 0;
        //将每个section中的页数相加
        for (NSString *key in [self.secitonDic allKeys]) {
            actualLo += [self.secitonDic[key] integerValue];
        }
        //最后一组
        NSString * lastKey =  @([self.secitonDic allKeys].count - 1).stringValue;
        //获取到的最后的数减去最后一组的页码数
        actualLo -= [self.secitonDic[lastKey] integerValue];
        
        xCellOffset += page * width + actualLo * width;
        
    } else {
        
        yCellOffset += offset;
    }
    
    attributes.frame = CGRectMake(xCellOffset, yCellOffset, itemW, itemH);
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attributesArray;
    
}

@end
