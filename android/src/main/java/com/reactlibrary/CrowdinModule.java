package com.reactlibrary;

import androidx.annotation.NonNull;

import com.crowdin.platform.Crowdin;
import com.crowdin.platform.CrowdinConfig;
import com.crowdin.platform.LoadingStateListener;
import com.crowdin.platform.util.ExtensionsKt;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import org.jetbrains.annotations.NotNull;

import java.util.Locale;

public class CrowdinModule extends ReactContextBaseJavaModule {

    private static ReactApplicationContext reactContext;

    CrowdinModule(ReactApplicationContext context) {
        super(context);
        reactContext = context;
    }

    @NonNull
    @Override
    public String getName() {
        return "Crowdin";
    }

    @ReactMethod
    public void initWithHashString(
            @NonNull String distributionHash,
            @NonNull String sourceLanguage,
            @NotNull final Callback callback) {
        Crowdin.init(reactContext, new CrowdinConfig.Builder()
                .withDistributionHash(distributionHash)
                .build());
        final LoadingStateListener listener = new LoadingStateListener() {
            @Override
            public void onDataChanged() {
                Crowdin.unregisterDataLoadingObserver(this);
                callback.invoke("Localization downloaded");
            }

            @Override
            public void onFailure(@NotNull Throwable throwable) {
                Crowdin.unregisterDataLoadingObserver(this);
                callback.invoke(throwable.getLocalizedMessage());
            }
        };

        Crowdin.registerDataLoadingObserver(listener);
    }

    @ReactMethod(isBlockingSynchronousMethod = true)
    public String getString(@NonNull String key) {
        String formattedCode = ExtensionsKt.getFormattedCode(Locale.getDefault());
        return Crowdin.getString(formattedCode, key);
    }

    @ReactMethod(isBlockingSynchronousMethod = true)
    public String getStringByLocale(@NonNull String languageCode, @NonNull String key) {
        if (languageCode.isEmpty()) {
            languageCode = ExtensionsKt.getFormattedCode(Locale.getDefault());
        }
        return Crowdin.getString(languageCode, key);
    }

    @ReactMethod(isBlockingSynchronousMethod = true)
    public String getResources() {
        return Crowdin.getResources(Locale.getDefault().getLanguage());
    }

    @ReactMethod(isBlockingSynchronousMethod = true)
    public String getResourcesByLocale(@NonNull String languageCode) {
        Locale locale = getLocaleForLanguageCode(languageCode);
        String formattedCode = ExtensionsKt.getFormattedCode(locale);
        return Crowdin.getResources(formattedCode);
    }

    private Locale getLocaleForLanguageCode(String languageCode) {
        String code = Locale.getDefault().getLanguage();
        Locale locale;
        try {
            String[] localeData = languageCode.split("-");
            code = localeData[0];
            String region = localeData[1];
            locale = new Locale(code, region);
        } catch (Exception ex) {
            locale = new Locale(code);
        }

        return locale;
    }
}