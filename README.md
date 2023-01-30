# interview_mockup

Android/ios Demo.

## 📌 Getting Started

1. [Install Flutter](https://flutter.io/setup/)
2. Clone this repo
3. Run `flutter run` on your terminal

## 📌 In the source code
- modular code with clean separation of business and data layer
- UI Built with detailed separation of concern,every component stands in it's own(widget),there fore easy to read and reusable 
- All static text strings are added to the localisation JSON files so as to enable internationalisation (currently only have en.json and fr.json but all words in english with out translation)
- All Color values created in a separate class,therefore make's it easy to adapt the ui for diffrent modes(theme) and this to make it confortable for different eye condtions
- Hive db used for data caching(as local data strage)
- Bloc used for state Management
_ bloc_test together with mocktail for bloc testing

#Fetures #In Android 
speak,stope speking,set volume,set rate,set pitch,set language,get language,get voice(with prefferd language)


#Fetures #In IOS 
speak,stope speking,pause speking,resume speking,set volume,set rate,set pitch,set language(only-english),get language(only english),get voice(only english)




