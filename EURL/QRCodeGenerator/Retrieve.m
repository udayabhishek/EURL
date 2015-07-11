//
//  Retrieve.m
//  EURL
//
//  Created by ShikshaPC-41 on 22/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "Retrieve.h"

@implementation Retrieve
@synthesize RetrieveDelegate;
-(void)makeRequestForRetrieveQRResultBy:(NSString *)UDID app_name:(NSString *)appName{
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@IMEI=%@&app_name=%@",MainUrl,Path,RetrieveUrl,UDID,appName];
   // NSLog(@"%@",urlString);
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
   // NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
    //NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
   // NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Sucessful %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Retrieve Failure");
        NSDictionary *dict=nil;
        
        dict=[JSON copy];

        [self didparsingFailed:[JSON copy]];
        NSLog(@"Failure%@",JSON);
        
        
        
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
    [self.RetrieveDelegate performSelectorOnMainThread:@selector(successJsonParsingForRetrieveRecord:) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed:(NSMutableDictionary *)retrieveDictionary{
    
    [self.RetrieveDelegate performSelectorOnMainThread:@selector(failureJsonParsingForRetrieveRecord:) withObject:retrieveDictionary waitUntilDone:NO];
}

@end
