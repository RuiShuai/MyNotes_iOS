//
//  AddViewController.h
//  PresentationLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteDAO.h"
#import "NoteBL.h"

#define BLCreateNoteFinishedNotification @"BLCreateNoteFinishedNotification"
#define BLCreateNoteFailedNotification @"BLCreateNoteFailedNotification"
#define BLRemoveNoteFinishedNotification @"BLRemoveNoteFinishedNotification"
#define BLRemoveNoteFailedNotification @"BLRemoveNoteFailedNotification"
#define BLModifyNoteFinishedNotification @"BLModifyNoteFinishedNotification"
#define BLModifyNoteFailedNotification @"BLModifyNoteFailedNotification"
#define BLFindAllNotesFinishedNotification @"BLFindAllNotesFinishedNotification"
#define BLFindAllNotesFailedNotification @"BLFindAllNotesFailedNotification"

@interface AddViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) NoteBL *bl;

- (IBAction)onclickDone:(id)sender;

- (IBAction)onclickSave:(id)sender;

@end
