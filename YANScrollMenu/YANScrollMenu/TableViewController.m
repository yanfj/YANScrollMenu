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

@interface TableViewController ()<YANScrollMenuProtocol>{
    
    NSUInteger number;
    NSInteger row;
    NSInteger item;
}

@property (nonatomic, strong) YANScrollMenu *menu;
@end

@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    row = 2;
    item = 4;
    number = 15;
    
    self.menu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, ItemHeight*row + kPageControlHeight)];
    self.menu.delegate = self;
    self.tableView.tableHeaderView = self.menu;
    self.tableView.tableFooterView = [UIView new];
    
    [YANMenuItem appearance].textFont = [UIFont systemFontOfSize:12];
    [YANMenuItem appearance].textColor = [UIColor colorWithRed:128/255.f green:191/255.f blue:255/255.f alpha:1.0];
}
#pragma mark - YANScrollMenuProtocol
- (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return row;
}
- (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return item;
}
- (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return number;
}
- (YANMenuObject *)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath{
    
    YANMenuObject *object = [[YANMenuObject alloc] init];
    
    if (indexPath.section %2 == 0) {
        
        object.text = @"xxx";
        
    }else{
        
        if (indexPath.row % 3 == 1) {
            object.text = @"oooo\nxxxx";
        }else if (indexPath.row % 3 == 2){
            object.text = @"xxxxxxxxoooooooo";
        }
        else{
            
            object.text = @"oooo";
        }

    }
    
    if (indexPath.row %2 == 0) {
        
        if (indexPath.row % 3 == 1) {
             object.image = @"http://opd9rhjcu.bkt.clouddn.com/FnCMc1jANXqvmpi_pJt-rT3bkAT6";
        }else if(indexPath.row % 3 == 2){
            NSString *urlStr = @"http://wx.qlogo.cn/mmopen/sK29NB5SsTTlgdlCNUpm2xOjnlHjyoR9cyt1HLWsicbZxVAP89HnetPJ7bjdnryqibXh30TmIAb8rRoDJzsG8DF30KskagQ9Q8/0";
            object.image = [NSURL URLWithString:urlStr];
        }else{
            object.image = [UIImage imageNamed:@"IMG_0648.JPG"];
            
        }
       
    }else{
        

        object.image = @"http://i3.17173cdn.com/2fhnvk/YWxqaGBf/cms3/AocYbrbknfDxhCD.gif";
    }
    
    return object;
}

- (void)scrollMenu:(YANScrollMenu *)scrollMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *tips = [NSString stringWithFormat:@"tap item at indexPath:[%ld - %ld]",indexPath.section,indexPath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:tips preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}
- (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu{
    
    return YANEdgeInsetsMake(kScale(5), 0, kScale(5), 0, kScale(5));
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
            number = 4;
        }
            break;
        case 1:{
            row = 2;
            item = 5;
            number = 9;
        }
            break;
        case 2:{
            row = 2;
            item = 5;
            number = 13;
        }
            break;
        case 3:{
            row = 3;
            item = 4;
            number = 11;
        }
            break;
        case 4:{
            row = 3;
            item = 5;
            number = 16;
        }
            break;
        default:
            break;
    }
    
    
    
}


@end
