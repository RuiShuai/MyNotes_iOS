//
//  AddViewController.m
//  PresentationLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bl = [NoteBL new];
    
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFinished:)
                                                 name:BLCreateNoteFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(createNoteFailed:)
                                                 name:BLCreateNoteFailedNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    //解除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (IBAction)onclickDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onclickSave:(id)sender
{
    Note *note = [Note new];
    note.date = [[NSDate alloc] init];
    note.content = _textView.text;
    [_bl createNote:note];
}

#pragma mark - BLNotification
- (void)createNoteFinished:(NSNotification*)notification
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:@"插入成功。"
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}

- (void)createNoteFailed:(NSNotification*)notification
{
    NSError *error = [notification object];
    NSString *errorStr = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:errorStr
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {//选择返回按钮
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
