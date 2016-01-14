//
//  VKSimpleMethodsHelpers.m
//  VkSimpleSdk
//

#import "VKSimpleMethodsHelpers.h"

@implementation VKSimpleMethodsHelpers

+ (NSDate *)dateFromNumber:(NSNumber *)number
{
    if (!number)
    {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:[number longValue]];
}

@end
