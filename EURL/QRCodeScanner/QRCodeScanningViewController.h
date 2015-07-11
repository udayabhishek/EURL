//
//  QRCodeScanningViewController.h
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WebViewController.h"
@interface QRCodeScanningViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;
@property(strong,nonatomic)NSString *titleString;
@property(strong,nonatomic)NSString *str1;
- (IBAction)startStopReading:(id)sender;
@end
