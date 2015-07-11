//
//  QRCodeScanningViewController.m
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "QRCodeScanningViewController.h"

@interface QRCodeScanningViewController ()
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL isReading;
-(BOOL)startReading;
-(void)stopReading;
@end

@implementation QRCodeScanningViewController
@synthesize str1;
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
    // Initially make the captureSession object nil.
    self.title=self.titleString;
    
    _bbitemStart.tintColor=[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
    _captureSession = nil;
    
    // Set the initial value of the flag to NO.
    _isReading = NO;
    
    // Begin loading the sound effect so to have it ready for playback when it's needed.
    self.viewPreview.layer.borderWidth=3.0f;
    self.viewPreview.layer.cornerRadius=4.0f;
    self.viewPreview.layer.borderColor=[[UIColor colorWithRed:150.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0] CGColor];
    self.lblStatus.layer.cornerRadius=4.0f;
    //[UIColor colorWithRed:10.0/255.0 green:69.0/255.0 blue:60.0/255.0 alpha:1.0];
}
- (IBAction)startStopReading:(id)sender {
    if (!_isReading) {
        // This is the case where the app should read a QR code when the start button is tapped.
        if ([self startReading]) {
            // If the startReading methods returns YES and the capture session is successfully
            // running, then change the start button title and the status message.
            [_bbitemStart setTitle:@"Stop"];
            [_lblStatus setText:@"Scanning for QR Code..."];
        }
    }
    else{
        // In this case the app is currently reading a QR code and it should stop doing so.
        //commented by myself..............!!!!!!!!!!!!
       // [self stopReading];
        // The bar button item's title should change again.
        [_bbitemStart setTitle:@"Start!"];
    }
    
    
    // Set to the flag the exact opposite value of the one that currently has.
    _isReading = !_isReading;
}

#pragma mark - Private method implementation

- (BOOL)startReading {
    NSError *error;
    
    // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video
    // as the media type parameter.
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Get an instance of the AVCaptureDeviceInput class using the previous device object.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        // If any error occurs, simply log the description of it and don't continue any more.
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // Initialize the captureSession object.
    _captureSession = [[AVCaptureSession alloc] init];
    // Set the input device on the capture session.
    [_captureSession addInput:input];
    // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Create a new serial dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    // Start video capture.
    [_captureSession startRunning];
    
    return YES;
}


-(void)stopReading{
    // Stop video capture and make the capture session object nil.
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Remove the video preview layer from the viewPreview view's layer.
    [_videoPreviewLayer removeFromSuperlayer];
    
    self.str1=_lblStatus.text;
    NSLog(@"result:%@",self.str1);
    if(([self.str1  hasPrefix:@"http:"])||([self.str1  hasPrefix:@"HTTP:"])||([self.str1  hasPrefix:@"www."])||([self.str1  hasPrefix:@"WWW."])||([self.str1  hasPrefix:@"https:"])){
        WebViewController *obj;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
            obj=[[WebViewController alloc]initWithNibName:@"WebViewController_ipad" bundle:nil];
        }
        else
        {
            if([UIScreen mainScreen].bounds.size.height==568){
                obj=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
            }
            else{
                obj=[[WebViewController alloc]initWithNibName:@"WebViewController_iphone" bundle:nil];
            }
        }
        obj.urlString=self.str1 ;
        [self.navigationController pushViewController:obj animated:NO];
    }
    
    else if ([self.str1 length]==0){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error!" message:@"invalid QR-Code" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        alert.tag=123;
    }
    else {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Scan Results" message:self.str1  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert1.tag=88;
        [alert1 show];
    }

    
    }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((alertView.tag==123)&&(buttonIndex==0)) {
        
[_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
       [_lblStatus setText:@"QR Code Reader is not yet running..."];
    }
    if ((buttonIndex==0)&&(alertView.tag==88)) {
       [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
       [_lblStatus setText:@"QR Code Reader is not yet running..."];
   }
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate method implementation
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Check if the metadataObjects array is not nil and it contains at least one object.
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Get the metadata object.
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // If the found metadata is equal to the QR code metadata then update the status label's text,
            // stop reading and change the bar button item's title and the flag's value.
            // Everything is done on the main thread.
            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
           
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            
            [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Start!" waitUntilDone:NO];
            
            _isReading = NO;
            // If the audio player is not nil, then play the sound effect.
            
        }
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
