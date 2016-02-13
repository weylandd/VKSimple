//
//  VKAuthorizationView.m
//  VkSimpleSdk
//

#import "VKAuthorizationView.h"
#import "VKAuthorizationHelper.h"
#import "VKConsts.h"

@interface VKAuthorizationView () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation VKAuthorizationView

- (void)authWithURL:(NSURL *)url
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [AuthorizationHelper handleOpenURL:[request URL]];
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    if (error.code == -1001 || error.code == - 1003 || error.code == -1004 || error.code == -1005 || error.code == - 1009)
    {
        if ([self.output respondsToSelector:@selector(vkAuthViewDidConnectionProblem)])
        {
            [self.output vkAuthViewDidConnectionProblem];
        }
        VKError(@"webView connection problem");
        return;
    }
    [self.output vkAuthViewAuthFailed];
    VKError(@"%@", error);
}

#pragma mark - > Layout <

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self _layoutWebView];
}

- (void)_layoutWebView
{
    CGRect rect = self.bounds;
    self.webView.frame = rect;
}

#pragma mark - Lazy initialization

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [UIWebView new];
        _webView.delegate = self;
        [self addSubview:_webView];
    }
    return _webView;
}

@end
