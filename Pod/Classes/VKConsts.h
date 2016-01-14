//
//  VKConsts.h
//  VkSimpleSdk
//

#import "VKApiError.h"

typedef void(^CodeBlock)(void);
typedef void(^FailureBlock)(BOOL isConnection, VKApiError *error);

#define UserDefaults          [NSUserDefaults standardUserDefaults]

#ifdef DEBUG
    #define VKlog( s, ... ) NSLog( @"\n> %s line - %d\n> %@", __FUNCTION__, __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
    #define VKError( s, ... ) NSLog( @"\n> %s line - %d\n> ERROR:\n> %@", __FUNCTION__, __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
    #define VKApiError( s, ... ) //NSLog( @"\n> %s line - %d\n> API ERROR:\n> %@", __FUNCTION__, __LINE__,  [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
    #define VKlog( s, ... )
    #define VKError( s, ... )
    #define VKApiError( s, ... )
#endif
