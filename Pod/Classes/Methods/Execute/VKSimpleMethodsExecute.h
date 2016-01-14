//
//  VKSimpleMethodsExecute.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKMethodsRequest.h"
#import "VKPhotos.h"

@interface VKSimpleMethodsExecute : NSObject

// improved method photos.getAll with max count = 4800
+ (void)getAllPhotos_success:(void(^)(VKPhotos *photos))success failure:(FailureBlock)failure;
+ (void)getAllPhotos_withUserId:(NSString *)userId success:(void(^)(VKPhotos *photos))success failure:(FailureBlock)failure;
+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count success:(void (^)(VKPhotos *photos))success failure:(FailureBlock)failure;
+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count photoFormat:(VKPhotoFormat)photoFormat success:(void (^)(VKPhotos *photos))success failure:(FailureBlock)failure;
+ (void)getAllPhotos_withUserId:(NSString *)userId offset:(NSNumber *)offset count:(NSNumber *)count photoFormat:(VKPhotoFormat)photoFormat photoInfo:(VKPhotoInfo)photoInfo success:(void (^)(VKPhotos *photos))success failure:(FailureBlock)failure;

@end
