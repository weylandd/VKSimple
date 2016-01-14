//
//  VKPhotoSize.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VKPhotoSizeType)
{
    VKPhotoSizeType_error,
    VKPhotoSizeType_s, //75px
    VKPhotoSizeType_m, //130px
    VKPhotoSizeType_x, //604px
    VKPhotoSizeType_o, //3:2 130px
    VKPhotoSizeType_p, //3:2 200px
    VKPhotoSizeType_q, //3:2 320px
    VKPhotoSizeType_r, //3:2 510px
    VKPhotoSizeType_y, //807px
    VKPhotoSizeType_z, //1280x1024
    VKPhotoSizeType_w  //2560x2048
};

@interface VKPhotoSize : NSObject

@property (nonatomic, assign) VKPhotoSizeType type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;

+ (instancetype)photoSizeFromResponse:(id)response;

@end
