//
//  VKPhoto.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKLikes.h"
#import "VKReposts.h"

@interface VKPhoto : NSObject

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSNumber *albumId;
@property (nonatomic, strong) NSNumber *ownerId;
@property (nonatomic, strong) NSString *photo75;
@property (nonatomic, strong) NSString *photo130;
@property (nonatomic, strong) NSString *photo604;
@property (nonatomic, strong) NSString *photo807;
@property (nonatomic, strong) NSString *photo1280;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) VKLikes *likes;
@property (nonatomic, strong) VKReposts *reposts;

+ (instancetype)photoFromResponse:(id)response;

@end
