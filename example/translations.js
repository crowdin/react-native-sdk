import LocalizedStrings from 'react-native-localization';

import en from './en.json';
import de from './de.json';
import uk from './uk.json';

export const DEFAULT_LANGUAGE = 'en';

const translations = {
  en: en,
  de: de,
  uk: uk,
};

export default new LocalizedStrings(translations);
