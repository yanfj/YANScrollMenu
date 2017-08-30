//
//  DataSource.h
//  YANScrollMenu
//
//  Created by Yan. on 2017/7/4.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YANScrollMenu.h"

@interface DataSource : NSObject<YANObjectProtocol>
/**
 *  text
 */
@property (nonatomic, copy) NSString *itemDescription;
/**
 *  image(eg.NSURL ,NSString ,UIImage)
 */
@property (nonatomic, strong) id itemImage;
/**
 *  placeholderImage
 */
@property (nonatomic, strong) UIImage *itemPlaceholder;


@end
