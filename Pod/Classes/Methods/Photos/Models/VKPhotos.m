//
//  VKPhotos.m
//  VkSimpleSdk
//

#import "VKPhotos.h"
#import "VKPhoto.h"
#import "VKPhotoSpecial.h"

@implementation VKPhotos

+ (void)parsePhotosFromResponse:(id)response photoFormat:(VKPhotoFormat)photoFormat success:(void (^)(VKPhotos *))success failure:(FailureBlock)failure
{
    VKPhotos *user = [VKPhotos photosFromResponse:response photoFormat:photoFormat];
    if (user)
    {
        if (success)
        {
            success(user);
        }
        return;
    }
    VKApiError *error = [VKApiError errorFromResponse:response];
    if (failure)
    {
        failure(YES, error);
    }
    if (error)
    {
        VKApiError(@"%@", error.message);
    }
    else
    {
        VKError(@"parse error");
    }
}

+ (instancetype)photosFromResponse:(id)response photoFormat:(VKPhotoFormat)photoFormat
{
    if (response && [response isKindOfClass:[NSArray class]])
    {
        NSArray *array = response;
        if (array && [array.firstObject isKindOfClass:[NSNumber class]])
        {
            return [[VKPhotos alloc] initWithArray:array photoFormat:photoFormat];
        }
    }
    return nil;
}

- (instancetype)initWithArray:(NSArray *)array photoFormat:(VKPhotoFormat)photoFormat
{
    self = [super init];
    if (self)
    {
        NSMutableArray *photos = [NSMutableArray new];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                if (photoFormat == VKPhotoFormat_default)
                {
                    VKPhoto *photo = [VKPhoto photoFromResponse:obj];
                    if (photo)
                    {
                        [photos addObject:photo];
                    }
                }
                else
                {
                    VKPhotoSpecial *photo = [VKPhotoSpecial photoFromResponse:obj];
                    if (photo)
                    {
                        [photos addObject:photo];
                    }
                }
            }
            else if ([obj isKindOfClass:[NSNumber class]])
            {
                _count = [obj integerValue];
            }
        }];
        if (photos.count > 0)
        {
            _photos = photos;
        }
    }
    return self;
}

@end
