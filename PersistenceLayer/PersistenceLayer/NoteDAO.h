//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import "MKNetworkKit.h"

#define HOST_NAME @"iosbook1.com"
#define HOST_PATH @"/service/mynotes/webservice.php"

#define DaoCreateFinishedNotification @"DaoCreateFinishedNotification"
#define DaoCreateFailedNotification @"DaoCreateFailedNotification"
#define DaoRemoveFinishedNotification @"DaoRemoveFinishedNotification"
#define DaoRemoveFailedNotification @"DaoRemoveFailedNotification"
#define DaoModifyFinishedNotification @"DaoModifyFinishedNotification"
#define DaoModifyFailedNotification @"DaoModifyFailedNotification"
#define DaoFindAllFinishedNotification @"DaoFindAllFinishedNotification"
#define DaoFindAllFailedNotification @"DaoFindAllFailedNotification"
#define DaoFindIdFinishedNotification @"DaoFindIdFinishedNotification"
#define DaoFindIdFailedNotification @"DaoFindIdFailedNotification"

@interface NoteDAO : NSObject

@property (nonatomic,strong) NSMutableArray *listData;

-(void)create:(Note *)model;
-(void)remove:(Note *)model;
-(void)modify:(Note *)model;
-(void)findAll;

@end
