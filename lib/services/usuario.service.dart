import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UsuarioService {

  Map data;
  List usersData;

   getUsers() async {
    http.Response response = await http.get('http://10.0.2.2:4000/api/users');
    data = json.decode(response.body);
    
    usersData = data['users'];
    
  }


}
