import '../models/attraction_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<AttractionModel>> getFeaturedAttractions();
  Future<List<AttractionModel>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  });
  Future<List<AttractionModel>> searchAttractions(String query);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // Mock data for demonstration
  final List<AttractionModel> _mockAttractions = [
    const AttractionModel(
      id: '1',
      name: 'Candi Borobudur',
      description: 'Candi Buddha terbesar di dunia yang merupakan warisan dunia UNESCO',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCuCk0fBX7U0MCf4UlqWC3dgAvBJMWkc9BxfPlX-sX1RSkMj7VKclvc1qHbnmEQWlMt37mdsEPWwwm1wBTtOiDHS3IdUzt3THsQfWCZKPoUWIYMWbaPNBR6x0M7TlYfX3Kqm1qYjmyvUq56y6Tbd4-0RRC61UyjLSeP3HbUhwXUMQOTSlZMbDMEd39lTl6lwU1k-Ul91ieXb_QA21mxrRPlsU-mfyXUQPkd2Dr69hkFe75aXrW8aD5BMEMCrLIisw5quA_SnuRBNEKh',
      latitude: -7.6079,
      longitude: 110.2038,
      categories: ['Sejarah', 'Budaya', 'Religi'],
      rating: 4.8,
    ),
    const AttractionModel(
      id: '2',
      name: 'Taman Nasional Komodo',
      description: 'Rumah bagi komodo, kadal terbesar di dunia',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCXNwEMiLjQacBENFamjpz_Ytu304ZWoO_aKmYXZHCfvF1zWDplW7ZOoVXontc-w7x3PdDB3do4kN06c9jtrJN7YMuRG63YRf-NoQ06WYg2h4W7sqBpCuek3b698viuu6Jj5iag_BJ27JGyAT3WJrigCHcJDJGouNt7QoOd_311oFMMA0zxZsMqFIukldk8NkA-biryP3zQJ7rNbKVQmQFmrPBSJ_bY7DSub5G9jR_T2iWXqhhyurEafvDZgsWhiKQ3NZmpo0lwZN6T',
      latitude: -8.5569,
      longitude: 119.4473,
      categories: ['Alam', 'Satwa', 'Petualangan'],
      rating: 4.7,
    ),
    const AttractionModel(
      id: '3',
      name: 'Raja Ampat',
      description: 'Surga bawah laut dengan keanekaragaman hayati terkaya',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuABAcZF9Fe1kJodCJ5PoQWDGHhu3D7GFrIZpw3GTaNJrAgZdbswc7EVec_sTizEipT81HyVWxHs114t-B1iu-unHzD60TAWhgtu4sYbYwE33_X928Fk73jzgLBJf1IH9lAyTc1o-bjtDvNQC5ulK15fRPbb7MrEBjMBJnbJsTpE_rciSKpid5vZ66lcHuUPYn5DrZWyfPZpBs4oAKqEGf7yYFrVAAq2Zzmusnmyqb8qs-iGoHzTCJmnvePzkbyRdWqEYGj4oFfdqKwE',
      latitude: -0.2149,
      longitude: 130.5201,
      categories: ['Laut', 'Diving', 'Alam'],
      rating: 4.9,
    ),
    const AttractionModel(
      id: '4',
      name: 'Danau Toba',
      description: 'Danau vulkanik terbesar di Indonesia dan Pulau Samosir',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAzb0qTvWkrT3PPPmR4HPB4IUdU24GkcCYPmir-NiiD6hKyOn96VQ6k97gXaneFiJN49-3Aq0h6HAYnkdJX_HZw0gGEryVmb3SAygAKrRsTDCUIuQ9ColIMCNK2SlJt7x-bn5yo5ev4CG6MVTIONyf5wm7CGau4s6bAn2V8XA2BPJyEZlySQ4gyVI2qniTfvRhADM9SdP6LZLwNOt-8I2JezigshHTo2bagnF2UxZC8KzTFUvwUXjHrYLo14NPwmwRwfOr8fLn3vmBr',
      latitude: 2.6845,
      longitude: 98.8756,
      categories: ['Alam', 'Danau', 'Budaya'],
      rating: 4.6,
    ),
  ];

  @override
  Future<List<AttractionModel>> getFeaturedAttractions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockAttractions;
  }

  @override
  Future<List<AttractionModel>> getNearbyAttractions({
    required double latitude,
    required double longitude,
    double radius = 10.0,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Mock: return attractions within radius (simplified)
    return _mockAttractions.take(2).toList();
  }

  @override
  Future<List<AttractionModel>> searchAttractions(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockAttractions
        .where((attraction) =>
            attraction.name.toLowerCase().contains(query.toLowerCase()) ||
            attraction.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
