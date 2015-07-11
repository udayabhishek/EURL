//
//  InsertTextRequestClass.h
//  EURL
//
//  Created by ShikshaPC-41 on 30/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol InsertTextDelegate <NSObject>

@optional
-(void)successJSONParsingTextResult:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingTextResult;
@end

@interface InsertTextRequestClass : NSObject
{
    id InsertTextDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id InsertTextDelegate;

-(void)makeRequestForInsertTextBy:(NSString *)originalImage app_name:(NSString *)appName date_time:(NSString *)dateAndtime date_time:(NSString *)date_time type:(NSString *)type time1:(NSString *)time IMEI:(NSString *)UDID uploadedfile:(NSString *)uploadedfile;


@end
