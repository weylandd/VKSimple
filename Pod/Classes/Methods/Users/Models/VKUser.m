//
//  VKUser.m
//  VkSimpleSdk
//

#import "VKUser.h"

static NSString *kUserId = @"uid";
static NSString *kFirstName = @"first_name";
static NSString *kLastName = @"last_name";
static NSString *kSex = @"sex";
static NSString *kPhoto50 = @"photo_50";
static NSString *kPhoto100 = @"photo_100";
static NSString *kPhoto200orig = @"photo_200_orig";
static NSString *kPhoto200 = @"photo_200";
static NSString *kPhoto400orig = @"photo_400_orig";
static NSString *kPhotoMax = @"photo_max";
static NSString *kPhotoMaxOrig = @"photo_max_orig";
static NSString *kFriendsCount = @"common_count";

@implementation VKUser

+ (void)parseUserFromResponse:(id)response success:(void (^)(VKUser *))success failure:(FailureBlock)failure
{
    VKUser *user = [VKUser userFromResponse:response];
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

+ (instancetype)userFromResponse:(id)response
{
    if (response && [response isKindOfClass:[NSArray class]])
    {
        NSArray *array = response;
        if (array && [array.firstObject isKindOfClass:[NSDictionary class]])
        {
            return [[VKUser alloc] initWithDictionary:array.firstObject];
        }
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _userId = dictionary[kUserId];
        _firstName = dictionary[kFirstName];
        _lastName = dictionary[kLastName];
        _sex = dictionary[kSex];
        _photo50 = dictionary[kPhoto50];
        _photo100 = dictionary[kPhoto100];
        _photo200orig = dictionary[kPhoto200orig];
        _photo200 = dictionary[kPhoto200];
        _photo400orig = dictionary[kPhoto400orig];
        _photoMax = dictionary[kPhotoMax];
        _photoMaxOrig = dictionary[kPhotoMaxOrig];
        _friendsCount = dictionary[kFriendsCount];
    }
    return self;
}

@end
