//
//  VKSimpleUsersMethods.m
//  VkSimpleSdk
//

#import "VKSimpleMethodsUsers.h"

static NSString *kVKNameCase_nom = @"nom"; //именительный
static NSString *kVKNameCase_gen = @"gen"; //родительный
static NSString *kVKNameCase_dat = @"dat"; //дательный
static NSString *kVKNameCase_acc = @"acc"; //винительный
static NSString *kVKNameCase_ins = @"ins"; //творительный
static NSString *kVKNameCase_abl = @"abl"; //предложный

static NSString *kMethod_get = @"users.get";

static NSString *kParam_user_ids = @"user_ids";
static NSString *kParam_fields = @"fields";
static NSString *kParam_name_case = @"name_case";

NSString *const VKUserField_sex = @"sex";
NSString *const VKUserField_photo_50 = @"photo_50";
NSString *const VKUserField_photo_100 = @"photo_100";
NSString *const VKUserField_photo_200_orig = @"photo_200_orig";
NSString *const VKUserField_photo_200 = @"photo_200";
NSString *const VKUserField_photo_400_orig = @"photo_400_orig";
NSString *const VKUserField_photo_max = @"photo_max";
NSString *const VKUserField_photo_max_orig = @"photo_max_orig";
NSString *const VKUserField_common_count = @"common_count";
NSString *const VKUserField_counters = @"counters";

@implementation VKSimpleMethodsUsers

#pragma mark - get

+ (void)get_success:(void(^)(NSArray *user))success failure:(FailureBlock)failure
{
    [self get_withUserIds:nil success:success failure:failure];
}

+ (void)get_withUserIds:(NSArray<NSString *> *)userIds success:(void (^)(NSArray *))success failure:(FailureBlock)failure
{
    [self get_withUserIds:userIds fields:nil success:success failure:failure];
}

+ (void)get_withUserIds:(NSArray<NSString *> *)userIds fields:(NSArray<NSString *> *)fields success:(void (^)(NSArray *))success failure:(FailureBlock)failure
{
    [self get_withUserIds:userIds fields:fields nameCase:VKNameCase_nom success:success failure:failure];
}

+ (void)get_withUserIds:(NSArray<NSString *> *)userIds fields:(NSArray<NSString *> *)fields nameCase:(VKNameCase)nameCase success:(void (^)(NSArray *))success failure:(FailureBlock)failure
{
    NSDictionary *params = @{kParam_user_ids: ObjectOrNull([self _stringOfArray:userIds]),
                             kParam_fields: ObjectOrNull([self _stringOfArray:fields]),
                             kParam_name_case: ObjectOrNull([self _stringOfNameCase:nameCase])};
    BOOL isNeedToken = !userIds || userIds.count > 1;
    [VKMethodsRequest responseWithMethod:kMethod_get params:params isNeedToken:isNeedToken completion:^(id responseObject) {
        [VKUser parseUserFromResponse:responseObject success:success failure:failure];
    } failure:failure];
}

#pragma mark - private

+ (NSString *)_stringOfArray:(NSArray *)array
{
    NSMutableString *string = [NSMutableString new];
    [array enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]])
        {
            [string appendFormat:@"%@,", obj];
        }
        else if ([obj isKindOfClass:[NSNumber class]])
        {
            [string appendFormat:@"%@,", [obj stringValue]];
        }
        else
        {
            VKError(@"obj not king of NSString or NSNunber");
        }
    }];
    if (string.length > 0)
    {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    return string;
}

+ (NSString *)_stringOfNameCase:(VKNameCase)nameCase
{
    NSArray *cases = @[kVKNameCase_nom,
                       kVKNameCase_gen,
                       kVKNameCase_dat,
                       kVKNameCase_acc,
                       kVKNameCase_ins,
                       kVKNameCase_abl];
    return (NSString *)[cases objectAtIndex:nameCase];
}

static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}

@end
