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
                               Created by Yan. on 2017/6/28.
                               Copyright © 2017年 Yan. All rights reserved.
****************************************************************************/

#import <UIKit/UIKit.h>

#define kScale(P)                ((P) * ([UIScreen mainScreen].bounds.size.width / 375.f))
#define kPageControlHeight       16

NS_ASSUME_NONNULL_BEGIN

/****************************  YANMenuObject ***************************/

/**  
 *  @brief  The datasource of YANScrollMenu.
 */
@protocol YANMenuObject<NSObject>
/**
 *  The text of item.
 */
@property (nonatomic, copy) NSString *text;
/**
 *  The image of item. (eg.NSURL,NSString,UIImage)
 */
@property (nonatomic, strong) id image;
/**
 *  The placeholderImage of item.
 */
@property (nonatomic, strong) UIImage *placeholderImage;

@end


/****************************  YANEdgeInsets ***************************/

/**
 *  @brief  The edgeInsets of YANMenuItem.
 */
typedef struct YANEdgeInsets{
    
    CGFloat top;        //The top margin of icon
    CGFloat left;       //The left margin of label
    CGFloat middle;     //The margin between label and icon
    CGFloat right;      //The right margin of label
    CGFloat bottom;     //The bottom margin of label
    
}YANEdgeInsets;

/**
 Make YANEdgeInsets

 @param top       The top margin of icon
 @param left      The left margin of label
 @param middle    The margin between label and icon
 @param right     The right margin of label
 @param bottom    The bottom margin of label
 @return YANEdgeInsets
 */
UIKIT_STATIC_INLINE YANEdgeInsets YANEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat middle, CGFloat right, CGFloat bottom) {
    YANEdgeInsets insets = {top, left, middle, right,bottom};
    return insets;
}

/****************************  YANMenuItem ***************************/

/**
 *  @brief  The item of YANScrollMenu
 */
NS_CLASS_AVAILABLE_IOS(8_0) @interface YANMenuItem : UICollectionViewCell
/**
 *  The size of icon.
 */
@property (nonatomic, assign) CGFloat iconSize  UI_APPEARANCE_SELECTOR ; //defaul is 40;
/**
 *  The cornerRadius of icon.
 */
@property (nonatomic, assign) CGFloat iconCornerRadius UI_APPEARANCE_SELECTOR; //defaul is 20;
/**
 *  The color of label.
 */
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR ; //defaul is [UIColor darkTextColor];
/**
 *  The font of label.
 */
@property (nonatomic, strong) UIFont *textFont UI_APPEARANCE_SELECTOR; //defaul is [UIFont systemFontOfSize:14];

@end;


/**********************  YANScrollMenuProtocol ***************************/

@class YANScrollMenu;
/**
 *  @brief  YANScrollMenuProtocol(protocol)
 */
@protocol YANScrollMenuProtocol <NSObject>
/**
 Number of rows for each page.

 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu;
/**
 Number of items for each row.

 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu;
/**
 Number of menus (total).

 @param scrollMenu YANScrollMenu
 @return NSUInteger
 */
- (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu;
/**
 Object at index.

 @param scrollMenu YANScrollMenu
 @param indexPath NSIndexPath
 @return id<YANMenuObject>
 */
- (id<YANMenuObject>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 The edgeInsets of item.

 @param scrollMenu YANScrollMenu
 @return YANEdgeInsets
 */
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu;
/**
 Did select at index.

 @param scrollMenu YANScrollMenu
 @param indexPath NSIndexPath
 */
- (void)scrollMenu:(YANScrollMenu *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath;


@end

/**********************  YANScrollMenu ***************************/

/**
 *  @brief  YANScrollMenu
 */
NS_CLASS_AVAILABLE_IOS(8_0) @interface YANScrollMenu : UIView
/**
 *  The delegate of YANScrollMenu
 */
@property (nonatomic, weak) id<YANScrollMenuProtocol> delegate;
/**
 *  The currentPageIndicatorTintColor of pageControl.
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;  //default is  [UIColor darkTextColor]
/**
 *  The pageIndicatorTintColor of pageControl.
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor; //default is  [UIColor groupTableViewBackgroundColor]

/**
 Use to reload datasource and refresh UI.
 */
- (void)reloadData;

@end


NS_ASSUME_NONNULL_END
