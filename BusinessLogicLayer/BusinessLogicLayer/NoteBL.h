//
//  BusinessLogicLayer.h
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAO.h"


#define BLCreateNoteFinishedNotification @"BLCreateNoteFinishedNotification"
#define BLCreateNoteFailedNotification @"BLCreateNoteFailedNotification"
#define BLRemoveNoteFinishedNotification @"BLRemoveNoteFinishedNotification"
#define BLRemoveNoteFailedNotification @"BLRemoveNoteFailedNotification"
#define BLModifyNoteFinishedNotification @"BLModifyNoteFinishedNotification"
#define BLModifyNoteFailedNotification @"BLModifyNoteFailedNotification"
#define BLFindAllNotesFinishedNotification @"BLFindAllNotesFinishedNotification"
#define BLFindAllNotesFailedNotification @"BLFindAllNotesFailedNotification"


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

@interface NoteBL : NSObject

@property (strong,nonatomic) NoteDAO *dao;

- (void)createNote:(Note *)entity;
- (void)removeNote:(Note *)entity;
- (void)modifyNote:(Note *)entity;
- (void)findAllNotes;


@end
