//
//  GetActivePageViewModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetActivePageViewModel : NSObject
//@property (nonatomic,strong)NSArray *SinCSb;
//@property (nonatomic,strong)NSArray *MuiCSb;
//@property (nonatomic,strong)NSArray *PDSb;
//@property (nonatomic,strong)NSArray *TKSb;
//@property (nonatomic,strong)NSArray *WDSb;

@property (nonatomic,strong)NSString *SubjectID;
@property (nonatomic,strong)NSString *SubjectTitle;
@property (nonatomic,strong)NSArray *answerItem;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
