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
    
    __block NSUInteger downloadHandler;
    downloadHandler = [CrowdinSDK addDownloadHandler:^{
        callback(@[@"Localization downloaded"]);
        [CrowdinSDK removeDownloadHandler:downloadHandler];
    }];
    
    __block NSUInteger errorHandler;
    errorHandler = [CrowdinSDK addErrorUpdateHandler:^(NSArray<NSError *> * _Nonnull errors) {
        callback(errors);
        [CrowdinSDK removeErrorHandler:errorHandler];
    }];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getString:(NSString *)key) {
    return NSLocalizedString(key, nil);
}


RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getResourcesByLocale:(NSString *)locale) {
    return [CrowdinSDK localizationDictionaryFor:locale];
}

RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getResourcesDictionaryByLocale:(NSString *)language) {
    return [self stringFormDictionary:[CrowdinSDK localizationDictionaryFor:language]];
}


RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getResourcesDictionary) {
    return [CrowdinSDK localizationDictionary];
}


RCT_EXPORT_BLOCKING_SYNCHRONOUS_METHOD(getResources) {
    return [self stringFormDictionary:[CrowdinSDK localizationDictionary]];
}

- (NSString *)stringFormDictionary:(NSDictionary *)dictionary {
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
