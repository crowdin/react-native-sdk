#import "Crowdin.h"
@import CrowdinSDK;

@implementation Crowdin

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback) {
    CrowdinProviderConfig *providerConfig = [[CrowdinProviderConfig alloc] initWithHashString:@"2db137daf26d22bf499c998106i" localizations:@[@"en", @"de", @"uk"] sourceLanguage:@"en"];
    CrowdinLoginConfig *loginConfig = [[CrowdinLoginConfig alloc] initWithClientId:@"test-sdk" clientSecret:@"79MG6E8DZfEeomalfnoKx7dA0CVuwtPC3jQTB3ts" scope:@"project" redirectURI:@"crowdintest1://" organizationName:nil error:nil];
    
    CrowdinSDKConfig *config = [[CrowdinSDKConfig config] withCrowdinProviderConfig:providerConfig];
    
    config = [config withLoginConfig:loginConfig];
    config = [config withSettingsEnabled:YES];
    
    [CrowdinSDK startWithConfig: config];
    // TODO: Implement some actually useful functionality
    
    
//    NSLog(NSLocalizedString(@"details_button", nil));
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD(initWithHashString:(NSString *)hashString localizations:(NSArray<NSString *> *)localizations sourceLanguage:(NSString *)sourceLanguage callback:(RCTResponseSenderBlock)callback) {
    CrowdinProviderConfig *providerConfig = [[CrowdinProviderConfig alloc] initWithHashString:hashString localizations:localizations sourceLanguage:sourceLanguage];
    
    CrowdinLoginConfig *loginConfig = [[CrowdinLoginConfig alloc] initWithClientId:@"test-sdk" clientSecret:@"79MG6E8DZfEeomalfnoKx7dA0CVuwtPC3jQTB3ts" scope:@"project" redirectURI:@"crowdintest://" organizationName:nil error:nil];
    
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

RCT_EXPORT_METHOD(localizedStringForKey:(NSString *)key callback:(RCTResponseSenderBlock)callback) {
    NSString *string = NSLocalizedString(key, nil);
    NSLog(@"%@", string);
    callback(@[string]);
}

@end
