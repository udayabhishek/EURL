//
//  InsertTextRequestClass.m
//  EURL
//
//  Created by ShikshaPC-41 on 30/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "InsertTextRequestClass.h"

@implementation InsertTextRequestClass
@synthesize InsertTextDelegate;



-(void)makeRequestForInsertTextBy:(NSString *)originalImage app_name:(NSString *)appName date_time:(NSString *)dateAndtime date_time:(NSString *)date_time type:(NSString *)type time1:(NSString *)time IMEI:(NSString *)UDID uploadedfile:(NSString *)uploadedfile
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@original_image=%@&app_name=%@&date_time=%@&date_time=%@&type=%@&time1=%@&IMEI=%@&uploadedfile=%@",MainUrl,Path,InsertTextUrl,originalImage,appName,dateAndtime,date_time,type,time,UDID,uploadedfile];

    
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
    NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Success %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure");
        [self didparsingFailed];
        NSLog(@"Failure %@",JSON);
    }];
    
    [operation start];
    
    
}
-(void)didStartParsing:(NSDictionary *)dict
{
    
    NSLog(@"dict ==== %@",dict);
    NSLog(@"dict ==== %lu",(unsigned long)[dict count]);
    
    fetchedReponseArray=[[NSMutableArray alloc]init];
    
    if ([dict count]) {
        
        [self didfinishedParsing:[dict copy]];
        
    }
    else{
        [self didparsingFailed];
    }
}

-(void)didfinishedParsing:(NSMutableDictionary *)parsedDictionary{
    
    [self.InsertTextDelegate performSelectorOnMainThread:@selector(successJSONParsingTextResult:) withObject:parsedDictionary waitUntilDone:NO];
    
    
}


-(void)didparsingFailed{
    
    
    [self.InsertTextDelegate performSelectorOnMainThread:@selector(failureJSONParsingTextResult) withObject:nil waitUntilDone:NO];
    
}

@end
