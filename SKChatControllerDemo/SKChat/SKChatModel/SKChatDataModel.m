//
//  SKDataModel.m
//  TestXMPPDesktop
//
//  Created by LeouW on 15/10/20.
//  Copyright © 2015年 CC. All rights reserved.
//

#import "SKChatDataModel.h"

@implementation SKDataModel

@end

#pragma mark - XMPPLoginInfo - SKXMPPUser - SKXMPPServer

@implementation SKXMPPLoginInfo

@synthesize loginServer = _loginServer;
@synthesize loginUser = _loginUser;

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        _loginUser = [[SKXMPPUser alloc] init];
        _loginServer = [[SKXMPPServer alloc] init];
    }
    return self;
}

@end

@implementation SKXMPPUser

@synthesize userId = _userId;
@synthesize usernameString = _usernameString;
@synthesize userPasswordString = _userPasswordString;

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        _userId = 0;
        _usernameString = @"";
        _userPasswordString = @"";
    }
    return self;
}

@end

@implementation SKXMPPServer

@synthesize serverDomainString = _serverDomainString;
@synthesize serverResourceString = _serverResourceString;
@synthesize serverString = _serverString;
@synthesize serverPort = _serverPort;

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        _serverPort = 0;
        _serverDomainString = @"";
        _serverResourceString = @"";
        _serverString = @"";
    }
    return self;
}

@end


@implementation SKXMPPGroupList

@synthesize groupListRoomId = _groupListRoomId;
@synthesize groupListUsernameString = _groupListUsernameString;
@synthesize groupListRoomNameString = _groupListRoomNameString;
@synthesize groupListBtype = _groupListBtype;
@synthesize groupListName = _groupListName;

- (id)init {
    
    self = [super init];
    
    if(self) {
        
        _groupListRoomId = 0;
        _groupListUsernameString = @"";
        _groupListRoomNameString = @"";
        _groupListBtype = 0;
        _groupListName = @"";
    }
    return self;
}

@end