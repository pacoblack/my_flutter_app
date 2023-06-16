
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'network/dio_client.dart';
import 'network/dio_method.dart';
import 'network/dio_response.dart';

class DioUtilExample extends StatefulWidget {
  const DioUtilExample({super.key});

  @override
  DioUtilExampleState createState() => DioUtilExampleState();
}

class DioUtilExampleState extends State<DioUtilExample> {

  final CancelToken _cancelToken = CancelToken();

  void _handleLogin() async {
    // 模拟用户退出页面
    // const _timeout = Duration(milliseconds: 2000);
    // Timer.periodic(_timeout, (timer) {
    //     DioClient().cancelRequests(token: _cancelToken);
    // });

    // DioClient().openLog();
    DioClient.getInstance()?.openLog();
    // DioClient.CACHE_ENABLE = true;
    // DioClient().setProxy(proxyAddress: "https://www.baidu.com", enable: true);
    DioResponse result = await DioClient().request("/login", method: DioMethod.get, params: {
      "username": "123456",
      "password": "123456"
    }, cancelToken: _cancelToken);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DioUtilExample"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: _handleLogin,
              child: const Text("发送请求"),
            ),
          ],
        ),
      ),
    );
  }
}