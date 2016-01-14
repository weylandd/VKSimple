//
//  VKPhotos.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKConsts.h"

typedef NS_ENUM(NSInteger, VKPhotoFormat)
{
    VKPhotoFormat_default,
    VKPhotoFormat_special
};

typedef NS_ENUM(NSInteger, VKPhotoInfo)
{
    VKPhotoInfo_default,
    VKPhotoInfo_extended
};


@interface VKPhotos : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *photos;

+ (void)parsePhotosFromResponse:(id)response
                    photoFormat:(VKPhotoFormat)photoFormat
                        success:(void (^)(VKPhotos *))success
                        failure:(FailureBlock)failure;

+ (instancetype)photosFromResponse:(id)response
                       photoFormat:(VKPhotoFormat)photoFormat;

@end
