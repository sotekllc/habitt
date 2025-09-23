import 'dart:convert';
import 'package:http/http.dart' as http;

/**
 * Fetches and returns a list of Countries for 
 * user registration and creation.
 * Intended to be used an initialization service
 * and not a ViewModel dependency.
 */
abstract class CountryService {
  Future<List<String>> getCountries();
}

class InMemoryCountryService implements CountryService {
  Future<List<String>> getCountries() {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        'United States',
        'Canada',
        'United Kingdom',
        'Australia',
        'India',
        'Germany',
        'France',
        'Japan',
        'China',
        'Brazil',
        'South Africa',
      ];
    });
  }
}

class HttpCountryService implements CountryService {
  Future<List<String>> getCountries() async {
    final response = await http.get(
      Uri.parse('https://api.first.org/data/v1/countries'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      Map<String, dynamic> countriesJson = responseJson['data'];
      List<String> countryList = countriesJson.values
          .map((country) => country['country'] as String)
          .toList();
      return countryList;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
