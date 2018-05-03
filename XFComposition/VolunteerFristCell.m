//
//  VolunteerFristCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerFristCell.h"

@implementation VolunteerFristCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame/3-44)];

        imgView.image = [UIImage imageNamed:@"banner_zhiyuanzhe"];
        [self addSubview:imgView];
        
    }
    return  self;
}
@end
