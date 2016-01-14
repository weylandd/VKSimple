//
//  VKLikes.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

@interface VKLikes : NSObject

@property (nonatomic, assign) NSInteger userLikes;
@property (nonatomic, assign) NSInteger count;

+ (instancetype)likesFromResponse:(id)response;

@end
