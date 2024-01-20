import '../../utilities/const.dart';

class APICourse {
  static const String BASE_URL = ConstValue.BASE_URL;

  static String getDetailCourse(String id) => '${BASE_URL}course/$id';

  // static String getCourse(int page, int size, String orderBy, String order, int level, String categoryStr, String search){
  //   return '${BASE_URL}course?page=$page&size=$size&level[]=$level&order[]=$order&orderBy[]=$orderBy&$categoryStr&q=$search';
  // }
  //
  // static String getEbook(int page, int size, String orderBy, String order, int level, String categoryStr, String search){
  //   return '${BASE_URL}e-book?page=$page&size=$size&level[]=$level&order[]=$order&orderBy[]=$orderBy&q=$search&$categoryStr';
  // }
  //
  // static String getInteractiveEbook(int page, int size, String orderBy, String order, int level, String categoryStr, String search){
  //   return '${BASE_URL}material/interactive-e-book?page=$page&size=$size&level[]=$level&order[]=$order&orderBy[]=$orderBy&$categoryStr&q=$search';
  // }

  static String buildUrl(String path, int page, int size, String? orderBy,
      String? order, int? level, String? categoryStr, String? search) {
    final Map<String, dynamic> parameters = {
      'page': page,
      'size': size,
      if (orderBy != null) 'orderBy': [orderBy],
      if (order != null) 'order': [order],
      if (level != null) 'level': [level],
      if (categoryStr != null) 'categoryStr': [categoryStr],
      if (search != null) 'q': [search],
    };

    final List<String> params = parameters.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${entry.value is List ? entry.value.join(',') : entry.value}')
        .toList();

    return '$BASE_URL$path?${params.join('&')}';
  }

  static String getCourse(int page, int size, String? orderBy, String? order,
      int? level, String? categoryStr, String? search) {
    return buildUrl(
        'course', page, size, orderBy, order, level, categoryStr, search);
  }

  static String getEbook(int page, int size, String? orderBy, String? order,
      int? level, String? categoryStr, String? search) {
    return buildUrl(
        'e-book', page, size, orderBy, order, level, categoryStr, search);
  }

  static String getInteractiveEbook(int page, int size, String? orderBy, String? order,
      int? level, String? categoryStr, String? search) {
    return buildUrl('material/interactive-e-book', page, size, orderBy, order,
        level, categoryStr, search);
  }
}
