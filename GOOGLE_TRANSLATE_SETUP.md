# Google Cloud Translate API Setup

This guide will help you set up Google Cloud Translate API for the Batak translator feature in the Cultour app.

## Prerequisites

1. A Google Cloud Platform (GCP) account
2. A GCP project with billing enabled

## Setup Steps

### 1. Enable Google Cloud Translate API

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project or create a new one
3. Navigate to "APIs & Services" > "Library"
4. Search for "Cloud Translation API"
5. Click on "Cloud Translation API" and click "Enable"

### 2. Create API Credentials

1. Go to "APIs & Services" > "Credentials"
2. Click "Create Credentials" > "API Key"
3. Copy the generated API key
4. (Optional) Click on the API key to restrict it:
   - Under "API restrictions", select "Restrict key"
   - Choose "Cloud Translation API" from the list
   - Save the changes

### 3. Configure the API Key in the App

You have several options to configure your API key:

#### Option 1: Environment Variable (Recommended for production)
```bash
export GOOGLE_TRANSLATE_API_KEY="your_actual_api_key_here"
```

#### Option 2: Direct Configuration (For development/testing)
1. Open `lib/core/config/api_config.dart`
2. Replace `YOUR_GOOGLE_TRANSLATE_API_KEY` with your actual API key:
```dart
static const String googleTranslateApiKey = 'your_actual_api_key_here';
```

### 4. Test the Integration

1. Run the app: `flutter run`
2. Navigate to the Language page
3. Try translating text from English to Batak or vice versa
4. The translation should work in real-time as you type

## Supported Languages

The app currently supports translation between:
- English (en)
- Bahasa Indonesia (id)
- Batak Karo (btx)
- Batak Toba (bbc)
- Batak Simalungun (bts)
- Javanese (jv)
- Sundanese (su)

Note: Google Translate supports multiple Batak dialects with specific language codes:
- `btx` for Batak Karo
- `bbc` for Batak Toba  
- `bts` for Batak Simalungun

## Language Code Mapping

The app now uses the correct Google Translate language codes:

1. **Batak Karo (btx)**: Most commonly spoken Batak dialect
2. **Batak Toba (bbc)**: Traditional Batak dialect
3. **Batak Simalungun (bts)**: Regional Batak variant

## Troubleshooting

### Common Issues:

1. **"Translation failed" error**: Check if your API key is valid and the Translation API is enabled
2. **"Language not supported" error**: Verify the language codes are supported by Google Translate
3. **Quota exceeded**: Check your GCP billing and quota limits

### API Limits:

- Google Cloud Translation API has usage limits and pricing
- Free tier includes some free translations per month
- Monitor your usage in the GCP Console

## Security Best Practices

1. **Never commit API keys to version control**
2. **Use environment variables for production**
3. **Restrict API keys to specific services**
4. **Implement rate limiting in your app**
5. **Monitor API usage regularly**

## Alternative Implementation

If you prefer a simpler setup for development/testing, you can also use the free Google Translator package:

1. Add to pubspec.yaml:
```yaml
dependencies:
  translator: ^0.1.7
```

2. Replace the Google Cloud service with the free translator in the translation service.

However, the Google Cloud Translation API is recommended for production use due to better reliability and support.
