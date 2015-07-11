//
//  SaveQRImageRequestClass.m
//  EURL
//
//  Created by ShikshaPC-41 on 07/10/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import "SaveQRImageRequestClass.h"

@implementation SaveQRImageRequestClass
@synthesize SaveImageQRDelegate;

-(void)makeRequestForInsertOriginalImageBy:(NSString *)ID IMEI:(NSString *)UDID date_time:(NSString *)date_time app_name:(NSString *)appName time1:(NSString *)time uploadedfile:(NSString *)uploadedfile{

NSString *urlString=[NSString stringWithFormat:@"%@%@%@id=%@&IMEI=%@&app_name=%@&time1=%@,date_time=%@&uploadedfile=%@",MainUrl,Path,InsertUrl,ID,UDID,appName,time,date_time,uploadedfile];
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
    [self.SaveImageQRDelegate performSelectorOnMainThread:@selector(successJsonParsingForInsertingOriginalImageRecord:) withObject:parsedDictionary waitUntilDone:NO];
}
-(void)didparsingFailed{
    
    [self.SaveImageQRDelegate performSelectorOnMainThread:@selector(failureJsonParsingForInsertingOriginalImageRecord) withObject:nil waitUntilDone:NO];
}
@end
