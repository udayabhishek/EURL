//
//  InsertImageRequestClass.h
//  EURL
//
//  Created by ShikshaPC-41 on 01/10/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol InsertOriginalImageDelegate <NSObject>

@optional
-(void)successJsonParsingForInsertingOriginalImageRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsingForInsertingOriginalImageRecord;

@end
@interface InsertImageRequestClass : NSObject
{
    id InsertOriginalImageDelegate;
    BOOL *status;
    NSMutableArray *fetchedResponseArray;
}
@property (nonatomic, strong) id InsertOriginalImageDelegate;
-(void)makeRequestForInsertOriginalImageBy:(NSString *)UDID app_name:(NSString *)appName type:(NSString *)type time1:(NSString *)time uploadedfile:(NSString *)uploadedfile;

@end
