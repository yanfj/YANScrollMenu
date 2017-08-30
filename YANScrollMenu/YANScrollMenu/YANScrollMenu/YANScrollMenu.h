/***********************************************************************

                        ::
                        :;J7, :,                        ::;7:
                        ,ivYi, ,                       ;LLLFS:
                        :iv7Yi                       :7ri;j5PL
                       ,:ivYLvr                    ,ivrrirrY2X,
                       :;r@Wwz.7r:                :ivukexianli.
                      :iL7::,:::iiirii:ii;::::,,irvF7rvvLujL7ur
                     ri::,:,::i:iiiiiii:i:irrv177JX7rYXqZEkvv17
                  ;i:, , ::::iirrririi:i:::iiir2XXvii;L8OGJr71i
                :,, ,,:   ,::ir@mingyi.irii:i:::j1jri7ZBOS7ivv,
                  ,::,    ::rv77iiiriii:iii:i::,rvLqshuhao.Li,
               ,,      ,, ,:ir7ir::,:::i;ir:::i:i::rSGGYri712:
             :::  ,v7r:: ::rrv77:, ,, ,:i7rrii:::::, ir7ri7Lri
            ,     2OBBOi,iiir;r::        ,irriiii::,, ,iv7Luur:
          ,,     i78MBBi,:,:::,:,  :7FSL: ,iriii:::i::,,:rLqXv::
          :      iuMMP: :,:::,:ii;2GY7OBB0viiii:i:iii:i:::iJqL;::
         ,     ::::i   ,,,,, ::LuBBu BBBBBErii:i:i:i:i:i:i:r77ii
        ,       :       , ,,:::rruBZ1MBBqi, :,,,:::,::::::iiriri:
       ,               ,,,,::::i:  @arqiao.       ,:,, ,:::ii;i7:
      :,       rjujLYLi   ,,:::::,:::::::::,,   ,:i,:,,,,,::i:iii
      ::      BBBBBBBBB0,    ,,::: , ,:::::: ,      ,,,, ,,:::::::
      i,  ,  ,8BMMBBBBBBi     ,,:,,     ,,, , ,   , , , :,::ii::i::
      :      iZMOMOMBBM2::::::::::,,,,     ,,,,,,:,,,::::i:irr:i:::,
      i   ,,:;u0MBMOG1L:::i::::::  ,,,::,   ,,, ::::::i:i:iirii:i:i:
      :    ,iuUuuXUkFu7i:iii:i:::, :,:,: ::::::::i:i:::::iirr7iiri::
      :     :rk@Yizero.i:::::, ,:ii:::::::i:::::i::,::::iirrriiiri::,
       :      5BMBBBBBBSr:,::rv2kuii:::iii::,:i:,, , ,,:,:i@petermu.,
            , :r50EZ8MBBBBGOBBBZP7::::i::,:::::,: :,:,::i;rrririiii::
                :jujYY7LS0ujJL7r::,::i::,::::::::::::::iirirrrrrrr:ii:
             ,:  :@kevensun.:,:,,,::::i:i:::::,,::::::iir;ii;7v77;ii;i,
             ,,,     ,,:,::::::i:iiiii:i::::,, ::::iiiir@xingjief.r;7:i,
          , , ,,,:,,::::::::iiiiiiiiii:,:,:::::::::iiir;ri7vL77rrirri::
           :,, , ::::::::i:::i:::i:i::,,,,,:,::i:i:::iir;@Secbone.ii:::

                               --    YANScrollMenu  --
                               Created by Yan. on 2017/8/28.
                               Copyright © 2017年 Yan. All rights reserved.
****************************************************************************/

#import <UIKit/UIKit.h>

#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))

NS_ASSUME_NONNULL_BEGIN


/** 数据模型协议 */
@protocol YANObjectProtocol <NSObject>
/**
 *  显示文本
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  显示图片，可以为NSURL,NSString,UIImage三种格式
 */
@property (nonatomic, strong) id itemImage;
/**
 *  占位图片
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;

@end



/** 菜单单元格 */
@interface YANMenuItem : UICollectionViewCell
/**
 *  图片的尺寸，默认是(40,40)
 */
@property (nonatomic, assign) CGSize iconSize  UI_APPEARANCE_SELECTOR ;
/**
 *  图片与文本的距离，默认是 10
 */
@property (nonatomic, assign) CGFloat space UI_APPEARANCE_SELECTOR;
/**
 *  图片的圆角率，默认是20
 */
@property (nonatomic, assign) CGFloat iconCornerRadius UI_APPEARANCE_SELECTOR;
/**
 *  文本的字体颜色，默认是darkTextColor
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR ;
/**
 *  文本的字体大小，默认是14号系统字体
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR;

@end


@class YANScrollMenu;

/** 代理协议 */
@protocol YANScrollMenuDelegate <NSObject>
@optional
/**
 单元格尺寸，默认是(40,70)

 @param menu 菜单
 @return CGSize
 */
- (CGSize)itemSizeOfScrollMenu:(YANScrollMenu *)menu;
/**
 分区的页眉，默认不显示

 @param menu 菜单
 @param section 分区
 @return UIView
 */
- (UIView *)scrollMenu:(YANScrollMenu *)menu headerInSection:(NSUInteger)section;
/**
 页眉的高度，默认20

 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfHeaderInScrollMenu:(YANScrollMenu *)menu;
/**
 分页器的高度，默认15

 @param menu 菜单
 @return CGFloat
 */
- (CGFloat)heightOfPageControlInScrollMenu:(YANScrollMenu *)menu;
/**
 当单元格数量改变时，是否自动更新Frame以适应。默认是NO

 @return BOOL
 */
- (BOOL)shouldAutomaticUpdateFrameInScrollMenu:(YANScrollMenu *)menu;
/**
 单元格点击回调

 @param menu 菜单
 @param indexPath 索引
 */
- (void)scrollMenu:(YANScrollMenu *)menu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


/** 数据源协议 */
@protocol YANScrollMenuDataSource <NSObject>
/**
 每个分区单元格的数量

 @param menu 菜单
 @param section 分区
 @return NSUInteger
 */
- (NSUInteger)scrollMenu:(YANScrollMenu *)menu numberOfItemsInSection:(NSInteger)section;
/**
 分区的数量

 @param menu 菜单
 @return NSUInteger
 */
- (NSUInteger)numberOfSectionsInScrollMenu:(YANScrollMenu *)menu;
/**
 数据源

 @param scrollMenu 菜单
 @param indexPath 索引
 @return id<YANObjectProtocol>
 */
- (id<YANObjectProtocol>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath;

@end



/** 滑动菜单 */
@interface YANScrollMenu : UIView
/**
 *  分页控制器当前分页的颜色，默认是 darkTextColor;
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 *  分页控制器分页的颜色，默认是 groupTableViewBackgroundColor;
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

/**
 初始化方法

 @param frame CGRect
 @param aDelegate id
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame  delegate:(id)aDelegate;
/**
 刷新
 */
- (void)reloadData;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END


