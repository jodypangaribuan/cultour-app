import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final String code;
  final String name;
  final String displayName;

  const Language({
    required this.code,
    required this.name,
    required this.displayName,
  });

  @override
  List<Object?> get props => [code, name, displayName];

  @override
  String toString() {
    return 'Language(code: $code, name: $name, displayName: $displayName)';
  }

  // Predefined languages for the app
  static const List<Language> supportedLanguages = [
    Language(code: 'auto', name: 'Auto Detect', displayName: 'Auto Detect'),
    Language(code: 'en', name: 'English', displayName: 'English'),
    Language(code: 'id', name: 'Indonesian', displayName: 'Bahasa Indonesia'),
    Language(code: 'btx', name: 'Batak Karo', displayName: 'Batak Karo'),
    Language(code: 'bbc', name: 'Batak Toba', displayName: 'Batak Toba'),
    Language(code: 'bts', name: 'Batak Simalungun', displayName: 'Batak Simalungun'),
    Language(code: 'jv', name: 'Javanese', displayName: 'Javanese'),
    Language(code: 'su', name: 'Sundanese', displayName: 'Sundanese'),
  ];

  // Languages available for target translation (excluding auto-detect)
  static List<Language> get targetLanguages => supportedLanguages.where((lang) => lang.code != 'auto').toList();

  static Language getLanguageByCode(String code) {
    try {
      return supportedLanguages.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return const Language(code: 'unknown', name: 'Unknown', displayName: 'Unknown');
    }
  }
}
