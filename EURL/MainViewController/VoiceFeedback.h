//
//  VoiceFeedback.h
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "BaseUrl.h"

@protocol sendVoiceFeedbackDelegate<NSObject>
@optional
-(void)successJsonParsingForVoiceFeedback: (NSDictionary *)responseDict;
-(void)failureJsonParsingForVoiceFeedback;
@end
@interface VoiceFeedback : NSObject
{
    id sendVoiceFeedbackDelegate;
    BOOL status;
    NSMutableArray *fetchedResponseArray;
}
@property(strong,nonatomic)id sendVoiceFeedbackDelegate;
-(void)makeRequestFotSendTextFeedbackByText:(NSString *)voiceFeedbackString;
-(void)makeRequestFotSendVoiceFeedbackByText:(NSString *)audiofile AppName:(NSString *)appName;
@end
