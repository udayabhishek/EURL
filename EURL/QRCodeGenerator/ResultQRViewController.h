//
//  ResultQRViewController.h
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultQRViewController : UIViewController<UIWebViewDelegate>
{
  IBOutlet UIWebView *resultWebView;
  IBOutlet UIActivityIndicatorView *indicator;
    
    
}
@property(strong,nonatomic)NSString *resultUrlString;

@end
