//
//  NoteDAO.m
//  PersistenceLayer
//
//  Created by taotao on 14/12/16.
//  Copyright (c) 2014年 RuiShuai Co., Ltd. All rights reserved.
//

#import "NoteDAO.h"

@implementation NoteDAO

-(void)create:(Note *)model
{
    NSString *path = [HOST_PATH URLEncodedString];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:@"sinotao1@163.com" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"add" forKey:@"action"];
    [param setValue:model.date forKey:@"date"];
    [param setValue:model.content forKey:@"content"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        
        if ([resultCodeNumber integerValue] >= 0) {
            
            //发送成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoCreateFinishedNotification object:nil];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            //发送失败通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoCreateFailedNotification object:error];
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        //发送失败通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DaoCreateFailedNotification object:err];
        
    }];
    
    [engine enqueueOperation:op];
    
}

-(void)remove:(Note *)model
{
    NSString *path = [HOST_PATH URLEncodedString];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:@"sinotao1@163.com" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"remove" forKey:@"action"];
    [param setValue:model.ID forKey:@"id"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        
        if ([resultCodeNumber integerValue] >= 0) {
            
            //发送成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoRemoveFinishedNotification object:nil];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            //发送失败通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoRemoveFailedNotification object:error];
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        //发送失败通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DaoRemoveFailedNotification object:err];
        
    }];
    
    [engine enqueueOperation:op];
}

-(void)modify:(Note *)model
{
    NSString *path = [HOST_PATH URLEncodedString];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:@"sinotao1@163.com" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"modify" forKey:@"action"];
    [param setValue:model.ID forKey:@"id"];
    [param setValue:model.date forKey:@"date"];
    [param setValue:model.content forKey:@"content"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        
        if ([resultCodeNumber integerValue] >= 0) {
            
            //发送成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoModifyFinishedNotification object:nil];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            //发送失败通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoModifyFailedNotification object:error];
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        //发送失败通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DaoModifyFailedNotification object:err];
        
    }];
    
    [engine enqueueOperation:op];
}

-(void)findAll
{
    NSString *path = [HOST_PATH URLEncodedString];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    
    [param setValue:@"sinotao1@163.com" forKey:@"email"];
    [param setValue:@"JSON" forKey:@"type"];
    [param setValue:@"query" forKey:@"action"];
    
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:HOST_NAME customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSData *data = [completedOperation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSNumber *resultCodeNumber = [resDict objectForKey:@"ResultCode"];
        
        if ([resultCodeNumber integerValue] >= 0) {
            
            //获取数据
            NSMutableArray *listDict = [resDict objectForKey:@"Record"];
            NSMutableArray *listData = [NSMutableArray new];
            
            for (NSDictionary *dict in listDict) {
                Note *note = [Note new];
                note.ID = [dict objectForKey:@"ID"];
                note.date = [dict objectForKey:@"CDate"];
                note.content = [dict objectForKey:@"Content"];
                [listData addObject:note];
            }
            
            //发送成功通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoFindAllFinishedNotification object:listData];
        } else {
            NSInteger resultCode = [resultCodeNumber integerValue];
            NSNumber *resultCodeNumber = [NSNumber numberWithInt:resultCode];
            NSString *message = [resultCodeNumber errorMessage];
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
            
            NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
            
            //发送失败通知
            [[NSNotificationCenter defaultCenter] postNotificationName:DaoFindAllFailedNotification object:error];
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSError *err = [completedOperation error];
        //发送失败通知
        [[NSNotificationCenter defaultCenter] postNotificationName:DaoFindAllFailedNotification object:err];
        
    }];
    
    [engine enqueueOperation:op];
}

@end
