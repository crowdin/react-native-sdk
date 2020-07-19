package com.reactlibrary;

import androidx.annotation.NonNull;

import com.crowdin.platform.Crowdin;
import com.crowdin.platform.CrowdinConfig;
import com.crowdin.platform.LoadingStateListener;
import com.crowdin.platform.ResourcesCallback;
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
    public String getResources() {
        return Crowdin.getResources();
    }

    @ReactMethod
    public void getResourcesByLocale(@NonNull String languageCode, @NotNull final Callback callback) {
        Locale locale = ExtensionsKt.getLocaleForLanguageCode(languageCode);
        String formattedCode = ExtensionsKt.getFormattedCode(locale);
        Crowdin.getResourcesByLocale(formattedCode, new ResourcesCallback() {
            @Override
            public void onDataReceived(@NotNull String json) {
                callback.invoke(json);
            }
        });
    }
}