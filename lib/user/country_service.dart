/**
 * Fetches and returns a list of Countries for 
 * user registration and creation.
 * Intended to be used an initialization service
 * and not a ViewModel dependency.
 */
abstract class CountryService {
  List<String> getCountries();
}

class InMemoryCountryService implements CountryService {
  List<String> getCountries() {
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
  }
}

// class HttpCountryService implements CountryService {
//   List<String> getCountries() {}
// }
