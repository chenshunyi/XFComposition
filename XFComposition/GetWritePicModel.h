//
//  GetWritePicModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetWritePicModel : NSObject
@property (nonatomic,strong)NSString *BlogID;
@property (nonatomic,strong)NSString *CreateTime;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *PicUrl;
@property (nonatomic,strong)NSString *Sort;
@property (nonatomic,strong)NSString *UserID;
@property (nonatomic,strong)NSString *FixPicUrl;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
