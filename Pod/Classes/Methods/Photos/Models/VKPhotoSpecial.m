//
//  VKPhotoSpecial.m
//  VkSimpleSdk
//

#import "VKPhotoSpecial.h"
#import "VKConsts.h"
#import "VKPhotoSize.h"
#import "VKSimpleMethodsHelpers.h"

static NSString *kPhotoId = @"pid";
static NSString *kAlbumId = @"aid";
static NSString *kOwnerId = @"owner_id";
static NSString *kPhotoSizes = @"sizes";
static NSString *kText = @"text";
static NSString *kDate = @"created";
static NSString *kPostId = @"post_id";
static NSString *kLikes = @"likes";
static NSString *kReposts = @"reposts";

@implementation VKPhotoSpecial

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
        _photoSizes = [self _sizesWithArray:dictionary[kPhotoSizes]];
        _text = dictionary[kText];
        _date = [VKSimpleMethodsHelpers dateFromNumber:dictionary[kDate]];
        _postId = dictionary[kPostId];
        _likes = [VKLikes likesFromResponse:dictionary[kLikes]];
        _reposts = [VKReposts repostsFromResponse:dictionary[kReposts]];
    }
    return self;
}

- (NSArray *)_sizesWithArray:(NSArray *)array
{
    NSMutableArray *sizes = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        VKPhotoSize *size = [VKPhotoSize photoSizeFromResponse:obj];
        if (size)
        {
            [sizes addObject:size];
        }
    }];
    return sizes;
}

@end
