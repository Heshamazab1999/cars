import 'cache_helper.dart';

class CacheKeysManger {
  static String getLanguageFromCache() =>
      CacheHelper.getData(key: 'lang') ?? 'en';

  static String getUserTokenFromCache() =>
      CacheHelper.getData(key: 'userToken') ?? "NO";
}
