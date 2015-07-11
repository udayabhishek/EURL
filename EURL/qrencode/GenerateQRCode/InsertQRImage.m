//
//  InsertQRImage.m
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "InsertQRImage.h"

@implementation InsertQRImage
@synthesize InsertQRImageDelegate;

-(void)makeRequestForInsertQRCodeImageBy:(NSString *)ID app_name:(NSString *)appName time1:(NSString *)time date_time:(NSString *)dateAndtime type:(NSString *)type UDID:(NSString *)UDID uploadedfile:(NSString *)uploadedfile {
    
NSString *urlString=[NSString stringWithFormat:@"%@%@%@id=%@&app_name=%@&time1=%@&date_time=%@&type=%@&IMEI=%@&uploadedfile=%@",MainUrl,Path,InsertQRImageUrl,ID,appName,time,dateAndtime,type,UDID,uploadedfile];
    NSLog(@"%@",urlString);
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
    NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Sucessful %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"sucess");
        [self didparsingFailed];
        NSLog(@"sucess %@",JSON);
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
        [self didparsingFailed];
    }
}
-(void)didfinishedParsing:(NSMutableDictionary *)parsedDictionary{
    [self.InsertQRImageDelegate performSelectorOnMainThread:@selector(successJsonParsingForInsertingImageRecord: ) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed{
    
    [self.InsertQRImageDelegate performSelectorOnMainThread:@selector(failureJsonParsingForInsertingImageRecord) withObject:nil waitUntilDone:NO];
}
@end
