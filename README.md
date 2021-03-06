[<p align="center"><img src="https://support.crowdin.com/assets/logos/crowdin-dark-symbol.png" data-canonical-src="https://support.crowdin.com/assets/logos/crowdin-dark-symbol.png" width="200" height="200" align="center"/></p>](https://crowdin.com)

# Crowdin React Native SDK `beta`

Crowdin React Native SDK delivers all-new translations from the Crowdin project to the application immediately. So there is no need to update this application to get the new version with the localization.

The SDK is using the [Android SDK](https://github.com/crowdin/mobile-sdk-android) and [iOS SDK](https://github.com/crowdin/mobile-sdk-ios) as Native Modules and provides:

* Over-The-Air Content Delivery – the localized content can be sent to the application from the project whenever needed.

It allows you to easily download localization from Crowdin and use it in your application.

## Status

[![npm](https://img.shields.io/npm/v/@crowdin/react-native-sdk?logo=npm&cacheSeconds=1800)](https://www.npmjs.com/package/@crowdin/react-native-sdk)
[![npm](https://img.shields.io/npm/dt/@crowdin/react-native-sdk?cacheSeconds=1800)](https://www.npmjs.com/package/@crowdin/react-native-sdk)
[![GitHub issues](https://img.shields.io/github/issues-raw/crowdin/react-native-sdk?cacheSeconds=1800)](https://github.com/crowdin/react-native-sdk/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/crowdin/react-native-sdk?cacheSeconds=5000)](https://github.com/crowdin/react-native-sdk/graphs/contributors)
[![GitHub](https://img.shields.io/github/license/crowdin/react-native-sdk?cacheSeconds=150000)](https://github.com/crowdin/react-native-sdk/blob/master/LICENSE)

## Table of Contents
* [Requirements](#requirements)
* [Installation](#installation)
* [Setup](#setup)
* [Example Project](#example-project)
* [Usage](#usage)
* [Limitations](#limitations)
* [Contributing](#contributing)
* [Seeking Assistance](#seeking-assistance)
* [Security](#security)
* [License](#license)

## Requirements

React Native 0.6+

## Installation

- Using npm:

   `npm install @crowdin/react-native-sdk --save`

- Using [React Native CLI](https://github.com/react-native-community/cli):

   `react-native link @crowdin/react-native-sdk`

## Example Project

To discover how React Native SDK is integrated into a real project see the [Example project](https://github.com/crowdin/react-native-sdk/tree/master/example). You can set up this project for yourself, run, and test.

This example uses the [React Native Localization](https://www.npmjs.com/package/react-native-localization) package for interface localization.

[<p align='center'><img src='https://github.com/crowdin/react-native-sdk/blob/docs/example-project.gif' height='400'/></p>](#)

To run the example project, first clone the repo, fill in SDK configuration in the *App* class and run a project in the *example* directory:

- Navigate to the *example* directory:

   `cd react-native-sdk/example`

- Install dependencies:

   `npm install`

- Start React Native webserver:

   `react-native start`

- Run [Emulator/Simulator](https://reactnative.dev/docs/running-on-simulator-ios) or connect a [real device](https://reactnative.dev/docs/running-on-device).

- Open another terminal and run:

   `react-native run-android` for Android App

   `react-native run-ios` for iOS App

**Note:** To read more about setting up the development environment see the [Official Docs](https://www.npmjs.com/package/react-native-localization).

## Setup

To configure React Native SDK integration you need to:

- Upload your *JSON* localization file to Crowdin. If you have ready translations, you can also upload them.
- Set up Distribution in Crowdin.
- Set up SDK and enable the Over-The-Air Content Delivery feature in your project.

**Distribution** is a CDN vault that mirrors the translated content of your project and is required for integration with the React Native app.

To manage distributions open the needed project and go to *Over-The-Air Content Delivery*. You can create as many distributions as you need and choose different files for each. You’ll need to click the *Release* button next to the necessary distribution every time you want to send new translations to the app.

**Notes:**
- The CDN feature does not update the localization files. if you want to add new translations to the localization files you need to do it yourself.
- Once SDK receives the translations, it's stored on the device as application files for further sessions to minimize requests the next time the app starts.
- CDN caches all the translation in release for up to 15 minutes and even when new translations are released in Crowdin, CDN may return it with a delay.

## Usage

Import *Crowdin* dependency:

   ```javascript
   import Crowdin from '@crowdin/react-native-sdk';
   ```

Crowdin React Native SDK provides a set of methods that allows you to download localization from CDN and use it in your application.

1. Initialization:

    ```javascript
    Crowdin.initWithHashString('distribution_hash', 'source_language_code', (messages) => { })
    ```
    - `distribution_hash` - Crowdin Distribution Hash.
    - `source_language_code` - Source [language code](https://support.crowdin.com/api/language-codes/) in your Crowdin project.

    Callback parameters:

    - `messages` - An array of errors of library initialization or localization downloading. In case initialization success returns "Localization downloaded" message.

2. Get localization resources for the current language:

    ```javascript
    Crowdin.getResources()
    ```

    Returns all downloaded localization for the current language in JSON format as a String.

    -  Output example:

    ```
    {"language": "en", "strings": {...}, "arrays": {...}, "plurals": {...}}
    ```

3. Get localizations for the specific language:

    ```javascript
    Crowdin.getResourcesByLocale('target_language_code', (data) => { })
    ```

    - `target_language_code` - [Language Codes](https://support.crowdin.com/api/language-codes/).

    Callback parameters:

    `data` - all downloaded localization for the specified language in JSON format as a String.

    -  Example:

    ```
    {"language": "en", "strings": {...}, "arrays": {...}, "plurals": {...}}
    ```

4. Get localized string by key for current locale:

    ```javascript
    Crowdin.getString('key')
    ```

    - `key` - localization string key.

5. Example of how to Update / Overwrite Locale with the `react-native-localization`:

```js
updateLocalization() {
    Crowdin.initWithHashString('distribution_hash', DEFAULT_LANGUAGE, (message) => {});

    Crowdin.getResourcesByLocale('uk', (data) => {
        var response = JSON.parse(data);

        translations.setContent(
            Object.assign({}, translations.getContent(), {
                uk: response.strings
            })
        );

        this.resetState();
    })
}

resetState = () => {
    this.setState({});
}
```

For more details see the [App.js](/example/App.js) class.

### OTA JavaScript client usage

For React Native applications there is also a possibility to use [JS client](https://github.com/crowdin/ota-client-js) without any native modules.
[Here](https://github.com/crowdin/react-native-sdk/tree/feat/ota-client-js-integration/example) you can find example listed above where this library is used.

## Limitations

Currently, Screenshots and Real-Time Preview features are not available.

## Contributing

If you want to contribute please read the [Contributing](/CONTRIBUTING.md) guidelines.

## Seeking Assistance
If you find any problems or would like to suggest a feature, please feel free to file an issue on Github at [Issues Page](https://github.com/crowdin/react-native-sdk/issues).

Need help working with Crowdin React Native SDK or have any questions?
[Contact Customer Success Service](https://crowdin.com/contacts).

## Security

Crowdin React Native SDK CDN feature is built with security in mind, which means minimal access possible from the end-user is required.
When you decide to use Crowdin React Native SDK, please make sure you’ve made the following information accessible to your end-users.

- We use the advantages of Amazon Web Services (AWS) for our computing infrastructure. AWS has ISO 27001 certification and has completed multiple SSAE 16 audits. All the translations are stored at AWS servers.
- When you use Crowdin React Native SDK CDN – translations are uploaded to Amazon CloudFront to be delivered to the app and speed up the download. Keep in mind that your users download translations without any additional authentication.
- We use encryption to keep your data private while in transit.
- We do not store any Personally Identifiable Information (PII) about the end-user, but you can decide to develop the opt-out option inside your application to make sure your users have full control.
- The Automatic Screenshots and Real-Time Preview features are supposed to be used by the development team and translators team. Those features should not be compiled to the production version of your app. Therefore, should not affect end-users privacy in any way.

## License
<pre>
The Crowdin React Native SDK is licensed under the MIT License.
See the LICENSE file distributed with this work for additional
information regarding copyright ownership.

Except as contained in the LICENSE file, the name(s) of the above copyright
holders shall not be used in advertising or otherwise to promote the sale,
use or other dealings in this Software without prior written authorization.
</pre>
