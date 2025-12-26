import 'package:dio/dio.dart';
import '../../../core/app_exception.dart';
import 'dto.dart';

class OpenLibraryApi {
  OpenLibraryApi(this._dio);

  final Dio _dio;

  static const String listUrl =
      'https://openlibrary.org/subjects/love.json?limit=10';

  Future<WorksDto> fetchLoveBooks() async {
    try {
      final res = await _dio.get(listUrl);
      if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
        return WorksDto.fromJson(res.data as Map<String, dynamic>);
      }
      throw const ApiException('Gagal memuat data. Coba lagi ya.');
    } on DioException catch (e) {
      // Offline / timeout / DNS, dll.
      final type = e.type;
      final isNetwork = type == DioExceptionType.connectionError ||
          type == DioExceptionType.connectionTimeout ||
          type == DioExceptionType.receiveTimeout ||
          type == DioExceptionType.sendTimeout ||
          (e.error != null);

      if (isNetwork) {
        throw const NoInternetException('Koneksi terputus. Cek internet kamu ya...');
      }
      throw const ApiException('Terjadi kendala jaringan. Coba lagi.');
    } catch (_) {
      throw const ApiException('Terjadi error tak terduga. Coba lagi.');
    }
  }
}
