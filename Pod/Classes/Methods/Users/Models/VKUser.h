//
//  VKUser.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKConsts.h"
@class VKUserCounters;

@interface VKUser : NSObject

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSNumber *sex;
@property (nonatomic, strong) NSString *photo50;
@property (nonatomic, strong) NSString *photo100;
@property (nonatomic, strong) NSString *photo200orig;
@property (nonatomic, strong) NSString *photo200;
@property (nonatomic, strong) NSString *photo400orig;
@property (nonatomic, strong) NSString *photoMax;
@property (nonatomic, strong) NSString *photoMaxOrig;
@property (nonatomic, strong) NSNumber *friendsCount;
@property (nonatomic, strong) VKUserCounters *counters;

+ (void)parseUserFromResponse:(id)response
                      success:(void (^)(NSArray *users))success
                      failure:(FailureBlock)failure;

@end
