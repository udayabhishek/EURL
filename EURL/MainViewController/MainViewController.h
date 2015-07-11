//
//  MainViewController.h
//  EURL
//
//  Created by ShikshaPC-41 on 04/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "MainPage.h"
#import "GADBannerView.h"
#import "QRCodeGeneratedViewController.h"
#import "AboutEURLViewController.h"
#import "Reachability.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <AVFoundation/AVFoundation.h>
#import "GenerateViewController.h"
#import "QRCodeScanningViewController.h"
#import "TextFeedback.h"
#import "VoiceFeedback.h"
@interface MainViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UITextViewDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate,UIGestureRecognizerDelegate,sendTextFeedbackDelegate,sendVoiceFeedbackDelegate,GADBannerViewDelegate>

{
    GADBannerView *bannerView;
    UIView *viewForFeedBack;
    UITextView *feedBackTextView;
    MFMailComposeViewController *mail;
    MFMessageComposeViewController *sms;
    SLComposeViewController *facebook;
    SLComposeViewController *twitter;
    IBOutlet UICollectionView *collection;
    UIAlertView *internetStatusAlertView;
    UIAlertView *customAlert;
    AVAudioRecorder *audioRecord;
    AVAudioPlayer *player;
    UITapGestureRecognizer *tapGesture;
    UIBarButtonItem *cancel;
    UIActionSheet *sheet1;
}
@property(strong,nonatomic)IBOutlet UIActivityIndicatorView *spinner;
@end
