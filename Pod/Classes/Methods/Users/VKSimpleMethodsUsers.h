//
//  VKSimpleUsersMethods.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKMethodsRequest.h"
#import "VKUser.h"

typedef NS_ENUM(NSInteger, VKNameCase)
{
    VKNameCase_nom = 0,  //именительный
    VKNameCase_gen,      //родительный
    VKNameCase_dat,      //дательный
    VKNameCase_acc,      //винительный
    VKNameCase_ins,      //творительный
    VKNameCase_abl       //предложный
};

extern NSString *const VKUserField_sex;
extern NSString *const VKUserField_photo_50;
extern NSString *const VKUserField_photo_100;
extern NSString *const VKUserField_photo_200_orig;
extern NSString *const VKUserField_photo_200;
extern NSString *const VKUserField_photo_400_orig;
extern NSString *const VKUserField_photo_max;
extern NSString *const VKUserField_photo_max_orig;
extern NSString *const VKUserField_common_count;
extern NSString *const VKUserField_counters;

@interface VKSimpleMethodsUsers : NSObject

+ (void)get_success:(void(^)(VKUser *user))success failure:(FailureBlock)failure;
+ (void)get_withUserIds:(NSArray<NSString *> *)userIds success:(void(^)(VKUser *user))success failure:(FailureBlock)failure;
+ (void)get_withUserIds:(NSArray<NSString *> *)userIds fields:(NSArray<NSString *> *)fields success:(void(^)(VKUser *user))success failure:(FailureBlock)failure;
+ (void)get_withUserIds:(NSArray<NSString *> *)userIds fields:(NSArray<NSString *> *)fields nameCase:(VKNameCase)nameCase success:(void(^)(VKUser *user))success failure:(FailureBlock)failure;

@end
