//
//  MainViewController.m
//  EURL
//
//  Created by ShikshaPC-41 on 04/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "UIImageView+AFNetworking.h"
@interface MainViewController ()
{
    NSArray *namesArray;
    NSString *soundFilePath;
    UIButton *sendButton;
    NSArray *dirPaths;
    NSString *docsDir;
    UIButton *playButton;
    NSArray *titleArray;
    UIImageView *recordImage;
    UIImageView *playImage;
    NSURL *soundFileURL;
}
@end

@implementation MainViewController

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
    
    
    self.title=@"E-URL";
    //[self makeRequestForAdmobs];
//    namesArray=[[NSArray alloc] initWithObjects:@"Scan_iPad",@"GenerateQR_iPad",@"Generatesaved_iPad",@"FeedBack_iPad",@"About_iPad",@"Share_iPad", nil];
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
    namesArray=[[NSArray alloc] initWithObjects:@"ScanQR_iPad",@"GenerateQR_iPad",@"Generatesaved_iPad",@"Feedback_iPad",@"About_iPad",@"Share_iPad", nil];
        titleArray=[[NSArray alloc]initWithObjects:@"ScanQR",@"GenerateQR",@"Generate Saved",@"Feedback",@"About",@"Share", nil];
    }
    else{
    if ([UIScreen mainScreen].bounds.size.height==568) {
        namesArray=[[NSArray alloc] initWithObjects:@"Scan_iPhone",@"GenerateQR_iPhone",@"Generatesaved_iPhone",@"FeedBack_iPhone",@"About_iPhone",@"Share_iPhone", nil];
       titleArray=[[NSArray alloc]initWithObjects:@"ScanQR",@"GenerateQR",@"Generate Saved",@"Feedback",@"About",@"Share", nil];
    }
    else{
        namesArray=[[NSArray alloc] initWithObjects:@"Scan",@"Generate QR",@"Generate saved",@"FeedBack",@"About",@"Share", nil];
     titleArray=[[NSArray alloc]initWithObjects:@"ScanQR",@"GenerateQR",@"Generate Saved",@"Feedback",@"About",@"Share", nil];
    }
    }
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
    [collection registerNib:[UINib nibWithNibName:@"MainPage_ipad" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            [collection registerNib:[UINib nibWithNibName:@"MainPage" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        }
        else{
        [collection registerNib:[UINib nibWithNibName:@"MainPage_iphone" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        }
    }
    [self gesture];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return namesArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainPage *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.cornerRadius=8.0f;
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0 ] CGColor];
    cell.imageCell.image=[UIImage imageNamed:[namesArray objectAtIndex:indexPath.row]];
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==0) {
        if (![self connected]) {
            internetStatusAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet conection has been disabled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetStatusAlertView show];
        } else {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
              
            QRCodeScanningViewController *scanner=[[QRCodeScanningViewController alloc]initWithNibName:@"QRCodeScanning_ipad" bundle:nil];
            scanner.titleString=[titleArray objectAtIndex:indexPath.row];
                
                [self.navigationController pushViewController:scanner animated:YES];
        }
            else{
                if ([UIScreen mainScreen].bounds.size.height==568) {
                    QRCodeScanningViewController *scanner=[[QRCodeScanningViewController alloc]initWithNibName:@"QRCodeScanningViewController" bundle:nil];
                    scanner.titleString=[titleArray objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:scanner animated:YES];
                }
                else{
                QRCodeScanningViewController *scanner=[[QRCodeScanningViewController alloc]initWithNibName:@"QRCodeScanningViewController_iphone" bundle:nil];
                scanner.titleString=[titleArray objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:scanner animated:YES];
                }
            }
        }
    }
    else if (indexPath.item==1) {
        if (![self connected]) {

            internetStatusAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet conection has been disabled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetStatusAlertView show];
        } else {
    
            GenerateViewController *generateQR;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                generateQR=[[GenerateViewController alloc]initWithNibName:@"GenerateViewController_ipad" bundle:nil];
            }
            else{
                if ([UIScreen mainScreen].bounds.size.height==568) {
                    generateQR=[[GenerateViewController alloc]initWithNibName:@"GenerateViewController" bundle:nil];
                    
                }
                else{
           generateQR=[[GenerateViewController alloc]initWithNibName:@"GenerateViewController_iphone" bundle:nil];
            
                }
            
            }
         [self.navigationController pushViewController:generateQR animated:YES];
        }
    }
    else  if (indexPath.item==2) {
        if (![self connected]) {
          
            internetStatusAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet conection has been disabled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetStatusAlertView show];
        } else {
        
            QRCodeGeneratedViewController *generatedQR;
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                generatedQR=[[QRCodeGeneratedViewController alloc]initWithNibName:@"QRCodeGeneratedViewController_iPad" bundle:nil];
                           }
        
            else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
              
          generatedQR=[[QRCodeGeneratedViewController alloc]initWithNibName:@"QRCodeGeneratedViewController" bundle:nil];
              
            }
            else
            {
             generatedQR=[[QRCodeGeneratedViewController alloc]initWithNibName:@"GeneratedViewController_iphone" bundle:nil];
               
            }
            }
            generatedQR.titleString=[titleArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:generatedQR animated:YES];
        }
    }
    else   if (indexPath.item==3) {
        if (![self connected]) {
            
            internetStatusAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet conection has been disabled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetStatusAlertView show];
        } else {
            
            self.title=[titleArray objectAtIndex:indexPath.row];
            
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
                 sheet1=[[UIActionSheet alloc]initWithTitle:@"Send App Feedback" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"TextMessage",@"VoiceMessage",@"Cancel", nil];
            }
            else{
            sheet1=[[UIActionSheet alloc]initWithTitle:@"Send App Feedback" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"TextMessage",@"VoiceMessage", nil];
            }
            
            self.title=@"FeedBack";
            
            sheet1.tintColor=[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
            sheet1.tag=456;
            cancel=[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(actionForClose:)];
        
            self.navigationItem.rightBarButtonItem=cancel;
            self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:00.0/0.0 green:0.0/0.0 blue:00.0/0.0 alpha:0.0];
            [sheet1 showInView:self.view];
        }
    }
    else if(indexPath.item==4) {
        AboutEURLViewController *about;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           about=[[AboutEURLViewController alloc]initWithNibName:@"AboutViewController_ipad" bundle:nil];
          
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height) {
           about=[[AboutEURLViewController alloc]initWithNibName:@"AboutEURLViewController" bundle:nil];
               
            }
            else{
            
        about=[[AboutEURLViewController alloc]initWithNibName:@"AboutEURLViewController" bundle:nil];
       
    }
        }
        about.titleString=[titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:about animated:YES];
    }
    else if(indexPath.item==5){
        if (![self connected]) {
            
           
            internetStatusAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Internet conection has been disabled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [internetStatusAlertView show];
        } else {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
                UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"App Sharing \nBy which medium you want to share tha app" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle: nil otherButtonTitles:@"Email",@"Facebook",@"Twitter",@"Cancel", nil];
                action.tag=1234;
                [action showInView:self.view];
            }
            else{
            UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"App Sharing \nBy which medium you want to share tha app" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle: nil otherButtonTitles:@"Email",@"Sms",@"Facebook",@"Twitter", nil];
            action.tag=123;
         [action showInView:self.view];
            }
            
               }
       }
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{

    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(actionSheet.tag==321)) {
        
    }
     if((buttonIndex==1)&&(actionSheet.tag==321)){
        
    }
    if((buttonIndex==2)&&(actionSheet.tag==321)){
        
    }
    //ipad
     if ((buttonIndex==0) && (actionSheet.tag==1234) ) {
        mail=[[MFMailComposeViewController alloc]init];
         if ([MFMailComposeViewController canSendMail]) {
             [mail setMessageBody:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code" isHTML:YES];
             mail.mailComposeDelegate=self;
             [mail setSubject:@"EURL By Anshtech"];
             [self presentViewController:mail animated:YES completion:nil];
         }
         else{
             NSLog(@"hai");
             //             UIAlertView  *alert=[[UIAlertView alloc]initWithTitle:@"hai" message:@"mail" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
//             [alert show];
                     }
    }
  
     if ((buttonIndex==1)&&(actionSheet.tag==1234)) {
        
        facebook=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebook setInitialText:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code"];
        [self presentViewController:facebook animated:YES completion:nil];
        
    }
     if ((buttonIndex==2)&&(actionSheet.tag==1234)) {
        twitter=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code"];
        [self presentViewController:twitter animated:YES completion:nil];
    }

    //iphone
    if ((buttonIndex==0) && (actionSheet.tag==123) ) {
        mail=[[MFMailComposeViewController alloc]init];
        [mail setMessageBody:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code" isHTML:NO];
        mail.mailComposeDelegate=self;
        [mail setSubject:@"EURL By Anshtech"];
        [self presentViewController:mail animated:YES completion:nil];
    
    }
    
    if ((buttonIndex==1)&&(actionSheet.tag==123)) {
        sms=[[MFMessageComposeViewController alloc]init];
        sms.messageComposeDelegate=self;
        [sms setSubject:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code"];
        [self presentViewController:sms animated:YES completion:nil];
        
    }
    if ((buttonIndex==2)&&(actionSheet.tag==123)) {
        
        facebook=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebook setInitialText:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code"];
        [self presentViewController:facebook animated:YES completion:nil];
        
    }
   if ((buttonIndex==3)&&(actionSheet.tag==123)) {
        twitter=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:@"Nice App To Generate (Image/Audio/Plain Text) And Scan QR-Code"];
        [self presentViewController:twitter animated:YES completion:nil];
    }
    else if ((buttonIndex==0)&&(actionSheet.tag==456)) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1.50];
        [self.view setAlpha:1.0];
        [viewForFeedBack setAlpha:01.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView commitAnimations];

        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,768,1024)];
            viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPadDouble"]];
            self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:250.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
            
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,320, 568)];
                viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPhone"]];
                self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:250.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
            }
            else{
                viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,320, 480)];
                
                viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
                self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:250.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
            }
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            feedBackTextView=[[UITextView alloc]initWithFrame:CGRectMake(180, 150, 410, 250)];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                feedBackTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 120, 280, 90)];

            }
            else{
        feedBackTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 110, 280, 90)];
        }
        }
        feedBackTextView.delegate=self;
        UIButton *feedBackButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           feedBackButton.frame=CGRectMake(180, 460, 410, 45);
            feedBackButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"SendTextFeedback_iPad"]];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                feedBackButton.frame=CGRectMake(20, 220, 280, 45);
            }
            else{
        feedBackButton.frame=CGRectMake(20, 220, 280, 45);
                        }
             feedBackButton.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"sendTextFeedback_iPhone"]];
        }
    
        [feedBackButton setTitle:@"" forState:UIControlStateNormal];
        [feedBackButton addTarget:self action:@selector(actionForSendTextMessageFeedBack:) forControlEvents:UIControlEventTouchUpInside];
        feedBackTextView.returnKeyType=UIReturnKeyDone;
        [feedBackTextView setScrollEnabled:YES];
        feedBackTextView.autocorrectionType=UITextAutocorrectionTypeNo;
        [feedBackTextView.layer setMasksToBounds:YES];
        [feedBackTextView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
        [feedBackTextView.layer setBorderWidth:1.0f];
        feedBackTextView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
        feedBackTextView.layer.shadowOpacity = 1.0f;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            [feedBackTextView setFont:[UIFont fontWithName:@"ArialMT" size:20]];
        }
        else{
            [feedBackTextView setFont:[UIFont fontWithName:@"ArialMT" size:12]];
        }
        [viewForFeedBack addSubview:feedBackTextView];
        [viewForFeedBack addSubview:feedBackButton];
        [self.view addSubview:viewForFeedBack];
    }
    else  if ((buttonIndex==1)&&(actionSheet.tag==456)) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1.50];
        [self.view setAlpha:1.0];
        [viewForFeedBack setAlpha:0.0];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        
        [UIView commitAnimations];
        
        self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:250.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];

                dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        soundFilePath = [docsDir
                         stringByAppendingPathComponent:@"tmp.m4a"];
        
        soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt: kAudioFormatMPEG4AAC], AVFormatIDKey,
                                        [NSNumber numberWithFloat:16000.0], AVSampleRateKey,
                                        [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                        nil];
        
        NSError *error = nil;
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                            error:nil];
        
        audioRecord = [[AVAudioRecorder alloc]
                       initWithURL:soundFileURL
                       settings:recordSettings
                       error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            [audioRecord prepareToRecord];
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
UIImageView *backgroundImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 1024)];
            backgroundImg.image=[UIImage imageNamed:@"Background_iPad"];
            viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,768,1024)];
            [viewForFeedBack addSubview:backgroundImg];
            viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPad"]];
                  }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,320, 568)];
                viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPhone"]];
            }
            else{
        viewForFeedBack=[[UIView alloc]initWithFrame:CGRectMake(0,0,320, 480)];
            viewForFeedBack.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
            }
                    }
        recordImage=[[UIImageView alloc]init];
        playImage=[[UIImageView alloc]init];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            recordImage.frame=CGRectMake(260, 420, 250,250);
            [recordImage setImage:[UIImage imageNamed:@"player_iPad"]];
            recordImage.hidden=YES;
            [viewForFeedBack addSubview:recordImage];
        }else{
            recordImage.frame=CGRectMake(80,200, 150,150);
            [recordImage setImage:[UIImage imageNamed:@"play"]];
            recordImage.hidden=YES;
            [viewForFeedBack addSubview:recordImage];
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            playImage.frame=CGRectMake(260,440, 250,250);
            [playImage setImage:[UIImage imageNamed:@"playing_iPad"]];
            playImage.hidden=YES;
            [viewForFeedBack addSubview:playImage];
        }else{
            playImage.frame=CGRectMake(80, 250,150,150);
            [playImage setImage:[UIImage imageNamed:@"playing"]];
            playImage.hidden=YES;
            [viewForFeedBack addSubview:playImage];
        }

        UIButton *voiceRecord=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            voiceRecord.frame=CGRectMake(180,300,410,45);
        }
        else{
        voiceRecord.frame=CGRectMake(20, 130, 280, 45);
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            [voiceRecord setImage:[UIImage imageNamed:@"Record_iPad"] forState:UIControlStateNormal];
        }
        else{
        [voiceRecord setImage:[UIImage imageNamed:@"Record_iPhone"] forState:UIControlStateNormal];
        }
        [voiceRecord addTarget:self action:@selector(actionForRecord:) forControlEvents:UIControlEventTouchUpInside];
        [viewForFeedBack addSubview:voiceRecord];
                [self.view addSubview:viewForFeedBack];

    }
    else if((buttonIndex==2)&&(actionSheet.tag==456)){
        cancel.tintColor=[UIColor clearColor];
        self.title=@"E-URL";
    }
}
-(void)actionForClose:(id)sender
{
    viewForFeedBack.hidden=YES;
    [feedBackTextView resignFirstResponder];
    self.title=@"E-URL";

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.00];
    [viewForFeedBack setAlpha:0.0];
    [self.view setAlpha:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:viewForFeedBack cache:YES];
    [UIView commitAnimations];
    [cancel setEnabled:NO];
    cancel.tintColor=[UIColor whiteColor];
}

-(void)actionForSendTextMessageFeedBack:(id)sender{
    [feedBackTextView resignFirstResponder];
    if ([feedBackTextView.text isEqualToString:@""]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"FeedBack" message:@"please enter text" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        TextFeedback *textFeedBackObject=[[TextFeedback alloc]init];
        textFeedBackObject.sendTextFeedbackDelegate=self;
        [textFeedBackObject makeRequestFotSendTextFeedbackByText:@"EURL" TextMessage:feedBackTextView.text];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Thank you for sending text feedback" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert.tag=123;
    }
}
-(void)successJsonParsingForTextFeedback:(NSDictionary *)responseDict{
    NSLog(@"%@",responseDict);
}
-(void)failureJsonParsingForTextFeedback{
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ((buttonIndex==0)&&(alertView.tag==123)) {
        feedBackTextView.text=@"";
        cancel.tintColor=[UIColor clearColor];
         viewForFeedBack.hidden=YES;
         self.title=@"E-URL";
    }
    if ((buttonIndex==0)&&(alertView.tag==321)) {
        feedBackTextView.text=@"";
        cancel.tintColor=[UIColor clearColor];
        viewForFeedBack.hidden=YES;
         self.title=@"E-URL";
    }
}
-(void)actionForRecord:(id)sender{
    UIButton *tappedButton=(UIButton*)sender;
   if (([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Record_iPhone"]])||([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Record_iPad"]])){
       
        [audioRecord record];
       recordImage.hidden=NO;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
        [sender setImage:[UIImage imageNamed:@"Stop_iPad"] forState:UIControlStateNormal];
        }
        else{
            [sender setImage:[UIImage imageNamed:@"Stop_iPhone"] forState:UIControlStateNormal];
        }
    }
    else  if (([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPhone"]])||([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPad"]]))
    {
        [audioRecord stop];
        recordImage.hidden=YES;
        NSError *err;
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:audioRecord.url error:&err];
        
        if (err) {
            NSLog(@"%@",[err localizedDescription]);
        }
        else{
            player.delegate=self;
            
            [player prepareToPlay];
        }
        float timeInt=player.duration;
        [NSTimer scheduledTimerWithTimeInterval:timeInt target:self selector:@selector(actionForHideImage) userInfo:nil repeats:YES];
        playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            playButton.frame=CGRectMake(180, 360,200,35);
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
             playButton.frame=CGRectMake(20,200,120,35);
                
            }
            else{
            playButton.frame=CGRectMake(20, 200,120,35);
            }
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
           [playButton setImage:[UIImage imageNamed:@"playsmall_iPad"] forState:UIControlStateNormal];
        }
        else{
        [playButton setImage:[UIImage imageNamed:@"playsmall_iPhone"] forState:UIControlStateNormal];
        }
        [playButton addTarget:self action:@selector(actionForPlayRecorded) forControlEvents:UIControlEventTouchUpInside];
        [viewForFeedBack addSubview:playButton];
        sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            sendButton.frame=CGRectMake(400,360, 200,35);
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
               sendButton.frame=CGRectMake(180,200,120,35);
            }
            else{
                sendButton.frame=CGRectMake(180,200,120,35);
            }
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            [sendButton setImage:[UIImage imageNamed:@"sendImg_iPad"] forState:UIControlStateNormal];
        }
        else{
        [sendButton setImage:[UIImage imageNamed:@"sendImg_iPhone"] forState:UIControlStateNormal];
        }
        [sendButton addTarget:self action:@selector(actionForSendVoiceMessageFeedBack:) forControlEvents:UIControlEventTouchUpInside];
        [viewForFeedBack addSubview:sendButton];
    }
}
-(void)actionForPlayRecorded{
    [player play];
    playImage.hidden=NO;
}
-(void)actionForHideImage{
    playImage.hidden=YES;
}
-(void)actionForSendVoiceMessageFeedBack:(id)sender{
    NSData *voiceData=[NSData dataWithContentsOfURL:soundFileURL];
    //Create web Service
    NSString *urlString = @"http://www.anshtech.org/QRcode/UploadVoiceMessage.php?";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //upload recoreded voice
    
    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Uploadedfile\"; filename=\"abc.mp3\"\r\n"]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:voiceData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //upload the appName
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"AppName\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"EURL" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil     error:&error];
    if (returnData)
    {
        NSString *json=[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"Resp string: %@",json);
    }
    else
    {
        NSLog(@"Error: %@", error);
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Thank you for sending voice feedback" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    alert.tag=321;
    [player stop];
    playImage.hidden=YES;
}
-(void)successJsonParsingForVoiceFeedback:(NSDictionary *)responseDict{
    NSLog(@"%@",responseDict);
}
-(void)failureJsonParsingForVoiceFeedback{
    
}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
-(void)gesture
{
tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureText)];
    tapGesture.delegate=self;
    [viewForFeedBack addGestureRecognizer:tapGesture];
}
-(void)gestureText
{
[viewForFeedBack resignFirstResponder] ;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqual:@"\n"]) {
        [feedBackTextView resignFirstResponder];
        return NO;
    }
    return YES;
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
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    
    bannerView.adUnitID = @"ca-app-pub-2781774783774395/7752176263";//Call your id
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
