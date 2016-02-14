//
//  VKUserCounters.m
//  VkSimpleSdk
//

#import "VKUserCounters.h"

static NSString *kAlbums = @"albums";
static NSString *kVideos = @"videos";
static NSString *kAudios = @"audios";
static NSString *kNotes = @"notes";
static NSString *kPhotos = @"photos";
static NSString *kGroups = @"groups";
static NSString *kGifts = @"gifts";
static NSString *kFriends = @"friends";
static NSString *kOnlineFriends = @"online_friends";
static NSString *kUserPhotos = @"user_photos";
static NSString *kUserVideos = @"user_videos";
static NSString *kFollowers = @"followers";
static NSString *kSubscriptions = @"subscriptions";
static NSString *kPages = @"pages";

@implementation VKUserCounters

+ (instancetype)userCountersFromResponse:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]])
    {
        return [[VKUserCounters alloc] initWithDictionary:response];
    }
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        _albums = [dictionary[kAlbums] integerValue];
        _videos = [dictionary[kVideos] integerValue];
        _audios = [dictionary[kAudios] integerValue];
        _notes = [dictionary[kNotes] integerValue];
        _photos = [dictionary[kPhotos] integerValue];
        _groups = [dictionary[kGroups] integerValue];
        _gifts = [dictionary[kGifts] integerValue];
        _friends = [dictionary[kFriends] integerValue];
        _onlineFriends = [dictionary[kOnlineFriends] integerValue];
        _userPhotos = [dictionary[kUserPhotos] integerValue];
        _userVideos = [dictionary[kUserVideos] integerValue];
        _followers = [dictionary[kFollowers] integerValue];
        _subscriptions = [dictionary[kSubscriptions] integerValue];
        _pages = [dictionary[kPages] integerValue];
    }
    return self;
}

@end
