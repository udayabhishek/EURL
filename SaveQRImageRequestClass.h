//
//  SaveQRImageRequestClass.h
//  EURL
//
//  Created by ShikshaPC-41 on 07/10/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol SaveImageQRDelegate <NSObject>

@optional

-(void)successJsonParsingForInsertingOriginalImageRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsingForInsertingOriginalImageRecord;

@end


@interface SaveQRImageRequestClass : NSObject
{
    id SaveImageQRDelegate;
    BOOL *status;
    NSMutableArray *fetchedResponseArray;
}
@property (nonatomic, strong) id SaveImageQRDelegate;
-(void)makeRequestForInsertOriginalImageBy:(NSString *)ID IMEI:(NSString *)UDID date_time:(NSString *)date_time  app_name:(NSString *)appName time1:(NSString *)time uploadedfile:(NSString *)uploadedfile;

@end

