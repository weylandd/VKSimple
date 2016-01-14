//
//  VKAuthorizationResult.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

@interface VKAuthorizationResult : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *error;
@property (nonatomic, assign) NSTimeInterval created;
@property (nonatomic, assign) NSInteger expiresIn;

+ (instancetype)resultFromUrl:(NSURL *)url;

@end
