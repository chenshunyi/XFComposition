//
//  VolunteerFrsitHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerFrsitHeadView.h"

@implementation VolunteerFrsitHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _tabBtnArray = [[NSMutableArray alloc]init];
        NSArray *array = @[@"当前活动",@"志愿教师招募",@"学生投稿活动"];
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WidthFrame, 30)];
        scroll.contentSize = CGSizeMake(WidthFrame, 30);
        scroll.bounces = NO;
//        scroll.scrollEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
//        scroll.backgroundColor = [UIColor grayColor];
        CGFloat btW = (WidthFrame-80-20*2)/3;
        [self addSubview:scroll];
        self.sliderV = [[UIView alloc]initWithFrame:CGRectMake(40, 29, btW, 1)];
        self.sliderV.backgroundColor = [UIColor redColor];
        [scroll addSubview:self.sliderV];

        
        for (int i = 0; i<array.count; i++) {
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [bt setTitle:array[i] forState:UIControlStateNormal];
            bt.tag = 1000+i;
            bt.titleLabel.font = [UIFont systemFontOfSize:12];
            bt.layer.cornerRadius = 6;
            bt.clipsToBounds = YES;
            [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            bt.frame = CGRectMake(40+(btW+20)*i, 3, btW, 24);
//            bt.backgroundColor = UIColorFromRGBA(30, 144, 255, 1.0f);
            bt.titleLabel.adjustsFontSizeToFitWidth = YES;
            [_tabBtnArray addObject:bt];
            if (i == 0) {
                [bt setTitleColor: UIColorFromRGBA(30, 144, 255, 1.0f) forState:UIControlStateNormal];
            }
                        [scroll addSubview:bt];
            
        }

    }
    return self;
}
-(void)click:(UIButton *)bt{
    CGFloat btW = (WidthFrame-80-20*2)/3;
    self.sliderV.frame = CGRectMake(40+(btW+20)*(bt.tag-1000), 29, btW, 1);
    if ([self.delegate respondsToSelector:@selector(VolunteerSrollView:)]) {
        [self.delegate VolunteerSrollView:bt];
    }
}

@end
