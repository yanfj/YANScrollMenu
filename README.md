# YANScrollMenu 
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/yanff/YANScrollMenu/blob/master/LICENSE)
[![CocoaPods](http://img.shields.io/cocoapods/v/YANScrollMenu.svg?style=flat)](http://cocoapods.org/?q=YANScrollMenu)
[![CocoaPods](http://img.shields.io/cocoapods/p/YANScrollMenu.svg?style=flat)](http://cocoapods.org/?q=YANScrollMenu)

![GIF](https://github.com/yanff/YANScrollMenu/blob/master/YANScrollMenu.gif)

## Requirements 
* ARC
* iOS 8.0+

## Cocoapods

`YANScrollMenu` is available via [Cocoapods](http://cocoapods.org/), add this line in your podfile :
 ```
    pod 'YANScrollMenu', '~> 0.9.1'
 ```
## Usage
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
   - (id<YANMenuObject>)scrollMenu:(YANScrollMenu *)scrollMenu objectAtIndexPath:(NSIndexPath *)indexPath;
   ```
4. Custom appearance :
   ```objective-c
    [[YANMenuItem appearance] setIconSize:30];
    [[YANMenuItem appearance] setIconCornerRadius:15];
    [[YANMenuItem appearance] setTextFont:[UIFont systemFontOfSize:12]];
    [[YANMenuItem appearance] setTextColor:[UIColor darkTextColor]];
   ```
   The function in `YANScrollMenuProtocol` can be use to adjust the edgeInsets of `YANMenuItem`:
   ```objective-c
   - (YANEdgeInsets)edgeInsetsOfItemInScrollMenu:(YANScrollMenu *)scrollMenu;
   ```
## Dependency

YANScrollMenu depend on  `SDWebImage` and  `Masonry`.
* When the version of  `SDWebImage` large than `3.8.2` , gif will not be supported.

## Release Notes

* V 0.9.1   Fix some bug and optimize the code
* V 0.9.0   The first version

## License

YANScrollMenu is released under the MIT license. See LICENSE file for details.

## Contact

Any suggestion or question? Please create a Github issue .