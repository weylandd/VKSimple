//
//  VkStorage.m
//  VkSimpleSdk
//

#import "VKStorage.h"
#import "VKConsts.h"
#import "VKAuthorizationResult.h"

NSString *const VkStorage_accessToken = @"VkStorage_accessToken";
NSString *const VkStorage_userId = @"VkStorage_userId";
NSString *const VkStorage_created = @"VkStorage_created";
NSString *const VkStorage_expiresIn = @"VkStorage_expiresIn";
NSString *const VkStorage_isUserLogged = @"VkStorage_isUserLogged";

@implementation VKStorage

+ (void)saveAuthorizationResult:(VKAuthorizationResult *)result
{
    [VKStorage saveVkAccessToken:result.token];
    [VKStorage saveVkUserId:result.userId];
    [VKStorage saveExpiresIn:result.expiresIn];
    [VKStorage saveCreated:result.created];
}

+ (void)saveVkAccessToken:(NSString *)accessToken
{
    [self _saveString:accessToken forKey:VkStorage_accessToken];
}

+ (NSString *)accessToken
{
    return [self _stringForKey:VkStorage_accessToken];
}

+ (void)saveVkUserId:(NSString *)userId
{
    [self _saveString:userId forKey:VkStorage_userId];
}

+ (NSString *)userId
{
    return [self _stringForKey:VkStorage_userId];
}

+ (void)saveCreated:(CGFloat)created
{
    [UserDefaults setFloat:created forKey:VkStorage_created];
}

+ (CGFloat)created
{
    return [UserDefaults floatForKey:VkStorage_created];
}

+ (void)saveExpiresIn:(NSInteger)expiresIn
{
    [UserDefaults setInteger:expiresIn forKey:VkStorage_expiresIn];
}

+ (NSInteger)expiresIn
{
    return [UserDefaults integerForKey:VkStorage_expiresIn];
}

+ (void)saveIsUserLogged:(BOOL)isUserLogged
{
    [UserDefaults setBool:isUserLogged forKey:VkStorage_isUserLogged];
}

+ (BOOL)isUserLogged
{
    return [UserDefaults boolForKey:VkStorage_isUserLogged];
}

+ (void)removeUserInfo
{
    [self _removeObjectsForKeys:@[VkStorage_accessToken, VkStorage_userId, VkStorage_created, VkStorage_expiresIn]];
}

#pragma mark - Expire

+ (BOOL)isTokenValid
{
    return [self isExpired] && [self accessToken];
}

+ (BOOL)isExpired
{
    NSInteger expired = [UserDefaults integerForKey:VkStorage_expiresIn];
    if (expired == 0)
    {
        return YES;
    }
    CGFloat created = [UserDefaults floatForKey:VkStorage_created];
    return expired > 0 && expired + created < [[NSDate new] timeIntervalSince1970];
}

#pragma mark - private

+ (void)_saveString:(NSString *)string forKey:(NSString *)key
{
    [UserDefaults setObject:string forKey:key];
}

+ (NSString *)_stringForKey:(NSString *)key
{
    id object = [UserDefaults objectForKey:key];
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    return nil;
}

+ (void)_removeObjectsForKeys:(NSArray *)keys
{
    for (NSString *key in keys)
    {
        [UserDefaults removeObjectForKey:key];
    }
    [UserDefaults synchronize];
}

+ (void)_removeObjectForKey:(NSString *)key
{
    [UserDefaults removeObjectForKey:key];
    [UserDefaults synchronize];
}

@end
