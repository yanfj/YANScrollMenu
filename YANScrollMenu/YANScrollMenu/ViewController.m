//
//  ViewController.m
//  YANScrollMenu
//
//  Created by Yan. on 2017/8/28.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import "ViewController.h"
#import "YANFlowLayout.h"
#import <Masonry.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 *  The collectionView.
 */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.collectionView = ({
//        
//        YANFlowLayout *layout = [[YANFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(100, 70);
//        
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        collectionView.backgroundColor = [UIColor whiteColor];
//        collectionView.showsVerticalScrollIndicator = NO;
//        collectionView.showsHorizontalScrollIndicator = NO;
//        collectionView.pagingEnabled = YES;
//        
//        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"log"];
//        
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        
//        collectionView;
//        
//    });
//    
//    [self.view addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(140);
//    }];
//
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return section < 2 ? 4 : 3;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"log" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blueColor];
    
    return cell;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 3;
}

@end
