import 'package:debug_no_cell/Models/Cultura.dart';
import 'package:http/http.dart' as http;

abstract class IHttpCultura {
  Future get({required String url});
}

class HttpCultura implements IHttpCultura {
  final usuario = http.Client();

  @override
  Future get({required String url}) async {
    return await usuario.get(Uri.parse(url));
  }
}
