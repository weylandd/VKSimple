//
//  VKPhotoSize.m
//  VkSimpleSdk
//

#import "VKPhotoSize.h"
#import "VKConsts.h"

static NSString *kType = @"type";
static NSString *kUrl = @"src";
static NSString *kWidth = @"width";
static NSString *kHeight = @"height";

@implementation VKPhotoSize

+ (instancetype)photoSizeFromResponse:(id)response
{
    if (response && [response isKindOfClass:[NSDictionary class]])
    {
        return [[self alloc] initWithDictionary:response];
    }
    VKApiError *error = [VKApiError errorFromResponse:response];
    if (error)
    {
        VKApiError(@"%@", error.message);
    }
    else
    {
        VKError(@"parse error");
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _type = [self _photoSizeTypeWithString:dictionary[kType]];
        _url = dictionary[kUrl];
        _width = dictionary[kWidth];
        _height = dictionary[kHeight];
    }
    return self;
}

- (VKPhotoSizeType)_photoSizeTypeWithString:(NSString *)string
{
    if ([string isEqualToString:@"s"])
    {
        return VKPhotoSizeType_s;
    }
    else if ([string isEqualToString:@"m"])
    {
        return VKPhotoSizeType_m;
    }
    else if ([string isEqualToString:@"x"])
    {
        return VKPhotoSizeType_x;
    }
    else if ([string isEqualToString:@"o"])
    {
        return VKPhotoSizeType_o;
    }
    else if ([string isEqualToString:@"p"])
    {
        return VKPhotoSizeType_p;
    }
    else if ([string isEqualToString:@"q"])
    {
        return VKPhotoSizeType_q;
    }
    else if ([string isEqualToString:@"r"])
    {
        return VKPhotoSizeType_r;
    }
    else if ([string isEqualToString:@"y"])
    {
        return VKPhotoSizeType_y;
    }
    else if ([string isEqualToString:@"z"])
    {
        return VKPhotoSizeType_z;
    }
    else if ([string isEqualToString:@"w"])
    {
        return VKPhotoSizeType_w;
    }
    return VKPhotoSizeType_error;
}

@end
