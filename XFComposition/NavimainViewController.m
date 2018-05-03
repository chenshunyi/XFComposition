//
//  NavimainViewController.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/25.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "NavimainViewController.h"

@interface NavimainViewController ()

@end

@implementation NavimainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];

}

@end
