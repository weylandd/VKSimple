//
//  VKUserCounters.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

@interface VKUserCounters : NSObject

@property (nonatomic, assign) NSInteger albums;
@property (nonatomic, assign) NSInteger videos;
@property (nonatomic, assign) NSInteger audios;
@property (nonatomic, assign) NSInteger notes;
@property (nonatomic, assign) NSInteger photos;
@property (nonatomic, assign) NSInteger groups;
@property (nonatomic, assign) NSInteger gifts;
@property (nonatomic, assign) NSInteger friends;
@property (nonatomic, assign) NSInteger onlineFriends;
@property (nonatomic, assign) NSInteger userPhotos;
@property (nonatomic, assign) NSInteger userVideos;
@property (nonatomic, assign) NSInteger followers;
@property (nonatomic, assign) NSInteger subscriptions;
@property (nonatomic, assign) NSInteger pages;

+ (instancetype)userCountersFromResponse:(id)response;

@end
