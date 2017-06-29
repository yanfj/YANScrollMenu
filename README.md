# YANScrollMenu
[![CocoaPods](http://img.shields.io/cocoapods/v/YANScrollMenu.svg?style=flat)](http://cocoapods.org/?q= YANScrollMenu) 
[![CocoaPods](http://img.shields.io/cocoapods/p/YANScrollMenu.svg?style=flat)](http://cocoapods.org/?q= YANScrollMenu) 

![GIF](https://github.com/yanff/YANScrollMenu/blob/master/YANScrollMenu.gif)

Usage
-----
`YANScrollMenu` is available via [Cocoapods](http://cocoapods.org/), add this line in your podfile :
  ```
  pod 'YANScrollMenu', '~> 0.9.0'
  ```
1. Import the class  :

  ```objective-c
    #import "YANScrollMenu.h"
  ```
2. Simply initialize a `YANScrollMenu` the same way you set up a regular UIView:

  ```objective-c
    self.menu = [[YANScrollMenu alloc] initWithFrame:CGRectMake(0, 0, 375,150)];
    [self.view addSubview:self.menu];
  ```
3. `YANScrollMenuProtocol` must be adopted :
   ```objective-c
      - (NSUInteger)numberOfRowsForEachPageInScrollMenu:(YANScrollMenu *)scrollMenu;
      - (NSUInteger)numberOfItemsForEachRowInScrollMenu:(YANScrollMenu *)scrollMenu;
      - (NSUInteger)numberOfMenusInScrollMenu:(YANScrollMenu *)scrollMenu;
      - (YANMenuObject *)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath
   ```