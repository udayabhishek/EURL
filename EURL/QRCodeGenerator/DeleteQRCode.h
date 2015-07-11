//
//  DeleteQRCode.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeleteQRCodeDelegate <NSObject>
@optional
-(void)successJsonParsingForDeleteRecord: (NSDictionary *)responseDict;
-(void)failureJsonParsingForDeleteRecord:(NSDictionary *)deleteDict;
@end
@interface DeleteQRCode : NSObject
{
    id DeleteQRCodeDelegate;
    BOOL status;
    NSMutableArray *fetchedResponseArray;
}
@property(strong,nonatomic)id DeleteQRCodeDelegate;
-(void)makeRequestForDeleteQRCodeByIMEI:(NSString *)UDID deleteid:(NSString *)ID app_name:(NSString *)appName;
//"IMEI":"355558053630800","id":"329","app_name":"Eurl"}
@end
