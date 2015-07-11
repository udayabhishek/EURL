//
//  ResultQRViewController.m
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "ResultQRViewController.h"

@interface ResultQRViewController ()

@end

@implementation ResultQRViewController
@synthesize resultUrlString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"QRCode-Result";
    NSURL *url=[NSURL URLWithString:resultUrlString];
    NSLog(@"%@",url);
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    resultWebView.delegate=self;
    indicator.hidden=NO;
    [resultWebView loadRequest:urlRequest];
}
//-(void)webViewDidStartLoad:(UIWebView *)webView{
//    
//    //[indicator startAnimating];
//    
//}
//-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    
////    [indicator stopAnimating];
////    indicator.hidden=YES;
//}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    indicator.hidden=YES;
    // [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
