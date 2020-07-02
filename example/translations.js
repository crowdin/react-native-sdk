import LocalizedStrings from 'react-native-localization';
import Crowdin from 'react-native-crowdin';

import en from './en.json'
import de from './de.json'

export const DEFAULT_LANGUAGE = 'en';

Crowdin.initWithHashString('00ff5d733fea380408ddc27uo3a', DEFAULT_LANGUAGE, (message) => {
  alert(message)
  alert(Crowdin.getResourcesByLocale('de'))
})

const translations = {
  en: en,
  // de: Crowdin.getResourcesByLocale('de')
  de: de
};

export default new LocalizedStrings(translations);