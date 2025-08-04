import '../../domain/entities/ai_result.dart';
import '../../domain/repositories/ai_camera_repository.dart';

class AICameraRepositoryImpl implements AICameraRepository {
  @override
  Future<AIResult> detectObject() async {
    // Simulasi deteksi objek budaya
    await Future.delayed(const Duration(seconds: 2));
    return AIResult(
      label: 'Agnes Indri Patrisia Siagian',
      description: 'Pudan pudann nya abang andriiii',
    );
  }
}
