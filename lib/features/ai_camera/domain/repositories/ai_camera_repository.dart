import '../entities/ai_result.dart';

abstract class AICameraRepository {
  Future<AIResult> detectObject();
}
