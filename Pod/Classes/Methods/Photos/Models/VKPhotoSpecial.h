//
//  VKPhotoSpecial.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>
#import "VKLikes.h"
#import "VKReposts.h"

@interface VKPhotoSpecial : NSObject

@property (nonatomic, strong) NSNumber *photoId;
@property (nonatomic, strong) NSNumber *albumId;
@property (nonatomic, strong) NSNumber *ownerId;
@property (nonatomic, strong) NSArray *photoSizes;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *postId;
@property (nonatomic, strong) VKLikes *likes;
@property (nonatomic, strong) VKReposts *reposts;

+ (instancetype)photoFromResponse:(id)response;

@end
