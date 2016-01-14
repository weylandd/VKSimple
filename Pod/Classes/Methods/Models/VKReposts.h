//
//  VKReposts.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

@interface VKReposts : NSObject

@property (nonatomic, assign) NSInteger count;

+ (instancetype)repostsFromResponse:(id)response;

@end
