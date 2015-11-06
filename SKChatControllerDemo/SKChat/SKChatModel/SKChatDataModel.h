//
//  SKDataModel.h
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/20.
//  Copyright © 2015年 CC. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 expansion1  平台回执信息
 expansion2  注销请求
 expansion3  个人消息回执
 expansion4  群组消息
 expansion5  离线消息
 expansion6  群组列表
 expansion7  按照房间号和消息Id获取消息
 expansion8  在房间，不在聊天室获取的消息
 expansion9  ID不存在的消息
 */

/*
 ****btype****
 *
 * 1 群组
 * 2 个人(点对点)
 * 3 公众账号
 */

@interface SKDataModel : NSObject

@end

#pragma mark - XMPPLoginInfo - SKXMPPUser - SKXMPPServer
@class SKXMPPUser;
@class SKXMPPServer;

/*
 *XMPP登录相关信息：用户，服务器等
 */
@interface SKXMPPLoginInfo : NSObject

@property(nonatomic, strong)SKXMPPUser   *loginUser;//登录用户
@property(nonatomic, strong)SKXMPPServer *loginServer;//登录服务器

@end

/*
 *XMPP用户
 */
@interface SKXMPPUser : NSObject

@property(nonatomic, assign)NSInteger  userId;//xmpp 用户地址
@property(nonatomic, strong)NSString  *usernameString;//xmpp 用户名
@property(nonatomic, strong)NSString  *userPasswordString;//xmpp 用户密码xmpp登录的密码 在XMPP服务器连接成功之后验证

@end

/*
 *XMPP登录服务器相关信息
 */
@interface SKXMPPServer : NSObject

@property(nonatomic, strong)NSString  *serverDomainString;//JID（"51327@murp-ymm2003/iphone_teacher_1.0.8"）的domain（murp-ymm2003）
@property(nonatomic, strong)NSString  *serverResourceString;//JID（"51327@murp-ymm2003/iphone_teacher_1.0.8"）的Resource（iphone_teacher_1.0.8）
@property(nonatomic, strong)NSString  *serverString;//xmpp服务器地址
@property(nonatomic, assign)NSInteger  serverPort;//xmpp服务器端口

@end


/*
 *XMPP群组相关信息
 */
@interface SKXMPPGroupList : NSObject

@property(nonatomic, assign)NSInteger  groupListRoomId;//群组房间ID号
@property(nonatomic, strong)NSString  *groupListRoomNameString;////群组房间名字
@property(nonatomic, strong)NSString  *groupListUsernameString;//群组当前成员 XMPP登录帐号
@property(nonatomic, assign)NSInteger  groupListBtype;///群组房间类型 1－群组 2-个人 3-公众账号
@property(nonatomic, strong)NSString  *groupListName;///群组房间唯一标识 － 用于替换原来ID为整数在自定义群组中可能会出现问题的不确定性

@end

