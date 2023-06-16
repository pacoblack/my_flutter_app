
import 'package:dio/dio.dart';
import 'package:flutter_world/lock.dart';

class DioTokenInterceptors extends QueuedInterceptor {
  Lock lock = Lock();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers['refreshToken'] == null) {
      lock.lock();
      Dio tokenDio = Dio();
      var dio = tokenDio..get("http://localhost:8080/getRefreshToken").then((d) {
        options.headers['refreshToken'] = d;
        handler.next(options);
      }).catchError((error, stackTrace) {
        handler.reject(error, true);
      }).whenComplete(() {
        lock.unlock();
      }); // unlock the dio
    } else {
      options.headers['refreshToken'] = options.headers['refreshToken'];
      handler.next(options);
    }
  }


}