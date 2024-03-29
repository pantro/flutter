import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/services/usuarios_service.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  UsuariosPageState createState() => UsuariosPageState();
}

class UsuariosPageState extends State<UsuariosPage> {
  final usuariosService = UsuariosService();
  List<Usuario> usuarios = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  /*final usuarios = [
    Usuario(
        online: true, email: 'email_1@gmail', nombre: 'nombre_1', uid: 'uid_1'),
    Usuario(
        online: false,
        email: 'email_2@gmail',
        nombre: 'nombre_2',
        uid: 'uid_2'),
    Usuario(
        online: true, email: 'email_3@gmail', nombre: 'nombre_3', uid: 'uid_3'),
    Usuario(
        online: false,
        email: 'email_4@gmail',
        nombre: 'nombre_4',
        uid: 'uid_4'),
    Usuario(
        online: true, email: 'email_5@gmail', nombre: 'nombre_5', uid: 'uid_5'),
  ];*/

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario!.nombre,
          style: const TextStyle(color: Colors.black45),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            socketService.disconnect();

            // Saca al usuario de la pantalla actual
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken(); //Elimina el token
          },
          icon: const Icon(Icons.exit_to_app, color: Colors.black45),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: socketService.serverStatus == ServerStatus.Online
                ? Icon(Icons.check_circle, color: Colors.blue[400])
                : const Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: _cargarUsuarios,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue,
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');//PushNamed me permite regresar a la pantalla anterior deslizando del lado izquierdo al derecho con el dedo
      },
    );
  }

  _cargarUsuarios() async {
    //await Future.delayed(const Duration(milliseconds: 1000));
    usuarios = await usuariosService.getUsuarios();

    setState(() {}); // Actualiza el estado

    refreshController.refreshCompleted();
  }
}
