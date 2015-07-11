//
//  UIImage+QRcodeMethod.h
//  QRcodeForSimpleText
//
//  Created by ShikshaPC-41 on 21/08/14.
//  Copyright (c) 2014 Shiksha Infotech Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRcodeMethod)
+ (UIImage*)QRCodeGenerator:(NSString*)iData
             andLightColour:(UIColor*)iLightColour
              andDarkColour:(UIColor*)iDarkColour
               andQuietZone:(NSInteger)iQuietZone
                    andSize:(NSInteger)iSize;
@end
