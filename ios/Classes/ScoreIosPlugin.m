#import "ScoreIosPlugin.h"
#import <StoreKit/StoreKit.h>


@implementation ScoreIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"score_ios"
                                     binaryMessenger:[registrar messenger]];
    ScoreIosPlugin* instance = [[ScoreIosPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"showReview" isEqualToString:call.method]) {
        NSArray * arr = call.arguments;
        NSString * appID =arr.count==0?@"" :arr[0];
        [self showAppStoreReViewWithID:appID];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)showAppStoreReViewWithID:(NSString *)appID
{//仅支持iOS10.3+（需要做校验） 且每个APP内每年最多弹出3次评分alart
    if ([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
        //防止键盘遮挡
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [SKStoreReviewController requestReview];
    }else{
        //不论iOS 版本均可使用APP内部打开网页形式，跳转到App Store 直接编辑评论
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?action=write-review", appID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

@end
