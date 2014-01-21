//
//  NSString+stripHTML.m
//  MeetMeUp
//
//  Created by Fletcher Rhoads on 1/20/14.
//  Copyright (c) 2014 Fletcher Rhoads. All rights reserved.
//

#import "NSString+stripHTML.h"

@implementation NSString (stripHTML)

-(NSString *) stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy] ;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}


@end
