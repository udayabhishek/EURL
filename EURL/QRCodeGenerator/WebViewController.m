//
//  WebViewController.m
//  QRCodeReader
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

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
    if ([self.urlString hasPrefix:@"www."]||[self.urlString hasPrefix:@"WWW."]) {
        NSString *prefix=@"http://";
        NSString *actual=self.urlString;
        self.urlString=@"";
        self.urlString=[self.urlString stringByAppendingString:prefix];
        self.urlString=[self.urlString stringByAppendingString:actual];
    }
        else if (([self.urlString hasPrefix:@"http:"])&&([self.urlString length]<11)){
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"invalid url" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            alert.tag=132;
        }
    
    NSURL *url=[NSURL URLWithString:self.urlString];
    NSLog(@"url=%@",url);
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    indicator.hidden=NO;
    webView.delegate=self;
    [webView loadRequest:urlRequest];
    
}
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
