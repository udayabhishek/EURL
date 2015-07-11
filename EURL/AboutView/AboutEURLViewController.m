//
//  AboutEURLViewController.m
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "AboutEURLViewController.h"

@interface AboutEURLViewController ()

@end

@implementation AboutEURLViewController

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
    self.title=self.titleString;
    [self makeRequestForAdmobs];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return 220;
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            return 100;
        }
        else{
           return 80;
        }
    }
    
    return 150;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITextView *textView;
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        textView.returnKeyType=UIReturnKeyDefault;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 768, 220)];
            textView.font=[UIFont systemFontOfSize:30];
        }
        else{
            if([UIScreen mainScreen].bounds.size.height == 568){
                 textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 5, 300, 93)];
            } else{
               textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, 320,80)];            }
        }
        textView.textColor=[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:0.5];
        [textView setScrollEnabled:YES];
        [textView.layer setMasksToBounds:YES];
        textView.backgroundColor=[UIColor clearColor];
        textView.userInteractionEnabled=NO;
        [textView resignFirstResponder];
        [cell addSubview:textView];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_iPad"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cellimage_iPhone"]];
            }
            else{
                cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_image_iPhone"]];
            }
        }
    }
    
    if (indexPath.section==0) {
        textView.text=@"This application is basically used for generating QR codes from any of the inputs like(voice/image/text).Just take a pic/record a sound/write a text and convert it to QR in a matter of second.So why waiting download this cool app and become a Quicky QR member.";
    }
    
    if (indexPath.section==1) {
        textView.text=@"Text/Voice/Image Just scan the QR that got generated from the inputs.Scan it by clicking on the scan option and get the original image/hear the original sound or the orginal text.";
    }
    if (indexPath.section==2) {
        textView.text=@"Take any photo/record a sound/write a text and convert it to Qr within a fraction of second.After generating Qr user can print the Qr through Cloud Print Either User can use Classic Printer and Cloud-Ready Printer.In case of Classic Printer user has to add the printer in google chrome.";
    }
    return cell;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"About QRCode";
    }
    if (section==1) {
        return @"HOW TO SCAN";
    }
    if (section==2) {
        return @"HOW TO GENERATE QR";
        
    }
    return @"";
}

-(void)makeRequestForAdmobs
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(20.0,
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_768x90.height,
                                               
                                               GAD_SIZE_768x90.width,
                                               
                                               GAD_SIZE_768x90.height)];//Set Position
        
    }
    else{
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(0.0,
                                               
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_320x50.height,
                                               
                                               GAD_SIZE_320x50.width,
                                               
                                               GAD_SIZE_320x50.height)];//Set Position
        
    }
    bannerView.adUnitID = @"ca-app-pub-2781774783774395/7752176263";
    bannerView.delegate=self;
    
    // Let the runtime know which UIViewController to restore after taking
    
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView.rootViewController = self;
    
    [self.view addSubview:bannerView];//Your attempt to add bannerview
    
    
    
    // Initiate a generic request to load it with an ad.
    
    [bannerView loadRequest:[GADRequest request]];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
