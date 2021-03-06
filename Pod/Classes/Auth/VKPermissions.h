//
//  VKPermissions.h
//  VkSimpleSdk
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VkAuthScope)
{
    VK_PER_NOTIFY = 1,
    //	Пользователь разрешил отправлять ему уведомления (для flash/iframe-приложений)
    VK_PER_FRIENDS = 2,
    // Доступ к друзьям.
    VK_PER_PHOTOS = 4,
    //	Доступ к фотографиям.
    VK_PER_AUDIO = 8,
    // Доступ к аудиозаписям.
    VK_PER_VIDEO = 16,
    // Доступ к видеозаписям.
    VK_PER_DOCS = 131072,
    // Доступ к документам.
    VK_PER_NOTES = 2048,
    // Доступ к заметкам пользователя.
    VK_PER_PAGES = 128,
    // Доступ к wiki-страницам.
    VK_PER_LINK = 256,
    // Добавление ссылки на приложение в меню слева.
    VK_PER_STATUS = 1024,
    // Доступ к статусу пользователя.
    VK_PER_WALL = 8192,
    // Доступ к обычным и расширенным методам работы со стеной.
    VK_PER_GROUPS = 262144,
    // Доступ к группам пользователя.
    VK_PER_MESSAGES = 4096,
    // Доступ к расширенным методам работы с сообщениями.
    VK_PER_EMAIL = 4194304,
    // Доступ к email пользователя.
    VK_PER_NOTIFICATIONS = 524288,
    // Доступ к оповещениям об ответах пользователю.
    VK_PER_STATS = 1048576,
    // Доступ к статистике групп и приложений пользователя, администратором которых он является.
    VK_PER_ADS = 32768,
    // Доступ к расширенным методам работы с рекламным API.
    VK_PER_OFFLINE = 65536
    // Доступ к API в любое время (при использовании этой опции параметр expires_in, возвращаемый вместе с access_token, содержит 0 — токен бессрочный).
};

@interface VKPermissions : NSObject

@end
