//
//  VKSimpleMethodsLikes.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKMethodsRequest.h"

typedef NS_ENUM(NSInteger, VKObjectType)
{
    VKObjectType_post, //запись на стене пользователя или группы
    VKObjectType_comment, //комментарий к записи на стене
    VKObjectType_photo, //фотография
    VKObjectType_audio, //аудиозапись
    VKObjectType_video, //видеозапись
    VKObjectType_note, //заметка
    VKObjectType_photo_comment, //комментарий к фотографии
    VKObjectType_video_comment, //комментарий к видеозаписи
    VKObjectType_topic_comment, //комментарий в обсуждении
    VKObjectType_sitepage //страница сайта, на котором установлен
};

typedef NS_ENUM(NSInteger, VKLikesFilterType)
{
    VKLikesFilterType_default,
    VKLikesFilterType_likes,
    VKLikesFilterType_copies
};

@interface VKSimpleMethodsLikes : NSObject

+ (void)getList_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId success:(void(^)(NSArray *users))success failure:(FailureBlock)failure;
+ (void)getList_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId filterType:(VKLikesFilterType)filterType success:(void (^)(NSArray *users))success failure:(FailureBlock)failure;
+ (void)getList_withType:(VKObjectType)type ownerId:(NSNumber *)ownerId itemId:(NSNumber *)itemId pageUrl:(NSString *)pageUrl filterType:(VKLikesFilterType)filterType friendsOnly:(BOOL)friendsOnly extendedInfo:(BOOL)extendedInfo offset:(NSNumber *)offset count:(NSNumber *)count skipOwn:(BOOL)skipOwn isNeedToken:(BOOL)isNeedToken isAutoErrorHandling:(BOOL)isAutoErrorHandling success:(void(^)(NSArray *users))success failure:(FailureBlock)failure;

@end
