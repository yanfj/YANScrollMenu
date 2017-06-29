//
//  TableViewController.m
//  YANScrollMenu
//
//  Created by Yan. on 2017/6/28.
//  Copyright © 2017年 Yan. All rights reserved.
//

#import "TableViewController.h"
#import "YANScrollMenu.h"

#define ItemHeight 90
#define IMG(name)           [UIImage imageNamed:name]

@interface TableViewController ()<YANScrollMenuProtocol>{
    
    NSInteger row;
    NSInteger item;
}

@property (nonatomic, strong) YANScrollMenu *menu;
/**
 *  dataSource
 */
@property (nonatomic, strong) NSMutableArray<YANMenuObject *> *dataSource;
@end

@implementation TableViewController
- (NSMutableArray<YANMenuObject *> *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    row = 0;
    item = 0;
    
    [self prepareUI];
    
    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self createData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self reload:self.navigationItem.rightBarButtonItem];
            
        });
    });
    

}
#pragma mark - Prepare UI
- (void)prepareUI{
    
    self.menu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ItemHeight*row + kPageControlHeight)];
    self.menu.currentPageIndicatorTintColor = [UIColor colorWithRed:107/255.f green:191/255.f blue:255/255.f alpha:1.0];
    self.menu.delegate = self;
    self.tableView.tableHeaderView = self.menu;
    self.tableView.tableFooterView = [UIView new];
    
    [YANMenuItem appearance].textFont = [UIFont systemFontOfSize:12];
    [YANMenuItem appearance].textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
    
}
#pragma mark -  Data
- (void)createData{
    
    
    NSArray *images = @[IMG(@"icon_cate"),
                        IMG(@"icon_drinks"),
                        IMG(@"icon_movie"),
                        IMG(@"icon_recreation"),
                        IMG(@"icon_stay"),
                        IMG(@"icon_ traffic"),
                        IMG(@"icon_ scenic"),
                        IMG(@"icon_fitness"),
                        IMG(@"icon_fitment"),
                        IMG(@"icon_hairdressing"),
                        IMG(@"icon_mom"),
                        IMG(@"icon_study"),
                        IMG(@"icon_travel"),
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1498711713465&di=d986d7003deaae41342dd9885c117e38&imgtype=0&src=http%3A%2F%2Fs9.rr.itc.cn%2Fr%2FwapChange%2F20168_3_0%2Fa86hlk59412347762310.GIF"];
    NSArray *titles = @[@"美食",
                        @"休闲娱乐",
                        @"电影/演出",
                        @"KTV",
                        @"酒店住宿",
                        @"火车票/机票",
                        @"旅游景点",
                        @"运动健身",
                        @"家装建材",
                        @"美容美发",
                        @"母婴",
                        @"学习培训",
                        @"旅游出行",
                        @"动态图\n从网络获取"];
    
    for (NSUInteger idx = 0; idx< images.count; idx ++) {
        
        YANMenuObject *object = [YANMenuObject objectWithText:titles[idx] image:images[idx] placeholderImage:IMG(@"placeholder")];
        
        [self.dataSource addObject:object];
        
    }
    
    
}
#pragma mark - YANScrollMenuProtocol
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return row;
}
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return item;
}
- (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return self.dataSource.count;
}
- (YANMenuObject *)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    return self.dataSource[idx];
}

- (void)scrollMenu:(YANScrollMenu *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger idx = indexPath.section * item + indexPath.row;
    
    NSString *tips = [NSString stringWithFormat:@"IndexPath: [ %ld - %ld ]\nTitle:   %@",indexPath.section,indexPath.row,self.dataSource[idx].text];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:tips preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return YANEdgeInsetsMake(kScale(10), 0, kScale(5), 0, kScale(5));
}
- (IBAction)reload:(id)sender {
    
    self.tableView.tableHeaderView = nil;
    
    CGRect frame = self.menu.frame;
    frame.size.height = row * ItemHeight + kPageControlHeight;
    self.menu.frame = frame;
    
    self.tableView.tableHeaderView = self.menu;
    
    [self.menu reloadData];
}
#pragma mark - TableView Delegate & DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            row = 1;
            item = 5;
        }
            break;
        case 1:{
            row = 2;
            item = 4;
        }
            break;
        case 2:{
            row = 2;
            item = 5;
        }
            break;
        case 3:{
            row = 3;
            item = 4;
        }
            break;
        case 4:{
            row = 3;
            item = 5;
        }
            break;
        default:
            break;
    }
    
    
    
}


@end
