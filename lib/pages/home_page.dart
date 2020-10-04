import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:usersapp/services/usuario.service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final usuario = new UsuarioService();

  List usuarios = [];

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async { _cargarUsuarios(); } ,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: 
     ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuario.usersData == null ? 0 : usuario.usersData.length,
      itemBuilder: (_, i) => _usuarioListTile(i),
        )
      )
    );
  }

  

  ListTile _usuarioListTile(int index) {
    return ListTile(
      title: Text('${usuario.usersData[index]['firstName']} ${usuario.usersData[index]['lastName']}'),
      subtitle: Text('${usuario.usersData[index]['email']}'),
      leading: CircleAvatar(
        child: Text('${usuario.usersData[index]['firstName']}'.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Text('${usuario.usersData[index]['phone']}'),
    );
  }

  _cargarUsuarios() async {
    this.usuarios = await usuario.getUsers();
    setState(() {
    });
    _refreshController.refreshCompleted();
  }
}