//
//  TextFeedback.m
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "TextFeedback.h"

@implementation TextFeedback
@synthesize sendTextFeedbackDelegate;
-(void)makeRequestFotSendTextFeedbackByText:(NSString *)AppName TextMessage:(NSString *)message{
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@AppName=%@&TextMessage=%@",MainUrl,Path,SendTextFeedbackUrl,AppName,message];
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
    
    fetchedResponseArray=[[NSMutableArray alloc]init];
    
    if ([dict count]) {
        
        [self didfinishedParsing:[dict copy]];
        
    }
    else{
        [self didparsingFailed];
    }
}
-(void)didfinishedParsing:(NSMutableDictionary *)parsedDictionary{
    [self.sendTextFeedbackDelegate performSelectorOnMainThread:@selector(successJsonParsingForTextFeedback:) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed{
    
    [self.sendTextFeedbackDelegate performSelectorOnMainThread:@selector(failureJsonParsingForTextFeedback) withObject:nil waitUntilDone:NO];
}
@end
