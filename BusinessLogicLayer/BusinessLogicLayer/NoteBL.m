//
//  BusinessLogicLayer.m
//  BusinessLogicLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "NoteBL.h"

@implementation NoteBL

- (id)init
{
    self = [super init];
    if (self) {
        _dao = [NoteDAO new];
    }
    return self;
}

#pragma mark - NoteBL method
- (void)createNote:(Note *)entity
{
    //注册DaoCreateFinished,Failed通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFinished:)
                                                 name:DaoCreateFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createFailed:)
                                                 name:DaoCreateFailedNotification
                                               object:nil];
    [_dao create:entity];
}

- (void)removeNote:(Note *)entity
{
    //注册DaoRemoveFinished,Failed通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFinished:)
                                                 name:DaoRemoveFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeFailed:)
                                                 name:DaoRemoveFailedNotification
                                               object:nil];
    [_dao remove:entity];
}

- (void)modifyNote:(Note *)entity
{
    //注册DaoModifyFinished,Failed通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFinished:)
                                                 name:DaoModifyFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyFailed:)
                                                 name:DaoModifyFailedNotification
                                               object:nil];
    [_dao modify:entity];
}

- (void)findAllNotes
{
    //注册DaoFindAllFinished,Failed通知的观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFinished:)
                                                 name:DaoFindAllFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findAllFailed:)
                                                 name:DaoFindAllFailedNotification
                                               object:nil];
    [_dao findAll];
}

#pragma mark - NoteDAO Notification
-(void)createFinished:(NSNotification *)notification
{
    //发布BLCreateFinished通知
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFinishedNotification object:nil];
}

-(void)createFailed:(NSNotification *)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLCreateNoteFailedNotification object:error];
}

-(void)removeFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveNoteFinishedNotification object:nil];
}

-(void)removeFailed:(NSNotification *)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLRemoveNoteFailedNotification object:error];
}

-(void)modifyFinished:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyNoteFinishedNotification object:nil];
}

-(void)modifyFailed:(NSNotification *)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLModifyNoteFailedNotification object:error];
}

//涉及到通知中带有有效数据时,需要单次对应解除通知观察
-(void)findAllFinished:(NSNotification *)notification
{
    NSMutableArray *resList = [notification object];
    //发布BLFindAllNotes通知
    [[NSNotificationCenter defaultCenter] postNotificationName:BLFindAllNotesFinishedNotification object:resList];
    
    //解除DaoFindAllFinished、Failed通知的观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFailedNotification object:nil];
}

-(void)findAllFailed:(NSNotification *)notification
{
    NSError *error = [notification object];
    [[NSNotificationCenter defaultCenter] postNotificationName:BLFindAllNotesFailedNotification object:error];
    
    //解除DaoFindAllFinished、Failed通知的观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:DaoFindAllFailedNotification object:nil];
}


@end
