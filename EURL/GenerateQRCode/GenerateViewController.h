//
//  GenerateViewController.h
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 02/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+QRcodeMethod.h"
#import <AVFoundation/AVFoundation.h>
@interface GenerateViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>
{
   IBOutlet UISegmentedControl *segmentForGenerateQR;
    IBOutlet UIView *viewForText;
    IBOutlet UIView *viewForImage;
    IBOutlet UIView *viewForVoice;
   //text
    UITextView *textView;
    UIImageView *imageView;
    UITapGestureRecognizer *tapGesture;
    UIAlertView *alert;
    UIButton *generate;
    UIButton *save;
    //image
    
    
    
  //voice
    AVAudioRecorder *audioRecord;
    UIButton *recordButton;
    UIImageView *img;
}
-(IBAction)segment:(id)sender;
@end
