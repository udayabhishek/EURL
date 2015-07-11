//
//  VoiceFeedback.m
//  EURL
//
//  Created by ShikshaPC-41 on 29/09/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "VoiceFeedback.h"

@implementation VoiceFeedback
@synthesize sendVoiceFeedbackDelegate;
-(void)makeRequestFotSendTextFeedbackByText:(NSString *)voiceFeedbackString{
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@%@",MainUrl,Path,SendVoiceFeedbackUrl,voiceFeedbackString];
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
-(void)makeRequestFotSendVoiceFeedbackByText:(NSString *)audiofile AppName:(NSString *)appName{
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@Uploadedfile=%@&AppName=%@",MainUrl,Path,SendVoiceFeedbackUrl,audiofile,appName];
    NSLog(@"%@",urlString);
    NSString *replaceUrlString= [urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"replaceUrlString %@",replaceUrlString);
    NSURL *url = [NSURL URLWithString:replaceUrlString];
    NSLog(@"url %@",url);
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"" parameters:nil];
    
    NSLog(@"request %@",request);
    
    
    AFJSONRequestOperation *operation=[AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"Sucessful for send voice feedback %@",JSON);
        
        NSDictionary *dict=nil;
        
        dict=[JSON copy];
        
        [self didStartParsing:[JSON copy]];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Failure for send voice feedback");
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
    [self.sendVoiceFeedbackDelegate performSelectorOnMainThread:@selector(successJsonParsingForVoiceFeedback:) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed{
    
    [self.sendVoiceFeedbackDelegate performSelectorOnMainThread:@selector(failureJsonParsingForVoiceFeedback) withObject:nil waitUntilDone:NO];
}

@end
