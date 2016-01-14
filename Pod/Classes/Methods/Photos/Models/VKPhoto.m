//
//  VKPhoto.m
//  VkSimpleSdk
//

#import "VKPhoto.h"
#import "VKConsts.h"
#import "VKSimpleMethodsHelpers.h"

static NSString *kPhotoId = @"pid";
static NSString *kAlbumId = @"aid";
static NSString *kOwnerId = @"owner_id";
static NSString *kPhoto75 = @"src_small";
static NSString *kPhoto130 = @"src";
static NSString *kPhoto604 = @"src_big";
static NSString *kPhoto807 = @"src_xbig";
static NSString *kPhoto1280 = @"src_xxbig";
static NSString *kWidth = @"width";
static NSString *kHeight = @"height";
static NSString *kText = @"text";
static NSString *kDate = @"created";
static NSString *kPostId = @"post_id";
static NSString *kLikes = @"likes";
static NSString *kReposts = @"reposts";

@implementation VKPhoto

+ (instancetype)photoFromResponse:(id)response
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
        _photoId = dictionary[kPhotoId];
        _albumId = dictionary[kAlbumId];
        _ownerId = dictionary[kOwnerId];
        _photo75 = dictionary[kPhoto75];
        _photo130 = dictionary[kPhoto130];
        _photo604 = dictionary[kPhoto604];
        _photo807 = dictionary[kPhoto807];
        _photo1280 = dictionary[kPhoto1280];
        _width = dictionary[kWidth];
        _height = dictionary[kHeight];
        _text = dictionary[kText];
        _date = [VKSimpleMethodsHelpers dateFromNumber:dictionary[kDate]];
        _postId = dictionary[kPostId];
        _likes = [VKLikes likesFromResponse:dictionary[kLikes]];
        _reposts = [VKReposts repostsFromResponse:dictionary[kReposts]];
    }
    return self;
}

@end
