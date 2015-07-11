//
//  BaseUrl.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseUrl : NSObject

#define Path @"QRcode/"
#define InsertUrl @"original_save.php?"
#define InsertQRImageUrl @"QR_save.php?"
#define InsertTextUrl @"text_save.php?"
#define RetrieveUrl @"retrieve_QR.php?"
#define DeleteUrl @"delete_QR.php?"
#define SendTextFeedbackUrl @"UploadTextMessage.php?"
#define SendVoiceFeedbackUrl @"UploadVoiceMessage.php?"
#define MainUrl @"http://www.anshtech.org/"
@end
