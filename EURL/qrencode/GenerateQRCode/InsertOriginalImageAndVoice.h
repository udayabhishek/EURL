//
//  InsertOriginalVoice.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol InsertOriginalVoiceDelegate <NSObject>


@optional
-(void)successJsonParsingForInsertingRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsing;

@end

@interface InsertOriginalVoice : NSObject
{
    id InsertOriginalVoiceDelegate;
    BOOL *status;
    NSMutableArray *fetchedResponseArray;
}
@property (nonatomic, strong) id InsertOriginalVoiceDelegate;
-(void)makeRequestForInsertOriginalVoiceBy:(NSString *)UDID app_name:(NSString *)appName type:(NSString *)type time1:(NSString *)time uploadedfile:(NSString *)uploadedfile;
//{"IMEI":"355558053630800","app_name":"Eurl","type":"voice","time1":"09-01-2014"}
@end
