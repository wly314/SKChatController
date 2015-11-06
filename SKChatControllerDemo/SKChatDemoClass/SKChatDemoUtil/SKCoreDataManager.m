//
//  SKCoreDataManager.m
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/21.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "SKCoreDataManager.h"

#import "AppDelegate.h"
#import "SKChatDataModel.h"

@implementation SKCoreDataManager

+ (BOOL)insertSKGroupListWithSKXMPPGroupListModel:(id)aObject {
    
    SKXMPPGroupList *skXmppGroupList = (SKXMPPGroupList *)aObject;
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    // 传入上下文，创建一个SKGroupList实体对象
    NSManagedObject *skGroupListManager = [NSEntityDescription insertNewObjectForEntityForName:@"SKGroupList" inManagedObjectContext:context];
    // 设置属性
    [skGroupListManager setValue:[NSNumber numberWithInteger:skXmppGroupList.groupListRoomId] forKey:@"roomId"];
    [skGroupListManager setValue:skXmppGroupList.groupListRoomNameString forKey:@"roomName"];
    [skGroupListManager setValue:skXmppGroupList.groupListUsernameString forKey:@"username"];
    [skGroupListManager setValue:[NSNumber numberWithInteger:skXmppGroupList.groupListBtype] forKey:@"btype"];
    
    // 利用上下文对象，将数据同步到持久化存储库
    NSError *error = nil;
    BOOL success = [context save:&error];
    if (!success) {
        
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
        
        return NO;
    }
    return YES;
}


+ (BOOL)deleteAllDataOfEntityName:(NSString *)entityName {
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [context deleteObject:obj];
        }
        if (![context save:&error])
        {
            NSLog(@"error:%@",error);
            
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

@end
