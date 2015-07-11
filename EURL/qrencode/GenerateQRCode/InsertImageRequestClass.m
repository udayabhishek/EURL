//
//  InsertImageRequestClass.m
//  EURL
//
//  Created by ShikshaPC-41 on 01/10/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "InsertImageRequestClass.h"

@implementation InsertImageRequestClass
@synthesize InsertOriginalImageDelegate;



-(void)makeRequestForInsertOriginalImageBy:(NSString *)UDID app_name:(NSString *)appName type:(NSString *)type time1:(NSString *)time uploadedfile:(NSString *)uploadedfile
{
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@IMEI=%@&app_name=%@&type=%@&time1=%@&uploadedfile=%@",MainUrl,Path,InsertUrl,UDID,appName,type,time,uploadedfile];
    NSLog(@"%@",urlString);
    NSString *replaceUrlString=[urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *url=[NSURL URLWithString:replaceUrlString];
    NSLog(@"%@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
   
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response,id JSON) {
        NSLog(@"Success %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error,id JSON) {
        NSLog(@"image insert Failure ");
        [self didparsingFailed];
        NSLog(@"Image insert json failure %@",JSON);
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
    
    [self.InsertOriginalImageDelegate performSelectorOnMainThread:@selector(successJsonParsingForInsertingOriginalImageRecord:) withObject:parsedDictionary waitUntilDone:NO];
    
}


-(void)didparsingFailed{
    
    
    [self.InsertOriginalImageDelegate performSelectorOnMainThread:@selector(failureJsonParsingForInsertingOriginalImageRecord) withObject:nil waitUntilDone:NO];
    
    
}


@end
