//
//  GenerateViewController.m
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 02/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "GenerateViewController.h"
@interface GenerateViewController ()
{
    NSArray *dirpath;
    NSString *docdir;
    NSString *soundFilePath;
    NSArray *segmentArray;
    UIImageView *backgroundImage;
    NSURL *soundFileURL;
    NSString *pathString;
    NSString *Stringid;
}
@end
@implementation GenerateViewController
@synthesize imageForImageQR;
@synthesize imagePathString;
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
    //indicator.hidden=YES;
    [super viewDidLoad];
   
    indicator.hidden=YES;
    [self makeRequestForAdmobs];
    pathString=[[NSString alloc]init];
    Stringid=[[NSString alloc]init];
    UIDevice *myDevice=[UIDevice currentDevice];
    NSString *UUID = [[myDevice identifierForVendor] UUIDString];
    replaceUuidString=[UUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    
    
    // Do any additional setup after loading the view from its nib.
    self.title=@"QR-CODE Generator";
    dateAndTimeString=[[NSString alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyyHH:mm:ss";
    NSDate *currentDate = [NSDate date];
    time1 =[dateFormatter stringFromDate:currentDate];
    datestring=[NSString stringWithFormat:@"%@",time1];
  
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPad"]];
        viewForText=[[UIView alloc]initWithFrame:CGRectMake(0,98,768,922)];
        viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0,97,768,921)];
        viewForVoice=[[UIView alloc]initWithFrame:CGRectMake(0,97,768,921)];
        
        
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background_iPhone"]];
            viewForText=[[UIView alloc]initWithFrame:CGRectMake(0,93,320,475)];
            viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0,93,320,475)];
            viewForVoice=[[UIView alloc]initWithFrame:CGRectMake(0,93,320,475)];

            
        }
        else{
            self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
            viewForText=[[UIView alloc]initWithFrame:CGRectMake(0,95,320,386)];
            viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0,95,320,386)];
            viewForVoice=[[UIView alloc]initWithFrame:CGRectMake(0,95,320,386)];
            
            
        }
    }
    self.title=@"QR-CODE Generator";
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        generateTextView=[[UITextView alloc]initWithFrame:CGRectMake(180, 120,410, 240)];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            
            generateTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 30, 280,70)];
        }
        else{
            generateTextView=[[UITextView alloc]initWithFrame:CGRectMake(20,20, 280,60)];
        }
    }
    generateTextView.delegate=self;
    generateTextView.returnKeyType=UIReturnKeyDone;
    generateTextView.hidden=NO;
    generateTextView.autocorrectionType=UITextAutocorrectionTypeNo;
    [generateTextView setScrollEnabled:YES];
    [generateTextView.layer setMasksToBounds:YES];
    [generateTextView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [generateTextView.layer setBorderWidth:1.0f];
    generateTextView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    generateTextView.layer.shadowOpacity = 1.0f;
    generateTextView.layer.shadowRadius = 5.0f;
    if ([generateTextView.text length]!=0) {
        [segmentForGenerateQR setEnabled:NO forSegmentAtIndex:1];
        [segmentForGenerateQR setEnabled:NO forSegmentAtIndex:2];
    }
    else{
        segmentForGenerateQR.userInteractionEnabled=YES;
    }
    [generateTextView.layer setShadowOffset:CGSizeMake(2, 2)];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        [generateTextView setFont:[UIFont fontWithName:@"ArialMT" size:20]];
    }
    else{
        [generateTextView setFont:[UIFont fontWithName:@"ArialMT" size:14]];
    }
    [viewForText addSubview:generateTextView];
    generateTextView.hidden=NO;
    viewForVoice.hidden=YES;
    viewForImage.hidden=YES;
    generateTextView.hidden=NO;
    [self.view addSubview:viewForText];
    //[self.view addSubview:viewForImage];
    generate=[UIButton buttonWithType:UIButtonTypeCustom];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        generate.frame=CGRectMake(180, 390, 410, 45);
        [generate setImage:[UIImage imageNamed:@"generateText_iPad"] forState:UIControlStateNormal];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            generate.frame=CGRectMake(20, 120, 280, 45);
            [generate setImage:[UIImage imageNamed:@"generateText_iPhone"] forState:UIControlStateNormal];
        }
        else{
            generate.frame=CGRectMake(20, 100, 280, 45);
            [generate setImage:[UIImage imageNamed:@"generateText_iPhone"] forState:UIControlStateNormal];
        }
    }
    
    //        [generate setImage:[UIImage imageNamed:@"generate.png"] forState:UIControlStateNormal];
    [generate addTarget:self action:@selector(actionForGenerateQRimage:) forControlEvents:UIControlEventTouchUpInside];
    generate.hidden=NO;
    [viewForText addSubview:generate];
    
    textSaveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        textSaveButton.frame=CGRectMake(180,730, 410, 45);
        [textSaveButton setImage:[UIImage imageNamed:@"Save_iPad"] forState:UIControlStateNormal];
    }
    else{
        if ([UIScreen mainScreen].bounds.size.height==568) {
            textSaveButton.frame=CGRectMake(20, 370, 280, 45);
            [textSaveButton setImage:[UIImage imageNamed:@"Save_iPhone"] forState:UIControlStateNormal];
        }
        else{
            textSaveButton.frame=CGRectMake(20, 280, 280, 45);
            [textSaveButton setImage:[UIImage imageNamed:@"Save_iPhone"] forState:UIControlStateNormal];
        }
    }
    [textSaveButton addTarget:self action:@selector(actionForSaveTextQRimage:) forControlEvents:UIControlEventTouchUpInside];
    textSaveButton.hidden=YES;
    [viewForText addSubview:textSaveButton];
    //  [self.view addSubview:viewForText];
    [self gesture];
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
-(IBAction)segment:(id)sender
{
    if (segmentForGenerateQR.selectedSegmentIndex==0) {
        [self.view addSubview:viewForText];
        generateTextView.text=@"";
        viewForText.hidden=NO;
        viewForImage.hidden=YES;
        viewForVoice.hidden=YES;
        recordButton.hidden=YES;
        generateButtonForRecordQR.hidden=YES;
        generateButtonForImage.userInteractionEnabled=NO;//image
        imageButton.userInteractionEnabled=NO;//image
        recordButton.userInteractionEnabled=NO;//voice
        generateButtonForRecordQR.userInteractionEnabled=NO;//voice
        voiceSaveButton.userInteractionEnabled=NO;//voice
        imageSaveButton.userInteractionEnabled=NO;//image
        stopButton.userInteractionEnabled=NO;//voice
        playButton.userInteractionEnabled=NO;//voice
    }
    if (segmentForGenerateQR.selectedSegmentIndex==1) {
        [self.view addSubview:viewForImage];
        recordButton.userInteractionEnabled=NO;//voice
        generateButtonForRecordQR.userInteractionEnabled=NO;//voice
        stopButton.userInteractionEnabled=NO;//voice
        playButton.userInteractionEnabled=NO;//voice
        recordButton.hidden=YES;
        imageForImageQR.image=nil;
        indicator.hidden=YES;
        viewForImage.hidden=NO;
        viewForVoice.hidden=YES;
        viewForText.hidden=YES;
        voiceSaveButton.userInteractionEnabled=NO;//voice
        imageFrame=[[UIImageView alloc]init] ;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            imageFrame.frame=CGRectMake(256, 50, 250, 250);
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568) {
                imageFrame.frame=CGRectMake(85, 20, 150, 130);
                
            }
            else{
                imageFrame.frame=CGRectMake(20, 10, 130, 110);
            }
        }
        imageFrame.layer.borderWidth=1.50f;
        imageFrame.layer.borderColor=[[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor];
        imageFrame.layer.cornerRadius=5.0f;
        [viewForImage addSubview:imageFrame];
        generateButtonForImage=[UIButton buttonWithType:UIButtonTypeCustom];
        imageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [generateButtonForImage addTarget:self action:@selector(actionForGenerateQRimage123) forControlEvents:UIControlEventTouchUpInside];
        [imageButton addTarget:self action:@selector(actionForImageQR:) forControlEvents:UIControlEventTouchUpInside];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            generateButtonForImage.frame=CGRectMake(390, 350, 200, 35);
            imageButton.frame=CGRectMake(160, 350, 200, 35);
            imageForImageQR=[[UIImageView alloc]initWithFrame:CGRectMake(256, 50, 250, 250)];
            
            [imageButton setImage:[UIImage imageNamed:@"ChooseImage_iPad"] forState:UIControlStateNormal];
            [generateButtonForImage setImage:[UIImage imageNamed:@"GenerateSmall_iPad"] forState:UIControlStateNormal];
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568) {
                generateButtonForImage.frame=CGRectMake(180, 170, 120, 35);
                imageButton.frame=CGRectMake(20, 170, 120, 35);
                
                [imageButton setImage:[UIImage imageNamed:@"ChooseImage_iPhone"] forState:UIControlStateNormal];
                
                imageForImageQR=[[UIImageView alloc]initWithFrame:CGRectMake(85, 20, 150, 130)];
                
                
            }
            else{
                
                generateButtonForImage.frame=CGRectMake(170,80, 120, 35);
                [imageButton setImage:[UIImage imageNamed:@"ChooseImage_iPhone"] forState:UIControlStateNormal];
                
                imageButton.frame=CGRectMake(170,15, 120, 35);
                imageForImageQR=[[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 130, 110)];
                
                
                
            }
            [generateButtonForImage setImage:[UIImage imageNamed:@"GenerateSmall_iPhone"] forState:UIControlStateNormal];
            [imageButton setImage:[UIImage imageNamed:@"ChooseImage_iPhone"] forState:UIControlStateNormal];
            
        }
        
        [viewForImage addSubview:generateButtonForImage];
        [viewForImage addSubview:imageButton];
        imageForImageQR.layer.borderWidth=1.50f;
        imageForImageQR.layer.borderColor=[[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor];
        imageForImageQR.layer.cornerRadius=5.0f;
        generate.userInteractionEnabled=YES;
        [viewForImage addSubview:imageForImageQR];
        
        
    }
    if (segmentForGenerateQR.selectedSegmentIndex==2) {
        [self.view addSubview:viewForVoice];
        [indicator stopAnimating];
        //textSaveButton.userInteractionEnabled=NO;
        generateButtonForImage.userInteractionEnabled=NO;//image
        imageButton.userInteractionEnabled=NO;//image
        imageButton.hidden=YES;//image
        imageSaveButton.userInteractionEnabled=NO;//image
        imageSaveButton.hidden=YES;//image
        viewForText.hidden=YES;
        viewForImage.hidden=YES;
        viewForVoice.hidden=NO;
        recordImage=[[UIImageView alloc]init];
        playImage=[[UIImageView alloc]init];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            recordImage.frame=CGRectMake(260, 300, 250,250);
            [recordImage setImage:[UIImage imageNamed:@"player_iPad"]];
            recordImage.hidden=YES;
            [viewForVoice addSubview:recordImage];
        }else{
            recordImage.frame=CGRectMake(85, 120, 150,150);
            [recordImage setImage:[UIImage imageNamed:@"play"]];
            recordImage.hidden=YES;
            [viewForVoice addSubview:recordImage];
        }
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            playImage.frame=CGRectMake(260, 300, 250,250);
            [playImage setImage:[UIImage imageNamed:@"playing_iPad"]];
            playImage.hidden=YES;
            [viewForVoice addSubview:playImage];
        }else{
            playImage.frame=CGRectMake(85,140,150,150);
            [playImage setImage:[UIImage imageNamed:@"playing"]];
            playImage.hidden=YES;
            [viewForVoice addSubview:playImage];
        }
        recordButton=[UIButton buttonWithType:UIButtonTypeCustom];

        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            recordButton.frame=CGRectMake(180, 180, 410, 45);
            [recordButton setImage:[UIImage imageNamed:@"Record_iPad"] forState:UIControlStateNormal];
        }
        else{
            recordButton.frame=CGRectMake(20, 30, 280, 45);
            [recordButton setImage:[UIImage imageNamed:@"Record_iPhone"] forState:UIControlStateNormal];
        }
        
        [recordButton addTarget:self action:@selector(actionForAudioRecord:) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:recordButton];
        voiceSaveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            voiceSaveButton.frame=CGRectMake(180, 700, 410, 45);
            [voiceSaveButton setImage:[UIImage imageNamed:@"Save_iPad"] forState:UIControlStateNormal];
            
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                voiceSaveButton.frame=CGRectMake(20, 360, 280, 45);
                
            }
            else{
                voiceSaveButton.frame=CGRectMake(20,280, 280, 45);
            }
            [voiceSaveButton setImage:[UIImage imageNamed:@"Save_iPhone"] forState:UIControlStateNormal];
        }
        
        [voiceSaveButton addTarget:self action:@selector(actionForSaveVoiceQRimage:) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:voiceSaveButton];
        voiceSaveButton.hidden=YES;
        
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        soundFilePath = [docsDir
                         stringByAppendingPathComponent:@"tmp.m4a"];
        NSLog(@"%@",soundFilePath);
        
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
        
    }
}
-(void)actionForImageQR:(id)sender{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
    UIActionSheet *actionForImage=[[UIActionSheet alloc]initWithTitle:@"Choose Image By" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera",@"PhotoLibrary",@"Cancel" ,nil];
    actionForImage.tag=55;
    [actionForImage showInView:self.view];
    }
    else{
        UIActionSheet *actionForImage=[[UIActionSheet alloc]initWithTitle:@"Choose Image By" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"camera",@"PhotoLibrary",nil];
        actionForImage.tag=66;
        [actionForImage showInView:self.view];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(actionSheet.tag==55)) {
        imagePick=[[UIImagePickerController alloc]init];
        imagePick.delegate=self;
        [imagePick setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePick animated:YES completion:nil];
    }
    else if((buttonIndex==1)&&(actionSheet.tag==55)){
        
        imagePick=[[UIImagePickerController alloc]init];
        [imagePick setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        imagePick.delegate=self;
        [self presentViewController:imagePick animated:YES completion:nil];
        
    }
    else if((buttonIndex==0)&&(actionSheet.tag==66)){
        
        imagePick=[[UIImagePickerController alloc]init];
        imagePick.delegate=self;
        [imagePick setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePick animated:YES completion:nil];
        
    }
    else if((buttonIndex==1)&&(actionSheet.tag==66)){
        
        imagePick=[[UIImagePickerController alloc]init];
        [imagePick setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        imagePick.delegate=self;
        [self presentViewController:imagePick animated:YES completion:nil];
        
    }
    imageForImageQR.hidden=NO;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    imageForImageQR.image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    
    NSURL* localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
   
    imageStringUrl=[localUrl absoluteString];
    [imagePick dismissViewControllerAnimated:YES completion:nil];
}

-(void)actionForAudioRecord:(id)sender{
    UIButton *tappedButton=(UIButton*)sender;
    if (([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Record_iPad"]])||([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Record_iPhone"]])){
        [audioRecord record];
        segmentForGenerateQR.userInteractionEnabled=NO;
        recordImage.hidden=NO;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
            [sender setImage:[UIImage imageNamed:@"Stop_iPad"] forState:UIControlStateNormal];
        }
        else{
            [sender setImage:[UIImage imageNamed:@"Stop_iPhone"] forState:UIControlStateNormal];
        }
    }
    else  if (([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPad"]])||([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPhone"]])){
        [audioRecord stop];
        recordImage.hidden=YES;
        tappedButton.userInteractionEnabled=YES;
        recordButton.hidden=YES;
        NSError *err;
        player=[[AVAudioPlayer alloc]initWithContentsOfURL:audioRecord.url error:&err];
        
        if (err) {
            NSLog(@"%@",[err localizedDescription]);
        }
        else{
            player.delegate=self;
            
            [player prepareToPlay];
        }
        //stop button
        stopButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            stopButton.frame=CGRectMake(180, 180, 410, 45);
            [stopButton setImage:[UIImage imageNamed:@"Stop_iPad"] forState:UIControlStateNormal];
        }
        else{
            stopButton.frame=CGRectMake(20, 30, 280, 45);
            [stopButton setImage:[UIImage imageNamed:@"Stop_iPhone"] forState:UIControlStateNormal];
        }
        
        [stopButton addTarget:self action:@selector(stopwhileplaying) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:stopButton];
        
        
        CGRect frame;
        playButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            frame=CGRectMake(180, 245,200,35);
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                frame=CGRectMake(20, 85,120,35);
                
            }
            else{
                frame=CGRectMake(20, 85,120,35);
            }
            
        }
        playButton.frame=frame;
        float timeInt=player.duration;
        [NSTimer scheduledTimerWithTimeInterval:timeInt target:self selector:@selector(actionForHideImage) userInfo:nil repeats:YES];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            UIImage *buttonImage = [UIImage imageNamed:@"playsmall_iPad"];
            [playButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
            
           
        }
        else{
            
            UIImage *buttonImage = [UIImage imageNamed:@"playsmall_iPhone"];
            [playButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
            
        }
        
        [playButton addTarget:self action:@selector(actionForPlayRecorded:) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:playButton];
        generateButtonForRecordQR=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            generateButtonForRecordQR.frame=CGRectMake(390,245, 200,35);
            [generateButtonForRecordQR setImage:[UIImage imageNamed:@"GenerateSmall_iPad"] forState:UIControlStateNormal];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                generateButtonForRecordQR.frame=CGRectMake(180,85,120,35);
            }
            
            else{
                generateButtonForRecordQR.frame=CGRectMake(180,85,120,35);
                
            }
            generateButtonForRecordQR.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"GenerateSmall_iPhone"]];
        }
        [generateButtonForRecordQR addTarget:self action:@selector(actionForGenerateVoiceQRcode) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:generateButtonForRecordQR];
        generateButtonForRecordQR.userInteractionEnabled=YES;
    }
}
-(void)actionForPlayRecorded:(id)sender{
    [player play];
    playImage.hidden=NO;
    
  /* UIButton *tappedButton=(UIButton*)sender;
    
    
    if (([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPad"]])||([tappedButton.currentImage isEqual:[UIImage imageNamed:@"Stop_iPhone"]])){
        [audioRecord stop];
    }
    */
    
}
-(void)actionForHideImage{
    playImage.hidden=YES;
}
-(void)stopwhileplaying{
    [player stop];
    playImage.hidden=YES;
}
-(void)actionForGenerateVoiceQRcode{
    //[self makeRequestForInsertOriginalVoice];
        [player stop];
   
//    _spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    _spinner.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
//    [_spinner setCenter:CGPointMake(320/2.0, 360/2)]; // (mid of screen) I do this because I'm in landscape mode
//    [viewForVoice addSubview:_spinner];
//    [_spinner startAnimating];
//    if ([_spinner isHidden]==NO) {
//       // [self makeRequestForInsertOriginalVoice];
//        alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure want to generate QR-code for this voice" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
//        alert.tag=2222;
//        [alert show];
//    }

   // [_spinner startAnimating];
    
  //  [self makeRequestForInsertOriginalVoice];
    
    alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want generate QR-code for this voice" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
           alert.tag=2222;
        [alert show];
    
}

-(void)actionForSaveTextQRimage:(id)sender{
    
    [Base64 initialize];
    CGRect rect = CGRectMake(0,0,35,35);
    UIGraphicsBeginImageContext( rect.size );
    [imageView.image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    
    textPathString=[NSMutableString stringWithFormat:@"%@",[Base64 encode:imageData]];
    
    InsertTextRequestClass *text=[[InsertTextRequestClass alloc] init];
    text.InsertTextDelegate=self;
    [text makeRequestForInsertTextBy:generateTextView.text app_name:@"Eurl" date_time:datestring date_time:datestring type:@"text" time1:datestring IMEI:replaceUuidString uploadedfile:textPathString];
    imageView.hidden=YES;
    textSaveButton.hidden=YES;
    UIAlertView *saveAlert=[[UIAlertView alloc]initWithTitle:@"Result" message:@"QR-Code saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    saveAlert.tag=21;
    [saveAlert show];
    generateTextView.text=@"";
    generate.userInteractionEnabled=YES;
    generateTextView.userInteractionEnabled=YES;
    segmentForGenerateQR.userInteractionEnabled=YES;
}

-(void)successJSONParsingTextResult:(NSMutableDictionary *)responseDictionary
{
    NSLog(@"%@",responseDictionary);
    
}
-(void)failureJSONParsingTextResult
{
    
}

-(void)actionForSaveVoiceQRimage:(id)sender{
    
    [Base64 initialize];
    CGRect rect = CGRectMake(0,0,50,50);
    UIGraphicsBeginImageContext( rect.size );
    [img.image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    
    textPathString=[NSMutableString stringWithFormat:@"%@",[Base64 encode:imageData]];
    
    
    InsertQRImage *obj=[[InsertQRImage alloc]init];
    obj.InsertQRImageDelegate=self;
    [obj makeRequestForInsertQRCodeImageBy:Stringid app_name:@"Eurl" time1:datestring date_time:datestring type:@"voice" UDID:replaceUuidString uploadedfile:textPathString];
    
   
    alert=[[UIAlertView alloc]initWithTitle:@"Result" message:@"QR-Code saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //alert.tag=1;
    [alert show];
    
    img.hidden=YES;
    playButton.hidden=YES;
    recordButton.hidden=NO;
    stopButton.hidden=YES;
    generateButtonForRecordQR.hidden=YES;
    segmentForGenerateQR.userInteractionEnabled=YES;
    statusImage.hidden=YES;
    voiceSaveButton.hidden=YES;
    recordButton.userInteractionEnabled=YES;
    generateButtonForRecordQR.userInteractionEnabled=NO;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [recordButton setImage:[UIImage imageNamed:@"Record_iPad"] forState:UIControlStateNormal
         ];
    }
    else{
        [recordButton setImage:[UIImage imageNamed:@"Record_iPhone"] forState:UIControlStateNormal
         ];
    }
}
-(void)actionForGenerateQRimage:(id)sender{
    
    if ([generateTextView.text isEqualToString:@""]) {
        alert=[[UIAlertView alloc]initWithTitle:@"QR-CODE" message:@"Enter Text For QR-code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want generate QR-code for this text" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        alert.tag=1100;
        [alert show];
    }
}

-(void)gesture
{
    tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureText)];
    tapGesture.delegate=self;
    [self.view addGestureRecognizer:tapGesture];
}
-(void)gestureText
{
    [generateTextView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    
    if([text isEqualToString:@"\n"]) {
        [generateTextView resignFirstResponder];
        return NO;
    }
    
    
if([[textView text] length] - range.length + text.length > 1000){
    UIAlertView *RanngeAlert=[[UIAlertView alloc]initWithTitle:@"Warning !!!" message:@"The text range should be below 1000 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    RanngeAlert.tag=19;
    [RanngeAlert show];
        return NO;
    
    }
    
    return YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(alertView.tag==1100)) {
        generateTextView.text=@"";
    }
    
    if((buttonIndex==1)&&(alertView.tag==1100)){
        segmentForGenerateQR.userInteractionEnabled=NO;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            imageView=[[UIImageView alloc]initWithFrame:CGRectMake(250, 480, 270, 220)];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                imageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 190, 160, 160)];
            }
            else{
                imageView=[[UIImageView alloc]initWithFrame:CGRectMake(95, 160,120,100)];
            }
        }
        //This is for insert text through json parsing
        imageView.image=[UIImage QRCodeGenerator:generateTextView.text andLightColour:[UIColor blackColor] andDarkColour:[UIColor whiteColor] andQuietZone:1 andSize:200];
        textSaveButton.hidden=NO;
        [viewForText addSubview:imageView];
        generate.userInteractionEnabled=NO;
        generateTextView.userInteractionEnabled=NO;
    }
    if((buttonIndex==0)&&(alertView.tag==2222)){
        recordButton.userInteractionEnabled=YES;
        playButton.hidden=YES;
        generateButtonForRecordQR.hidden=YES;
        recordButton.hidden=NO;
        stopButton.hidden=YES;
        segmentForGenerateQR.userInteractionEnabled=YES;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            [recordButton setImage:[UIImage imageNamed:@"Record_iPad"] forState:UIControlStateNormal];
        }
        else{
            [recordButton setImage:[UIImage imageNamed:@"Record_iPhone"] forState:UIControlStateNormal];
        }
        
    }
    
    if((buttonIndex==1)&&(alertView.tag==2222)){
        
        statusImage=[[UIImageView alloc]init];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            statusImage.frame=CGRectMake(180, 200, 410, 50);
            statusImage.image=[UIImage imageNamed:@"generatediPad"];
            [viewForVoice addSubview:statusImage];
        }
        else{
             statusImage.frame=CGRectMake(20, 50, 280, 50);
            statusImage.image=[UIImage imageNamed:@"generatediPhone"];
            [viewForVoice addSubview:statusImage];
        }
        playButton.hidden=YES;
        playButton.userInteractionEnabled=NO;
        generateButtonForRecordQR.hidden=YES;
        generateButtonForRecordQR.userInteractionEnabled=NO;
        recordButton.hidden=YES;
        recordButton.userInteractionEnabled=NO;
        stopButton.hidden=YES;
        stopButton.userInteractionEnabled=NO;
       [self makeRequestForInsertOriginalVoice];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            img=[[UIImageView alloc]initWithFrame:CGRectMake(260,360, 250,250 )];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                img=[[UIImageView alloc]initWithFrame:CGRectMake(80, 150, 160, 160)];
            }
            else{
                img=[[UIImageView alloc]initWithFrame:CGRectMake(90, 125, 140, 130)];
            }
        }
        img.image=[UIImage QRCodeGenerator:pathString andLightColour:[UIColor whiteColor] andDarkColour:[UIColor blackColor] andQuietZone:1 andSize:200];
        [viewForVoice addSubview:img];
        voiceSaveButton.hidden=NO;
    }
    if ((buttonIndex==0)&&(alertView.tag==12)) {
        imageForImageQR.hidden=YES;
        imageForImageQR.image = nil;
    }
    if ((buttonIndex==1)&&(alertView.tag==12)) {
     
        generateButtonForImage.userInteractionEnabled=NO;
        imageButton.userInteractionEnabled=NO;
        segmentForGenerateQR.userInteractionEnabled=NO;
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            CGRect rect = CGRectMake(44,34,700,936);
            UIGraphicsBeginImageContext( rect.size );
            
            [imageForImageQR.image drawInRect:rect];
        }
        else{
            CGRect rect = CGRectMake(20,20,300,400);
            UIGraphicsBeginImageContext( rect.size );
            
            [imageForImageQR.image drawInRect:rect];
        }
        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(picture1);
        
        NSString *str;
        str=[NSString stringWithFormat:@"http://www.anshtech.org/QRcode/original_save.php?"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:str]];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        NSString *boundary = @"---------------------------Boundary_1_511262261_1369143433608";
        
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        //  parameter IMEI
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"IMEI\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[replaceUuidString dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter app_name
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"app_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Eurl" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter type
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"image" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //  parameter time1
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"time1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[datestring dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        //  parameter imageData
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"a.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        // close form
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [request setHTTPBody:body];
        
        NSError *error;
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil     error:&error];
        if (returnData)
        {
           
            NSString *json=[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            NSDictionary *JSONdict =
            [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding:NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
            
            NSString *linkValue = [[JSONdict valueForKey:@"link"]valueForKey:@"server_name"];
            
            NSString *dirvalues = [[JSONdict valueForKey:@"link"]valueForKey:@"dir_name"];
            
            
            NSString *OriginalValue = [JSONdict valueForKey:@"original"];
            
            
            Stringid=[JSONdict valueForKey:@"id"];
            pathString=[pathString stringByAppendingString:linkValue];
            pathString=[pathString stringByAppendingString:dirvalues];
            pathString=[pathString stringByAppendingString:OriginalValue];
            
        }
        else
        {
            NSLog(@"Error: %@", error);
            
        }
        
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            
            ImageforQRCode=[[UIImageView alloc]initWithFrame:CGRectMake(256, 440, 250, 250)];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                ImageforQRCode=[[UIImageView alloc]initWithFrame:CGRectMake(80, 225, 150, 130)];
            }
            else{
                ImageforQRCode=[[UIImageView alloc]initWithFrame:CGRectMake(95, 150, 120, 100)];
            }
        }
        //This is for insert text through json parsing
        ImageforQRCode.image=[UIImage QRCodeGenerator:pathString andLightColour:[UIColor blackColor] andDarkColour:[UIColor whiteColor] andQuietZone:1 andSize:200];
        
        [viewForImage addSubview:ImageforQRCode];
        
        imageSaveButton=[UIButton buttonWithType:UIButtonTypeCustom];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            imageSaveButton.frame=CGRectMake(180,730, 410, 45);
            [imageSaveButton setImage:[UIImage imageNamed:@"Save_iPad"] forState:UIControlStateNormal];
        }
        else{
            if ([UIScreen mainScreen].bounds.size.height==568) {
                imageSaveButton.frame=CGRectMake(20, 375, 280, 45);
                [imageSaveButton setImage:[UIImage imageNamed:@"Save_iPhone"] forState:UIControlStateNormal];
            }
            else{
                imageSaveButton.frame=CGRectMake(20, 275, 280, 45);
                [imageSaveButton setImage:[UIImage imageNamed:@"Save_iPhone"] forState:UIControlStateNormal];
            }
        }
        [imageSaveButton addTarget:self action:@selector(actionForSaveQRCodeForImage) forControlEvents:UIControlEventTouchUpInside];
        
        [viewForImage addSubview:imageSaveButton];
        
    }

}
-(void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated{
    
}
-(void)actionForGenerateQRimage123{
    if (imageForImageQR.image==NULL) {
        ImageforQRCode.hidden=YES;
        imageSaveButton.hidden=YES;
        UIAlertView *alertForChoose=[[UIAlertView alloc]initWithTitle:@"" message:@"choose Image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertForChoose show];
    }
    else{
        UIAlertView *alertForImageGenerate=[[UIAlertView alloc]initWithTitle:@"" message:@"Do you want generate QR-code for this image" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
        alertForImageGenerate.tag=12;
        [alertForImageGenerate show];
}
}
-(void)actionForSaveQRCodeForImage
{
//    InsertImageRequestClass *insertImage=[[InsertImageRequestClass alloc]init];
//    insertImage.InsertOriginalImageDelegate=self;
//    [insertImage makeRequestForInsertOriginalImageBy:replaceUuidString app_name:@"Eurl" type:@"image" time1:datestring uploadedfile:pathString];
//
    [Base64 initialize];
    CGRect rect = CGRectMake(0,0,35,35);
    UIGraphicsBeginImageContext( rect.size );
    [ImageforQRCode.image drawInRect:rect];
    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(picture1);
    
    textPathString=[NSMutableString stringWithFormat:@"%@",[Base64 encode:imageData]];
    
    
    InsertQRImage *obj=[[InsertQRImage alloc]init];
    obj.InsertQRImageDelegate=self;
    [obj makeRequestForInsertQRCodeImageBy:Stringid app_name:@"Eurl" time1:datestring date_time:datestring type:@"image" UDID:replaceUuidString uploadedfile:textPathString];
    
    
    UIAlertView *alertForImage=[[UIAlertView alloc]initWithTitle:@"" message:@"QR-Code saved successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    imageFrame.hidden=NO;
    imageSaveButton.hidden=YES;
    imageForImageQR.hidden=YES;
    ImageforQRCode.hidden=YES;
    imageForImageQR.image=NULL;
    generateButtonForImage.userInteractionEnabled=YES;
    imageButton.userInteractionEnabled=YES;
    segmentForGenerateQR.userInteractionEnabled=YES;
    imageForImageQR.image=nil;
    ImageforQRCode.image=nil;
    [alertForImage show];
}
-(void)successJsonParsingForInsertingRecord:(NSDictionary *)responseDict{
    
}
-(void)failureJsonParsingForInsertingOriginalImageRecord{
    
}
-(void)successJsonParsingForInsertingOriginalImageRecord: (NSDictionary *)responseDict{
    NSLog(@"%@",responseDict);
}

-(void)makeRequestForInsertOriginalVoice{
    NSData *soundData=[NSData dataWithContentsOfURL:soundFileURL];
    
    NSString *str;
    str=[NSString stringWithFormat:@"http://www.anshtech.org/QRcode/original_save.php?"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:str]];
    [request setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------Boundary_1_511262261_1369143433608";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //  parameter IMEI
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"IMEI\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[replaceUuidString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter app_name
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"app_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Eurl" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter type
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"voice" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //  parameter time1
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"time1\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[datestring dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //  parameter imageData
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"abc.mp3\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:soundData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPBody:body];
    
    NSError *error;
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil
                                                           error:&error];
    if (returnData)
    {
        NSString *json=[[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSDictionary *JSONdict =
        [NSJSONSerialization JSONObjectWithData: [json dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &error];
        NSString *linkValue = [[JSONdict valueForKey:@"link"]valueForKey:@"server_name"];
    
        NSString *dirvalues = [[JSONdict valueForKey:@"link"]valueForKey:@"dir_name"];
        
        
        NSString *OriginalValue = [JSONdict valueForKey:@"original"];

        Stringid=[JSONdict valueForKey:@"id"];
        pathString=[pathString stringByAppendingString:linkValue];
        pathString=[pathString stringByAppendingString:dirvalues];
        pathString=[pathString stringByAppendingString:OriginalValue];
        NSLog(@"%@",JSONdict);
    }
    else
    {
        NSLog(@"Error: %@", error);

    }
}
-(void)successJsonParsingForInsertingImageRecord: (NSDictionary *)responseDict{
    NSLog(@"%@",responseDict);
}
-(void)failureJsonParsingForInsertingImageRecord{
    
}
-(void)successJsonParsingForInsertingVoiceRecord:(NSDictionary *)responseDict{
    
}
-(void)failureJsonParsingForInsertingVoiceRecord{
    
}
-(void)successJsonParsingForDeleteRecord:(NSDictionary *)responseDict{
    NSLog(@"%@",responseDict);
}
-(void)failureJsonParsingForDeleteRecord:(NSDictionary *)deleteDict{
    NSLog(@"%@",deleteDict);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
