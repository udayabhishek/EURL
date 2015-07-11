//
//  TextFeedback.h
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol sendTextFeedbackDelegate<NSObject>
@optional
-(void)successJsonParsingForTextFeedback: (NSDictionary *)responseDict;
-(void)failureJsonParsingForTextFeedback;
@end
@interface TextFeedback : NSObject
{
    id sendTextFeedbackDelegate;
    BOOL status;
    NSMutableArray *fetchedResponseArray;
}
@property(strong,nonatomic)id sendTextFeedbackDelegate;
-(void)makeRequestFotSendTextFeedbackByText:(NSString *)AppName TextMessage:(NSString *)message;
@end
