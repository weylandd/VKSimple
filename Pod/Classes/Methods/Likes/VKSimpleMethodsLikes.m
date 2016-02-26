//
//  VKSimpleMethodsLikes.m
//  VkSimpleSdk
//

#import "VKSimpleMethodsLikes.h"
#import "VKArrayResult.h"
#import "VKLikesCount.h"

static NSString *kMethod_getList = @"likes.getList";
static NSString *kMethod_add = @"likes.add";

static NSString *kVKLikesFilterType_default = @"";
static NSString *kVKLikesFilterType_likes = @"likes";
static NSString *kVKLikesFilterType_copies = @"copies";

static NSString *kVKObjectType_post = @"post";
static NSString *kVKObjectType_comment = @"comment";
static NSString *kVKObjectType_photo = @"photo";
static NSString *kVKObjectType_audio = @"audio";
static NSString *kVKObjectType_video = @"video";
static NSString *kVKObjectType_note = @"note";
static NSString *kVKObjectType_photo_comment = @"photo_comment";
static NSString *kVKObjectType_video_comment = @"video_comment";
static NSString *kVKObjectType_topic_comment = @"topic_comment";
static NSString *kVKObjectType_sitepage = @"sitepage";

static NSString *kType = @"type";
static NSString *kOwnerId = @"owner_id";
static NSString *kItemId = @"item_id";
static NSString *kPageUrl = @"page_url";
static NSString *kFilterType = @"filter";
static NSString *kFriendsOnly = @"friends_only";
static NSString *kExtendedInfo = @"extended";
static NSString *kOffset = @"offset";
static NSString *kCount = @"count";
static NSString *kSkipOwn = @"skip_own";

@implementation VKSimpleMethodsLikes

+ (void)getList_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId success:(void (^)(NSArray *users))success failure:(FailureBlock)failure
{
    [self getList_withType:type ownerId:ownerId itemId:itemId pageUrl:nil filterType:VKLikesFilterType_default friendsOnly:NO extendedInfo:NO offset:nil count:@1000 skipOwn:NO isNeedToken:NO isAutoErrorHandling:YES success:success failure:failure];
}

+ (void)getList_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId filterType:(VKLikesFilterType)filterType success:(void (^)(NSArray *users))success failure:(FailureBlock)failure
{
    [self getList_withType:VKObjectType_photo ownerId:ownerId itemId:itemId pageUrl:nil filterType:filterType friendsOnly:NO extendedInfo:NO offset:nil count:@1000 skipOwn:NO isNeedToken:NO isAutoErrorHandling:YES success:success failure:failure];
}

+ (void)getList_withType:(VKObjectType)type
                 ownerId:(NSNumber *)ownerId
                  itemId:(NSNumber *)itemId
                 pageUrl:(NSString *)pageUrl
              filterType:(VKLikesFilterType)filterType
             friendsOnly:(BOOL)friendsOnly
            extendedInfo:(BOOL)extendedInfo
                  offset:(NSNumber *)offset
                   count:(NSNumber *)count
                 skipOwn:(BOOL)skipOwn
             isNeedToken:(BOOL)isNeedToken
     isAutoErrorHandling:(BOOL)isAutoErrorHandling
                 success:(void (^)(NSArray *))success
                 failure:(FailureBlock)failure
{
    NSDictionary *params = @{kType: [self _stringOfObjectType:type],
                             kOwnerId: ObjectOrNull(ownerId),
                             kItemId: ObjectOrNull(itemId),
                             kPageUrl: ObjectOrNull(pageUrl),
                             kFilterType: [self _stringOflikesFilterType:filterType],
                             kFriendsOnly: @(friendsOnly),
                             kExtendedInfo: @(extendedInfo),
                             kOffset: ObjectOrNull(offset),
                             kCount: ObjectOrNull(count),
                             kSkipOwn: @(skipOwn)};
    [VKMethodsRequest responseWithMethod:kMethod_getList params:params isNeedToken:isNeedToken completion:^(id responseObject) {
        [VKArrayResult parseResultFromResponse:responseObject success:^(VKArrayResult *result) {
            if (success)
            {
                success(result.array);
            }
        } failure:^(BOOL isConnection, VKApiError *error) {
            if ([error.code isEqualToNumber:@15] && isAutoErrorHandling)
            {
                [self getList_withType:type ownerId:ownerId itemId:itemId pageUrl:pageUrl filterType:filterType friendsOnly:friendsOnly extendedInfo:extendedInfo offset:offset count:count skipOwn:skipOwn isNeedToken:YES isAutoErrorHandling:isAutoErrorHandling success:success failure:failure];
            }
            else if ([error.code isEqualToNumber:@6] && isAutoErrorHandling)
            {
                dispatch_after(dispatch_time(0.5 * DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getList_withType:type ownerId:ownerId itemId:itemId pageUrl:pageUrl filterType:filterType friendsOnly:friendsOnly extendedInfo:extendedInfo offset:offset count:count skipOwn:skipOwn isNeedToken:isNeedToken isAutoErrorHandling:isAutoErrorHandling success:success failure:failure];
                });
            }
            else if (failure)
            {
                failure(isConnection, error);
            }
        }];
    } failure:failure];
}

+ (void)add_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId success:(void (^)(NSInteger likes))success failure:(FailureBlock)failure
{
    NSDictionary *params = @{kType: [self _stringOfObjectType:type],
                             kOwnerId: ObjectOrNull(ownerId),
                             kItemId: ObjectOrNull(itemId)};
    [VKMethodsRequest responseWithMethod:kMethod_add params:params isNeedToken:YES completion:^(id responseObject) {
        [VKLikesCount parseResultFromResponse:responseObject success:^(VKLikesCount *likesCount) {
            if (success)
            {
                success(likesCount.value);
            }
        } failure:failure];
    } failure:failure];
}

#pragma mark - Private

+ (NSString *)_stringOflikesFilterType:(VKLikesFilterType)filterType
{
    NSArray *types = @[kVKLikesFilterType_default,
                       kVKLikesFilterType_likes,
                       kVKLikesFilterType_copies];
    return (NSString *)[types objectAtIndex:filterType];
}

+ (NSString *)_stringOfObjectType:(VKObjectType)objectType
{
    NSArray *types = @[kVKObjectType_post,
                       kVKObjectType_comment,
                       kVKObjectType_photo,
                       kVKObjectType_audio,
                       kVKObjectType_video,
                       kVKObjectType_note,
                       kVKObjectType_photo_comment,
                       kVKObjectType_video_comment,
                       kVKObjectType_topic_comment,
                       kVKObjectType_sitepage];
    return (NSString *)[types objectAtIndex:objectType];
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end
