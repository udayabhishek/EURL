//
//  AboutEURLViewController.h
//  CollectionViewEURL
//
//  Created by ShikshaPC-41 on 28/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "MainViewController.h"
#import "GADBannerView.h"

@interface AboutEURLViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate>
{
    GADBannerView *bannerView;
    IBOutlet   UITableView *tableView1;
}
@property(strong,nonatomic)NSString *titleString;

@end
