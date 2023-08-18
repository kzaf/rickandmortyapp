class Strings {
  static String homePageTitle = 'Rick and Morty';
  static String baseUrl = 'https://rickandmortyapi.com/api/';
  static String charactersRoute = 'character/';

  static String genericErrorMessage = 'Something went wrong';
  static String connectionErrorMessage = 'Connection issue';
  static String fetchedAllMessage = 'Thats all!';
  static String fetchErrorMessage =
      'Failed to get data, please check your connection';
  static String imageNotFound =
      'https://rickandmortyapi.com/api/character/avatar/19.jpeg';

  static String emptyString = '';
  static String unknown = 'Unknown';
  static String deadStatus = 'Dead';
  static String aliveStatus = 'Alive';

  static String homePageLastKnownLocationLabel = 'Last known location:';
  static String homePageFirstSeenInLabel = 'First seen in:';

  static String detailsPageLabelStatus = 'Status';
  static String detailsPageLabelGender = 'Gender';
  static String detailsPageLabelSpecies = 'Species';
  static String detailsPageLabelLastKnownLocation = 'Last known location';
  static String detailsPageLabelOrigin = 'Origin';
  static String detailsPageLabelNumberOfEpisodes = 'Number of episodes';
  static String detailsPageLabelEpisodes = 'Episodes';
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
