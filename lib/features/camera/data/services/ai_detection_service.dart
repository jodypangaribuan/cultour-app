import 'package:google_ml_kit/google_ml_kit.dart';
import '../models/detected_landmark_model.dart';

class AIDetectionService {
  static final List<DetectedLandmarkModel> _knownLandmarks = [
    const DetectedLandmarkModel(
      id: '1',
      name: 'Candi Borobudur',
      location: 'Magelang, Jawa Tengah',
      description: 'Candi Buddha terbesar di dunia yang merupakan warisan dunia UNESCO',
      confidence: 0.95,
      category: 'Sejarah',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCuCk0fBX7U0MCf4UlqWC3dgAvBJMWkc9BxfPlX-sX1RSkMj7VKclvc1qHbnmEQWlMt37mdsEPWwwm1wBTtOiDHS3IdUzt3THsQfWCZKPoUWIYMWbaPNBR6x0M7TlYfX3Kqm1qYjmyvUq56y6Tbd4-0RRC61UyjLSeP3HbUhwXUMQOTSlZMbDMEd39lTl6lwU1k-Ul91ieXb_QA21mxrRPlsU-mfyXUQPkd2Dr69hkFe75aXrW8aD5BMEMCrLIisw5quA_SnuRBNEKh',
      latitude: -7.6079,
      longitude: 110.2038,
    ),
    const DetectedLandmarkModel(
      id: '2',
      name: 'Menara Eiffel',
      location: 'Paris, Prancis',
      description: 'Menara besi ikonik yang menjadi simbol kota Paris',
      confidence: 0.98,
      category: 'Arsitektur',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDzfHVFPe86D2Rg-z7armxkCRixTpNRk190F8XHhLZriXEQXV8ksVHjx_xxW7v1muMFXDBv3c7liChy76SoByTD0msvYMyBpD7fiuBAwjvyPo-d6EkG90D1WxsYvUvEjqDYYU5TcsF1dMMYMfzmG1wFRn0wbh71uy_6Havuf3SYG0ZD9lH-H-9sOZ4gNh9-VEUabZI2IWTbIJwErROYEMW4Tqbb9GuNwVQ6jhLKHRy48ue_aO54zfqXVQuWOoUH828a_Gt8UzH6zpah',
      latitude: 48.8584,
      longitude: 2.2945,
    ),
    const DetectedLandmarkModel(
      id: '3',
      name: 'Monas',
      location: 'Jakarta, Indonesia',
      description: 'Monumen Nasional yang menjadi simbol kemerdekaan Indonesia',
      confidence: 0.92,
      category: 'Sejarah',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCXNwEMiLjQacBENFamjpz_Ytu304ZWoO_aKmYXZHCfvF1zWDplW7ZOoVXontc-w7x3PdDB3do4kN06c9jtrJN7YMuRG63YRf-NoQ06WYg2h4W7sqBpCuek3b698viuu6Jj5iag_BJ27JGyAT3WJrigCHcJDJGouNt7QoOd_311oFMMA0zxZsMqFIukldk8NkA-biryP3zQJ7rNbKVQmQFmrPBSJ_bY7DSub5G9jR_T2iWXqhhyurEafvDZgsWhiKQ3NZmpo0lwZN6T',
      latitude: -6.1755,
      longitude: 106.8272,
    ),
    const DetectedLandmarkModel(
      id: '4',
      name: 'Candi Prambanan',
      location: 'Yogyakarta, Indonesia',
      description: 'Kompleks candi Hindu terbesar di Indonesia',
      confidence: 0.88,
      category: 'Sejarah',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuABAcZF9Fe1kJodCJ5PoQWDGHhu3D7GFrIZpw3GTaNJrAgZdbswc7EVec_sTizEipT81HyVWxHs114t-B1iu-unHzD60TAWhgtu4sYbYwE33_X928Fk73jzgLBJf1IH9lAyTc1o-bjtDvNQC5ulK15fRPbb7MrEBjMBJnbJsTpE_rciSKpid5vZ66lcHuUPYn5DrZWyfPZpBs4oAKqEGf7yYFrVAAq2Zzmusnmyqb8qs-iGoHzTCJmnvePzkbyRdWqEYGj4oFfdqKwE',
      latitude: -7.7520,
      longitude: 110.4915,
    ),
  ];

  Future<DetectedLandmarkModel?> detectLandmark(String imagePath) async {
    try {
      // Initialize ML Kit components
      final inputImage = InputImage.fromFilePath(imagePath);
      final imageLabeler = ImageLabeler(options: ImageLabelerOptions());
      final textRecognizer = TextRecognizer();

      // Perform image labeling
      final labels = await imageLabeler.processImage(inputImage);
      final recognizedText = await textRecognizer.processImage(inputImage);

      // Simple landmark detection logic based on labels and text
      DetectedLandmarkModel? bestMatch;
      double bestScore = 0.0;

      // Check for specific landmarks based on image analysis
      for (final landmark in _knownLandmarks) {
        double score = _calculateLandmarkScore(labels, recognizedText.text, landmark);
        if (score > bestScore && score > 0.3) { // Minimum confidence threshold
          bestScore = score;
          bestMatch = landmark;
        }
      }

      // Clean up
      imageLabeler.close();
      textRecognizer.close();

      // If we found a match, return it with updated confidence
      if (bestMatch != null) {
        return DetectedLandmarkModel(
          id: bestMatch.id,
          name: bestMatch.name,
          location: bestMatch.location,
          description: bestMatch.description,
          confidence: bestScore,
          category: bestMatch.category,
          imageUrl: bestMatch.imageUrl,
          latitude: bestMatch.latitude,
          longitude: bestMatch.longitude,
        );
      }

      // If no specific landmark detected, return a generic detection for demo
      return _getGenericLandmarkForDemo(labels);

    } catch (e) {
      // Log error for debugging
      return null;
    }
  }

  double _calculateLandmarkScore(List<ImageLabel> labels, String text, DetectedLandmarkModel landmark) {
    double score = 0.0;
    
    // Check image labels
    for (final label in labels) {
      if (landmark.name.toLowerCase().contains('borobudur') && 
          (label.label.toLowerCase().contains('temple') || 
           label.label.toLowerCase().contains('building') ||
           label.label.toLowerCase().contains('architecture'))) {
        score += label.confidence * 0.8;
      }
      
      if (landmark.name.toLowerCase().contains('eiffel') && 
          (label.label.toLowerCase().contains('tower') || 
           label.label.toLowerCase().contains('metal') ||
           label.label.toLowerCase().contains('structure'))) {
        score += label.confidence * 0.9;
      }
      
      if (landmark.name.toLowerCase().contains('monas') && 
          (label.label.toLowerCase().contains('monument') || 
           label.label.toLowerCase().contains('tower') ||
           label.label.toLowerCase().contains('obelisk'))) {
        score += label.confidence * 0.8;
      }
      
      if (landmark.name.toLowerCase().contains('prambanan') && 
          (label.label.toLowerCase().contains('temple') || 
           label.label.toLowerCase().contains('building') ||
           label.label.toLowerCase().contains('stone'))) {
        score += label.confidence * 0.7;
      }
    }

    // Check recognized text
    final lowerText = text.toLowerCase();
    if (lowerText.contains(landmark.name.toLowerCase()) ||
        lowerText.contains(landmark.location.toLowerCase())) {
      score += 0.3;
    }

    return score.clamp(0.0, 1.0);
  }

  DetectedLandmarkModel? _getGenericLandmarkForDemo(List<ImageLabel> labels) {
    // For demo purposes, return Eiffel Tower if we detect tower-like structures
    for (final label in labels) {
      if (label.label.toLowerCase().contains('tower') ||
          label.label.toLowerCase().contains('building') ||
          label.label.toLowerCase().contains('architecture')) {
        return _knownLandmarks[1]; // Eiffel Tower
      }
    }
    
    // Default to Borobudur for demo
    return _knownLandmarks[0];
  }
}
