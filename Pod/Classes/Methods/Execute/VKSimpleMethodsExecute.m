//
//  VKSimpleMethodsExecute.m
//  VkSimpleSdk
//

#import "VKSimpleMethodsExecute.h"

static NSString *kMethod_getAllPhotos = @"execute.getAllPhotos";

static NSString *kParam_user_id = @"user_id";
static NSString *kParam_offset = @"offset";
static NSString *kParam_count = @"count";
static NSString *kParam_photo_sizes = @"photo_sizes";
static NSString *kParam_extended = @"extended";

@implementation VKSimpleMethodsExecute

+ (void)getAllPhotos_success:(void(^)(VKPhotos *photos))success failure:(FailureBlock)failure
{
    [self getAllPhotos_withUserId:nil success:success failure:failure];
}

+ (void)getAllPhotos_withUserId:(NSString *)userId success:(void(^)(VKPhotos *photos))success failure:(FailureBlock)failure
{
    [self getAllPhotos_withUserId:userId offset:nil count:nil success:success failure:failure];
}

+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count success:(void (^)(VKPhotos *))success failure:(FailureBlock)failure
{
    [self getAllPhotos_withUserId:userId offset:offset count:count photoFormat:VKPhotoFormat_default success:success failure:failure];
}

+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count photoFormat:(VKPhotoFormat)photoFormat success:(void (^)(VKPhotos *))success failure:(FailureBlock)failure
{
    [self getAllPhotos_withUserId:userId offset:offset count:count photoFormat:photoFormat photoInfo:VKPhotoInfo_default success:success failure:failure];
}

+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count photoFormat:(VKPhotoFormat)photoFormat photoInfo:(VKPhotoInfo)photoInfo success:(void (^)(VKPhotos *))success failure:(FailureBlock)failure
{
    NSDictionary *params = @{kParam_user_id: ObjectOrNull(userId),
                             kParam_offset: ObjectOrNull(offset),
                             kParam_count: ObjectOrNull(count),
                             kParam_photo_sizes: @(photoFormat),
                             kParam_extended: @(photoInfo)};
    [VKMethodsRequest responseWithMethod:kMethod_getAllPhotos params:params isNeedToken:YES completion:^(id responseObject) {
        [VKPhotos parsePhotosFromResponse:responseObject photoFormat:photoFormat success:success failure:failure];
    } failure:failure];
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end
