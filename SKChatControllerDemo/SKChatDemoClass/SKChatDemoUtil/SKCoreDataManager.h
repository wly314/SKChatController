//
//  SKCoreDataManager.h
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/21.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKCoreDataManager : NSObject

//清空某个实体的所有数据
+ (BOOL)deleteAllDataOfEntityName:(NSString *)entityName;
//插入SKXMPPGroupList Model数据
+ (BOOL)insertSKGroupListWithSKXMPPGroupListModel:(id)aData;

@end
