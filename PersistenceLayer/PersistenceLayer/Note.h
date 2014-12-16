//
//  Note.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSString *content;

@end
