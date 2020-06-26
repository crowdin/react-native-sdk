# react-native-crowdin

## Getting started

`$ npm install react-native-crowdin --save`

### Mostly automatic installation

`$ react-native link react-native-crowdin`

## Usage
```javascript
import Crowdin from 'react-native-crowdin';

// TODO: What to do with the module?
Crowdin;
```

## Methods

1. Initialization:

```javascript
Crowdin.initWithHashString('hash_string', 'source_language', (messages) => { })
```
- hash_string - crowdin content delivery hash.
- source_language - source language for project on crowdin platform.

Callback parameters:

- messages - An array of errors of library initialization or localization downloading. In case initialization success returns "Localization downloaded" message.

### Get localization resources 

#### Get localizations for current language

```javascript
Crowdin.getResources
```

Returns all downloaded localization for current language in JSON format as a String.

#### Get localizations for specific language

```javascript
Crowdin.getResourcesByLocale('language_code')
```
- language_code - language code to get localization.


Returns all downloaded localization for current language in JSON format as a String.

#### Output example
```
{"localization": "en", "plurals": {...}, "strings": {...}}
```

### Get localized string by key

```javascript
Crowdin.getString('key')
```

- key - localization string key.