//
//  QRCodeGeneratedViewController.h
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "GADBannerView.h"
#import "QRCodeTableViewCell.h"
#import "Retrieve.h"
#import "DeleteQRCode.h"
#import "ResultQRViewController.h"
@interface QRCodeGeneratedViewController : UIViewController<GADBannerViewDelegate,UITableViewDataSource,UITableViewDelegate,DeleteQRCodeDelegate,RetrieveDelegate,UIAlertViewDelegate>
{
   IBOutlet UITableView *tableView1;
    NSString *replaceUuidString;
    IBOutlet UIActivityIndicatorView *indicator;
    }
@property(strong,nonatomic)NSString *titleString;

@end
