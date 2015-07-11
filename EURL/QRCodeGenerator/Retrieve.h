//
//  Retrieve.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol RetrieveDelegate <NSObject>
@optional
-(void)successJsonParsingForRetrieveRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsingForRetrieveRecord:(NSDictionary *)retrieveDict;
@end

@interface Retrieve : NSObject
{
    id RetrieveDelegate;
    BOOL status;
    NSMutableArray *fetchedResponseArray;
}
@property(strong,nonatomic)id RetrieveDelegate;
-(void)makeRequestForRetrieveQRResultBy:(NSString *)UDID app_name:(NSString *)appName;
//{"IMEI":"355558053630800","app_name":"Eurl"}
@end
