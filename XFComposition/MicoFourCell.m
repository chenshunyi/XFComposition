//
//  MicoFourCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicoFourCell.h"

@implementation MicoFourCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor redColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((WidthFrame-20-30)/9, 5, (WidthFrame-20-30)/9, 30)];
        
        [self addSubview:self.imageView];
        
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, (WidthFrame-20-30)/3, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        self.nameLabel.text = @"冷老师";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.nameLabel];
        
        self.jsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 63, (WidthFrame-20-30)/3, 10)];
        self.jsLabel.font = [UIFont systemFontOfSize:8];
        self.jsLabel.text = @"南京市第一小学  高级教师";
        [self addSubview:self.jsLabel];
        
        self.gyLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 76, (WidthFrame-20-30)/3, 10)];
        self.gyLabel.font = [UIFont systemFontOfSize:10];
        self.gyLabel.text = @"公益值：85";
        [self addSubview:self.gyLabel];
        
        self.djLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 89, 45, 10)];
        self.djLabel.font = [UIFont systemFontOfSize:10];
        self.djLabel.text = @"教师星级:";
        self.djLabel.textColor = [UIColor redColor];
        [self addSubview:self.djLabel];
        
    }
    return self;
}
-(void)setA:(int)a{
    _a= a;
    NSLog(@"个数%d",self.a);
    for (int i =0; i<self.a; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.frame = CGRectMake(55+10*i, 89, 10, 10);
        imgView.image = [UIImage imageNamed:@"pic_star"];
        [self addSubview:imgView];
    }
}
@end
