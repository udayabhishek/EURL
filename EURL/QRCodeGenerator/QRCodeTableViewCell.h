//
//  QRCodeTableViewCell.h
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView *QRImage;
@property(strong,nonatomic)IBOutlet UILabel *QRtype;
@property(strong,nonatomic)IBOutlet UILabel *time;
@property(strong,nonatomic)IBOutlet UIButton *deleteQRButton;
@end
