//
//  AppDelegate.h
//  EURL
//
//  Created by ShikshaPC-41 on 04/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navi;
    
}
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) MainViewController *mainView;
@end
