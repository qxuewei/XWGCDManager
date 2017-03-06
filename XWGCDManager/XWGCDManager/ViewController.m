//
//  ViewController.m
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "XWGCDManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block UIImage *image;
//    [XWGCDManager executeIn]
    [XWGCDManager executeInGlobalQueue:^{
        // 下载图片
        NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/pic/item/0dd7912397dda144507634b8b0b7d0a20cf486b9.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:imageData];
       [XWGCDManager executeInMainQueue:^{
          //主线程UI展示
           self.imageView.image = image;
           if ([XWGCDManager isMainQueue]) {
               self.loadLabel.hidden = YES;
           }
       }];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
