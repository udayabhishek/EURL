//
//  InsertQRImage.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol InsertQRImageDelegate <NSObject>
@optional
-(void)successJsonParsingForInsertingImageRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsingForInsertingImageRecord;
@end

@interface InsertQRImage : NSObject
{
    id InsertQRImageDelegate;
    BOOL *status;
    NSMutableArray *fetchedResponseArray;

}
@property(strong,nonatomic)id InsertQRImageDelegate;
-(void)makeRequestForInsertQRCodeImageBy:(NSString *)ID app_name:(NSString *)appName time1:(NSString *)time date_time:(NSString *)dateAndtime type:(NSString *)type UDID:(NSString *)UDID uploadedfile:(NSString *)uploadedfile;
//"id":"325","app_name":"Eurl","time1":"09-01-2014","date_time":"09-01-20141987232460","type":"image","IMEI":"355558053630800","uploadedfile":"iVBORw0
@end
