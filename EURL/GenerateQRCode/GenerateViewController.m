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
}
@end

@implementation GenerateViewController

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
    self.title=@"QR-CODE Generator";
    viewForText=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    viewForVoice=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    self.title=@"QR-CODE Generator";
    viewForText=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    viewForImage=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    viewForVoice=[[UIView alloc]initWithFrame:CGRectMake(0, 94, 320, 386)];
    //[self.view addSubview:viewForText];
    viewForText.hidden=NO;
    viewForVoice.hidden=YES;
    viewForImage.hidden=YES;
    textView.hidden=NO;
    [self.view addSubview:viewForText];
    
    
    textView=[[UITextView alloc]initWithFrame:CGRectMake(50, 60, 220, 60)];
    //[textView setFont:[UIFont fontWithName:@"ArialMT" size:20]];
    textView.delegate=self;
    textView.returnKeyType=UIReturnKeyDone;
    textView.hidden=NO;
    //[textView setEditable:NO];
    [textView setScrollEnabled:YES];
    [textView.layer setMasksToBounds:YES];
    [textView.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [textView.layer setBorderWidth:1.0f];
    textView.layer.shadowColor = [[UIColor lightGrayColor]CGColor];
    textView.layer.shadowOpacity = 1.0f;
    textView.layer.shadowRadius = 5.0f;
    [textView.layer setShadowOffset:CGSizeMake(2, 2)];
    [viewForText addSubview:textView];
    
    generate=[UIButton buttonWithType:UIButtonTypeCustom];
    generate.frame=CGRectMake(60, 130, 200, 30);
    [generate setImage:[UIImage imageNamed:@"generate.png"] forState:UIControlStateNormal];
    [generate addTarget:self action:@selector(actionForGenerateQRimage:) forControlEvents:UIControlEventTouchUpInside];
    generate.hidden=NO;
    [viewForText addSubview:generate];
    save=[UIButton buttonWithType:UIButtonTypeCustom];
    save.frame=CGRectMake(60, 360, 200, 30);
    [save setImage:[UIImage imageNamed:@"save.jpeg"] forState:UIControlStateNormal];
    [save addTarget:self action:@selector(actionForSaveTextQRimage:) forControlEvents:UIControlEventTouchUpInside];
    save.hidden=YES;
    [viewForText addSubview:save];
    [self gesture];
}


-(IBAction)segment:(id)sender
{
    if (segmentForGenerateQR.selectedSegmentIndex==0) {
        viewForText.hidden=NO;
        viewForImage.hidden=YES;
        viewForVoice.hidden=YES;
    }
    if (segmentForGenerateQR.selectedSegmentIndex==1) {
         [self.view addSubview:viewForImage];
        viewForImage.hidden=NO;
        viewForVoice.hidden=YES;
        viewForText.hidden=YES;
        }
    if (segmentForGenerateQR.selectedSegmentIndex==2) {
        [self.view addSubview:viewForVoice];
        viewForText.hidden=YES;
        viewForImage.hidden=YES;
        viewForVoice.hidden=NO;
        
        recordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        recordButton.frame=CGRectMake(80, 60, 120, 30);
        recordButton.backgroundColor=[UIColor greenColor];
        [recordButton setTitle:@"record" forState:UIControlStateNormal];
        [recordButton addTarget:self action:@selector(actionForAudioRecord:) forControlEvents:UIControlEventTouchUpInside];
        [viewForVoice addSubview:recordButton];
        save=[UIButton buttonWithType:UIButtonTypeCustom];
        save.frame=CGRectMake(60, 360, 200, 30);
        [save setImage:[UIImage imageNamed:@"save.jpeg"] forState:UIControlStateNormal];
        [save addTarget:self action:@selector(actionForSaveVoiceQRimage:) forControlEvents:UIControlEventTouchUpInside];
        dirpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docdir=dirpath[0];
        
        soundFilePath=[docdir stringByAppendingPathComponent:@"sound.caf"];
        NSLog(@"%@",soundFilePath);
        NSURL *soundFileUrl=[NSURL fileURLWithPath:soundFilePath];
        NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:AVAudioQualityMin],AVEncoderAudioQualityKey,[NSNumber numberWithInt:16],AVEncoderBitRateKey,[NSNumber numberWithInt: 2],AVNumberOfChannelsKey,[NSNumber numberWithFloat:44100.0],AVSampleRateKey,nil];
        NSError *err=nil;
        audioRecord=[[AVAudioRecorder alloc]initWithURL:soundFileUrl settings:recordSettings error:&err];
        if (err) {
            NSLog(@"%@",[err localizedDescription]);
        }
        else{
            [audioRecord prepareToRecord];
        }


}
}
-(void)actionForSaveTextQRimage:(id)sender{
    imageView.hidden=YES;
    save.hidden=YES;
    textView.text=@"";
    alert=[[UIAlertView alloc]initWithTitle:@"QRCode" message:@"saved sucessfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
-(void)actionForSaveVoiceQRimage:(id)sender{
    img.hidden=YES;
    save.hidden=YES;
    alert=[[UIAlertView alloc]initWithTitle:@"QRCode" message:@"saved sucessfully" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
}
-(void)actionForGenerateQRimage:(id)sender{
    if ([textView.text isEqualToString:@""]) {
        save.hidden=YES;
        alert=[[UIAlertView alloc]initWithTitle:@"QR-CODE" message:@"Enter Text For QR-code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else{
        
        imageView=[[UIImageView alloc]initWithFrame:CGRectMake(80, 180, 160, 160)];
        imageView.image=[UIImage QRCodeGenerator:textView.text andLightColour:[UIColor blackColor] andDarkColour:[UIColor whiteColor] andQuietZone:1 andSize:200];
        [viewForText addSubview:imageView];
        save.hidden=NO;
    }
   
}

-(void)actionForAudioRecord:(id)sender{
    UIButton *tappedButton=(UIButton*)sender;
    if ([tappedButton.currentTitle isEqualToString:@"record"]){
        
        [audioRecord record];
        [sender setTitle:@"stop" forState:UIControlStateNormal];
        
    }
    else  if ([tappedButton.currentTitle isEqualToString:@"stop"]){
        [audioRecord stop];
        [tappedButton setTitle:@"generate" forState:UIControlStateNormal];
        
    }
    else{
        img=[[UIImageView alloc]initWithFrame:CGRectMake(60, 150, 150, 150)];
        img.image=[UIImage QRCodeGenerator:soundFilePath andLightColour:[UIColor whiteColor] andDarkColour:[UIColor blackColor] andQuietZone:1 andSize:200];
        [tappedButton setTitle:@"record" forState:UIControlStateNormal];
        [viewForVoice addSubview:img];
        [viewForVoice addSubview:save];
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
    [textView resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
