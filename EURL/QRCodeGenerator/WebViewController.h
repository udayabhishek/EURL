//
//  WebViewController.h
//  QRCodeReader
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *indicator;

}
@property(strong,nonatomic)NSString *urlString;
@end
