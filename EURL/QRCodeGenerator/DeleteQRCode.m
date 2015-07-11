//
//  DeleteQRCode.m
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "DeleteQRCode.h"
#import "BaseUrl.h"
#import "AFNetworking.h"
@implementation DeleteQRCode
@synthesize DeleteQRCodeDelegate;
-(void)makeRequestForDeleteQRCodeByIMEI:(NSString *)UDID deleteid:(NSString *)ID app_name:(NSString *)appName{
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@IMEI=%@&id=%@&app_name=%@",MainUrl,Path,DeleteUrl,UDID,ID,appName];
    NSLog(@"%@",urlString);
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
    NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Successful %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"delete Failure");
        NSDictionary *dict=nil;
        
        dict=[JSON copy];

        [self didparsingFailed:[JSON copy]];
        NSLog(@"Failure %@",JSON);
    }];
    
    [operation start];
    
    
}
-(void)didStartParsing:(NSDictionary *)dict
{
    NSLog(@"dict ==== %@",dict);
    NSLog(@"dict ==== %lu",(unsigned long)[dict count]);
    
    fetchedResponseArray=[[NSMutableArray alloc]init];
    
    if ([dict count]) {
        
        [self didfinishedParsing:[dict copy]];
        
    }
    else{
        [self didparsingFailed:[dict copy]];
    }
}
-(void)didfinishedParsing:(NSMutableDictionary *)parsedDictionary{
    [self.DeleteQRCodeDelegate performSelectorOnMainThread:@selector(successJsonParsingForDeleteRecord:) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed:(NSMutableDictionary *)parsedDictionary{
    
    [self.DeleteQRCodeDelegate performSelectorOnMainThread:@selector(failureJsonParsingForDeleteRecord:) withObject:nil waitUntilDone:NO];
}
@end
