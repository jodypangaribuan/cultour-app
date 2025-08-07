class ApiConfig {
  // Google Cloud Translate API Configuration
  static const String googleTranslateApiKey = String.fromEnvironment(
    'GOOGLE_TRANSLATE_API_KEY',
    defaultValue: '<isi api disini>', // Replace with your actual API key
  );

  // You can also store other API configurations here
  static const String baseUrl = 'https://translation.googleapis.com';
  
  // For production, consider using a more secure way to store API keys
  // such as environment variables or secure storage
}
