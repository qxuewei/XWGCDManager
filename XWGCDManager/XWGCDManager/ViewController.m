//
//  ViewController.m
//  XWGCDManager
//
//  Created by 邱学伟 on 2017/3/3.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "XWGCDManager.h"
#import "XWGCDGroup.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *loadLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block UIImage *image;
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
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"测试" preferredStyle:UIAlertControllerStyleAlert];
    [XWGCDManager executeInMainQueue:^{
        
        [self presentViewController:ac animated:YES completion:nil];
        [XWGCDManager executeInMainQueue:^{
        
            [ac dismissViewControllerAnimated:YES completion:nil];
        } afterDelaySecs:2];
    } afterDelaySecs:5];
    
    XWGCDGroup *group = [[XWGCDGroup alloc] init];
    
    [[XWGCDManager globalQueue] execute:^{
        sleep(4);
        NSLog(@"异步操作1结束 当前线程:%@",[NSThread currentThread]);
    } inGroup:group];
    
    [[XWGCDManager globalQueue] execute:^{
        sleep(8);
        NSLog(@"异步操作2结束 当前线程:%@",[NSThread currentThread]);
    } inGroup:group];
    
    [[XWGCDManager mainQueue] notify:^{
        NSLog(@"等待异步操作1 和 2 完事执行当前操作! 当前线程:%@",[NSThread currentThread]);
    } inGroup:group];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
