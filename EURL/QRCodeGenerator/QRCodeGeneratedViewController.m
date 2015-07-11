//
//  QRCodeGeneratedViewController.m
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "QRCodeGeneratedViewController.h"

@interface QRCodeGeneratedViewController ()
{
    GADBannerView *bannerView;
    NSMutableArray *QRImageArray;
    NSMutableArray *typeArray;
    NSMutableArray *timeArray;
    NSMutableArray *resultQRArray;
    NSMutableArray *QRid;
    QRCodeTableViewCell *cell;
    NSString *tableDidSelectString;
    NSString *tableDidSelectIDString;
    NSString *selectedButtonId;
    NSUInteger idno;
}

@end

@implementation QRCodeGeneratedViewController
@synthesize titleString;

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
     [self makeRequestForAdmobs];
    // Do any additional setup after loading the view from its nib.
self.title=self.titleString;
     selectedButtonId=[[NSString alloc]init];
    UIDevice *myDevice=[UIDevice currentDevice];
    NSString *UUID = [[myDevice identifierForVendor] UUIDString];
    replaceUuidString=[UUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //NSLog(@"UDID: %@", replaceUuidString);
    [self makeRequestForRetrieveQRCodes];
    resultQRArray=[[NSMutableArray alloc]init];
    QRImageArray=[[NSMutableArray alloc]init];
    typeArray=[[NSMutableArray alloc]init];
    timeArray=[[NSMutableArray alloc]init];
    QRid=[[NSMutableArray alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [tableView1 registerNib:[UINib nibWithNibName:@"QRCodeTableViewCell_iPad" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    else{
        [tableView1 registerNib:[UINib nibWithNibName:@"QRCodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return typeArray.count;

    }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

     cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    if (cell==nil) {
        
        cell=(QRCodeTableViewCell *)[cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }

    [cell.deleteQRButton addTarget:self action:@selector(actionForDeleteTableCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.QRImage.layer.cornerRadius=4.0f;
    cell.QRImage.layer.borderWidth=1.50f;
    cell.QRImage.layer.borderColor=[[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg_iPad"]];
    }
    else{
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"cell_bg"]];
    }
    
    
    cell.QRtype.text=[typeArray objectAtIndex:indexPath.row];
    //cell.QRImage=[QRImageArray objectAtIndex:indexPath.row];
    cell.time.text=[timeArray objectAtIndex:indexPath.row];
    cell.deleteQRButton.tag=indexPath.row;
    //cell.deleteQRButton.tag=[[QRid objectAtIndex:indexPath.row] integerValue] ;
    
    if ([QRid count]) {
        //NSLog(@"%@",[QRid objectAtIndex:indexPath.row] );
        
    }
    else{
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // tableDidSelectIDString=[QRid objectAtIndex:indexPath.row];
    [typeArray objectAtIndex:indexPath.row];
    tableDidSelectString=[resultQRArray objectAtIndex:indexPath.row];
     ResultQRViewController *obj;
    if ([tableDidSelectString hasSuffix:@".png"]) {
        
        NSString *imagedir=@"http://www.anshtech.org/QRcode/image/actual_image/";
        NSString *actual=tableDidSelectString;
        tableDidSelectString=@"";
        tableDidSelectString=[tableDidSelectString stringByAppendingString:imagedir];
        tableDidSelectString=[tableDidSelectString stringByAppendingString:actual];
        //NSLog(@"%@",tableDidSelectString);
    }
   else if ([tableDidSelectString hasSuffix:@".mp3"]) {
        
        NSString *imagedir=@"http://www.anshtech.org/QRcode/voice/actual_voice/";
        NSString *actual=tableDidSelectString;
        tableDidSelectString=@"";
        tableDidSelectString=[tableDidSelectString stringByAppendingString:imagedir];
        tableDidSelectString=[tableDidSelectString stringByAppendingString:actual];
        //NSLog(@"%@",tableDidSelectString);
    }
    if ([tableDidSelectString hasPrefix:@"http://"]||[tableDidSelectString hasPrefix:@"HTTP://"]) {
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        obj=[[ResultQRViewController alloc]initWithNibName:@"ResultQRViewController" bundle:nil];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
       obj=[[ResultQRViewController alloc]initWithNibName:@"ResultQRViewController_iPhone4" bundle:nil];
        }
        else{
           obj=[[ResultQRViewController alloc]initWithNibName:@"ResultQRViewController_iPhone3.5" bundle:nil];
            
        }
    }
    obj.resultUrlString=tableDidSelectString;
    [self.navigationController pushViewController:obj animated:YES];
    }
    else{

        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"QR-Result" message:tableDidSelectString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)makeRequestForDeleteQRCode{
 
    DeleteQRCode *delete=[[DeleteQRCode alloc]init];
    delete.DeleteQRCodeDelegate=self;
     [delete makeRequestForDeleteQRCodeByIMEI:replaceUuidString deleteid:selectedButtonId app_name:@"Eurl"];
    [tableView1 reloadData];
}
-(void)successJsonParsingForDeleteRecord:(NSDictionary *)responseDict{
   // NSLog(@"%@",responseDict);
    [tableView1 reloadData];
    
}
-(void)failureJsonParsingForDeleteRecord:(NSDictionary *)deleteDict{
    
    //NSLog(@"%@",deleteDict);
    [[deleteDict objectForKey:@"result"]valueForKey:@"success"];
    [tableView1 reloadData];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
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
-(void)actionForDeleteTableCell:(id)sender{

    UIButton *selectedButton = (UIButton *)sender;
    idno=selectedButton.tag;
    NSLog(@"%lu",(unsigned long)idno);
    selectedButtonId=[QRid objectAtIndex:idno];
    NSLog(@"%@",selectedButtonId);
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure want delete  selected QR-Code item?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag=123;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1&&alertView.tag==123) {
       
        [self makeRequestForDeleteQRCode];
        [typeArray removeObjectAtIndex:idno];
        [timeArray removeObjectAtIndex:idno];
        [resultQRArray removeObjectAtIndex:idno];
        [QRid removeObjectAtIndex:idno];
        [tableView1 reloadData];
        
    }
    if (buttonIndex==0&&alertView.tag==12345) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)makeRequestForRetrieveQRCodes{
    indicator.hidden=NO;
    Retrieve *obj=[[Retrieve alloc]init];
    obj.RetrieveDelegate=self;
    [obj makeRequestForRetrieveQRResultBy:replaceUuidString app_name:@"Eurl"];
}
-(void)successJsonParsingForRetrieveRecord:(NSDictionary *)responseDict
{
    NSLog(@"retrieveDict:%@",responseDict);
    for (int i=0; i<[[responseDict valueForKey:@"Response"] count]; i++) {
        [QRImageArray addObject:  [[[responseDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"QR"]];
        [typeArray addObject:[[[responseDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"Type"]];
        NSString *time=[[[responseDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"Time"];
        NSString *finaltime=[time substringToIndex:10];
        [timeArray addObject:finaltime];
        [resultQRArray addObject: [[[responseDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"original"]];
        [QRid addObject:[[[responseDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"id"]];
        indicator.hidden=YES;
    }
    [tableView1 reloadData];
    }
     
-(void)failureJsonParsingForRetrieveRecord:(NSDictionary *)retrieveDict{
    NSString *failure=[retrieveDict valueForKey:@"result"];
    //NSString *failreStatus=[retrieveDict valueForKey:@"type"];
    if ([failure isEqualToString:@"failure"]) {
        indicator.hidden=YES;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"QR-Result" message:@"Data is not found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag=12345;
        [alert show];
    }
    NSLog(@"retrieveDict:%@",retrieveDict);
    for (int i=0; i<[[retrieveDict valueForKey:@"Response"] count]; i++) {
        NSString *deleteQR=[[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"QR"];
        NSString *deleteid=[[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"id"];
        if ([deleteQR isEqualToString:@"null"]) {
            DeleteQRCode *delete=[[DeleteQRCode alloc]init];
            delete.DeleteQRCodeDelegate=self;
            [delete makeRequestForDeleteQRCodeByIMEI:replaceUuidString deleteid:deleteid app_name:@"Eurl"];
            [tableView1 reloadData];
        }
        else{
        [QRImageArray addObject:  [[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"QR"]];
        
        [typeArray addObject:[[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"Type"]];
        NSString *time=[[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"Time"];
        NSString *finaltime=[time substringToIndex:10];
        [timeArray addObject:finaltime];
       [resultQRArray addObject: [[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"original"]];
        [QRid addObject:[[[retrieveDict objectForKey:@"Response"]objectAtIndex:i]valueForKey:@"id"]];
            NSLog(@"%@",QRid);
        indicator.hidden=YES;
           }
    }
    [tableView1 reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return  180;
    }
    else
    {
       
    return 80;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
