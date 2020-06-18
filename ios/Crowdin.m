#import "Crowdin.h"
@import CrowdinSDK;

@implementation Crowdin

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initWithHashString:(NSString *)hashString sourceLanguage:(NSString *)sourceLanguage callback:(RCTResponseSenderBlock)callback) {
    CrowdinProviderConfig *providerConfig = [[CrowdinProviderConfig alloc] initWithHashString:hashString sourceLanguage:sourceLanguage];
    CrowdinSDKConfig *config = [[CrowdinSDKConfig config] withCrowdinProviderConfig:providerConfig];
    [CrowdinSDK startWithConfig: config];
    [CrowdinSDK addDownloadHandler:^{
        callback(@[@"Localization downloaded"]);
    }];
    [CrowdinSDK addErrorUpdateHandler:^(NSArray<NSError *> * _Nonnull errors) {
        callback(errors);
    }];
}


RCT_EXPORT_METHOD(initWithHashString1:(NSString *)hashString sourceLanguage:(NSString *)sourceLanguage clientId:(NSString *)clientId clientSecret:(NSString *)clientSecret scope:(NSString *)scope redirectURI:(NSString *)redirectURI organizationName:(NSString *)organizationName callback:(RCTResponseSenderBlock)callback) {
    CrowdinProviderConfig *providerConfig = [[CrowdinProviderConfig alloc] initWithHashString:hashString sourceLanguage:sourceLanguage];
    
    NSError *error = nil;
    CrowdinLoginConfig *loginConfig = [[CrowdinLoginConfig alloc] initWithClientId:clientId clientSecret:clientSecret scope:scope redirectURI:redirectURI organizationName:organizationName error:&error];
    
    if (error) {
        callback(@[error]);
        return;
    }
    
    CrowdinSDKConfig *config = [[CrowdinSDKConfig config] withCrowdinProviderConfig:providerConfig];
    
    
    config = [config withLoginConfig:loginConfig];
    config = [config withSettingsEnabled:YES];
    config = [config withRealtimeUpdatesEnabled:YES];
    config = [config withScreenshotsEnabled:YES];
    
    [CrowdinSDK startWithConfig: config];
    
    [CrowdinSDK addDownloadHandler:^{
        callback(@[@"Localization downloaded"]);
    }];
    
    [CrowdinSDK addErrorUpdateHandler:^(NSArray<NSError *> * _Nonnull errors) {
        callback(errors);
    }];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(localizedStringForKey:(NSString *)key) {
    return NSLocalizedString(key, nil);
}

//RCT_EXPORT_METHOD(localizationWithCallback:(RCTPromiseResolveBlock)callback) {
//    NSString *string = NSLocalizedString(key, nil);
//    CrowdinSDK
//    callback(string);
//}


@end
