//
//  VKError.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

extern NSString * const VKAuthFailedNotification;

@interface VKApiError : NSObject

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSString *message;

+ (instancetype)errorFromResponse:(id)response;

@end
