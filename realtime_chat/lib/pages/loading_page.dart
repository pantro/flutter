import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/pages/login_page.dart';
import 'package:realtime_chat/pages/usuarios_page.dart';
import 'package:realtime_chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {

  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context), 
        builder: (context, snapshot) {
          return const Center(
            child: Text('Revisando...'),
          );
        }
      )
    );
  }

  Future checkLoginState( BuildContext context ) async {
    
    final authService = Provider.of<AuthService>(context, listen: false); //Listen false por que no necesito redibujar nada
    
    final autenticado = await authService.isLoggedIn();
    
    if (!context.mounted) return debugPrint("El context aun no se a montado");
    
    if (autenticado) {
      // Se hizo de esta forma para que tenga una transicion mas rapida
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ____) => const UsuariosPage(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ____) => const LoginPage(),
          transitionDuration: const Duration(milliseconds: 0)
        )
      );
    }

  }
}
