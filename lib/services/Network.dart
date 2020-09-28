import 'Storage.dart';

class Network {
  static Network shared = new Network();

  static String host = 'http://192.168.0.101:8000';//'https://zelodostavka.me';
  static String api = host + '/api';

  Map<String, String> headers() {
    String token = Storage.shared.getItem("token");
    if (token == null) {
      return {
        'Content-Type': 'application/json; charset=UTF-8'
      };
    } else {
      return {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + token
      };
    }
  }
}