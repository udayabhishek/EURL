//
//  GenerateViewController.h
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 02/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <SystemConfiguration/SystemConfiguration.h>
#import "UIImage+QRcodeMethod.h"
#import <AVFoundation/AVFoundation.h>
#import "GADBannerView.h"
#import "InsertOriginalImageAndVoice.h"
#import "InsertQRImage.h"
#import "Base64.h"
#import "InsertTextRequestClass.h"
#import "InsertImageRequestClass.h"
#import "SaveQRImageRequestClass.h"
#import "AFHTTPClient.h"
#import "DeleteQRCode.h"

@interface GenerateViewController : UIViewController<UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,GADBannerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,InsertTextDelegate,InsertOriginalImageDelegate,InsertOriginalVoiceDelegate,SaveImageQRDelegate,DeleteQRCodeDelegate>
{
   
    NSString *datestring;
    NSString *replaceUuidString;
   IBOutlet UISegmentedControl *segmentForGenerateQR;
     UIView *viewForText;
    UIView *viewForImage;
  UIView *viewForVoice;
    GADBannerView *bannerView;
    IBOutlet UIActivityIndicatorView *indicator;
   //text
    UITextView *generateTextView;
    UIImageView *imageView;
    UITapGestureRecognizer *tapGesture;
    UIAlertView *alert;
    UIButton *generate;
    UIButton *textSaveButton;
    NSString *dateAndTimeString;
    NSString *time1;
     NSString *textPathString;
    //image
    UIButton *generateButtonForImage;
    UIImageView *imageForImageQR;
   UIImagePickerController *imagePick;
    UIButton *imageButton;
    
    NSString *imagePathString;
    UIImageView *ImageforQRCode;
    UIButton *imageSaveButton;
    UIImageView *imageFrame;
    NSString *imageStringUrl;
  //voice
    AVAudioRecorder *audioRecord;
    UIButton *recordButton;
    UIImageView *img;
    UIButton *voiceSaveButton;
    UIButton *playButton;
    UIButton *generateButtonForRecordQR;
    AVAudioPlayer *player;
    UIImageView *recordImage;
    UIImageView *playImage;
    UIButton *stopButton;
    UIImageView *statusImage;
}
@property(strong,nonatomic)UIImageView *imageForImageQR;
@property(strong,nonatomic)NSString *imagePathString;
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *spinner;
-(IBAction)segment:(id)sender;
@end
