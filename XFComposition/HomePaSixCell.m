//
//  HomePaSixCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "HomePaSixCell.h"

@implementation HomePaSixCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        CGFloat imageW = WidthFrame/4-10-10;
        self.imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageW, 110)];
//        self.imageView1.backgroundColor = [UIColor yellowColor];
        self.imageView1.image = [UIImage imageNamed:@"icon8_yuwen"];
        [self addSubview:self.imageView1];
        
        self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+5, 0, WidthFrame/4-5, 20)];
//        self.label1.font = [UIFont systemFontOfSize:9];
        [self.label1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:9]];
        self.label1.textColor = [UIColor redColor];
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 22, WidthFrame/4-10, 15)];
        self.label2.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.label2];
        self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 39, WidthFrame/4-10, 15)];
        self.label3.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.label3];
        self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 56, WidthFrame/4-10, 15)];
        self.label4.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.label4];
        self.label5 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 73, WidthFrame/4-10, 15)];
        self.label5.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.label5];
        
        self.label6 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView1.frame)+10, 90, WidthFrame/4-10, 15)];
        self.label6.font = [UIFont systemFontOfSize:9];
        [self addSubview:self.label6];
    }
    return self;
}
@end
