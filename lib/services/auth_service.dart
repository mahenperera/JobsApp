import "package:dio/dio.dart";

class AuthService {
  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final Dio dio = Dio();

    Map<String, dynamic> body = {'email': email, 'password': password};

    try {
      var response =
          await dio.post('', //Add login url
              options: Options(headers: {
                "Content-Type": "application/json",
                "ChannelId": "2",
                "ClientSecret": "" //Add ClientSecret
              }),
              data: body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print("Login successful: $data");
        return data;
      } else {
        print("Response Failed. Status code: ${response.statusCode}");
        print("Response body: ${response.data}");
        throw Exception('Failed to login');
      }
    } catch (e) {
      print("Error during login: $e");
      throw Exception('Failed to login');
    }
  }
}