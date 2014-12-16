//
//  DetailViewController.m
//  PresentationLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong,nonatomic) NSMutableData *datas;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

-(void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
    //浮动窗口
    if (self.masterPopoverController !=nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        Note *note = _detailItem;
        self.textView.text = note.content;
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureView];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
    }
    
    _bl = [NoteBL new];
    //注册观察者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFinished:)
                                                 name:BLModifyNoteFinishedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(modifyNoteFailed:)
                                                 name:BLModifyNoteFailedNotification
                                               object:nil];
    
    
}

- (void)insertNewObject:(id)sender
{
    AddViewController *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    UINavigationController *nav = (UINavigationController *)addViewController.parentViewController;
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - IBAction

-(IBAction)onclickSave:(id)sender
{
    Note *note = _detailItem;
    note.date = [[NSDate alloc] init];
    note.content = self.textView.text;
    [_bl modifyNote:note];
}

#pragma mark - BLNotification

- (void)modifyNoteFinished:(NSNotification*)notification {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"操作信息"
                                                        message:@"修改成功。"
                                                       delegate:self
                                              cancelButtonTitle:@"返回"
                                              otherButtonTitles:@"继续", nil];
    [alertView show];
}

- (void)modifyNoteFailed:(NSNotification*)notification
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
        //返回
        UINavigationController *navController = (UINavigationController*)self.parentViewController;
        [navController popViewControllerAnimated:YES];
    }
}

@end
