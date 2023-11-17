import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/helpers/mostrar_alerta.dart';
import 'package:realtime_chat/services/auth_service.dart';
import 'package:realtime_chat/services/socket_service.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Logo(titulo: 'Registro',),
                  _Form(),
                  const Label(ruta: 'login', titulo: 'Ya tienes una cuenta!',  subtitulo: 'Ingresa ahora!',),
                  const Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          )
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            textController: nameCtrl,
            keyboardType: TextInputType.text,
          ),
          CustomInput(
            icon: Icons.mail_outlined,
            placeholder: 'Correo',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          Button(
            text: 'Crear cuenta',
            onPressed: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus(); // Desaparecera el teclado cuando se presiona el boton
              
              // Controlando desde el frontend que no se envie texto vacio
              if (nameCtrl.text.trim().isNotEmpty && emailCtrl.text.trim().isNotEmpty && passCtrl.text.trim().isNotEmpty) {
                final registerOk = await authService.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim());// El trim() se asegura que no haya espacios en blanco
                
                if ( registerOk == true) {
                  
                  socketService.connect();

                  if (!context.mounted) return debugPrint("El context aun no se a montado");
                  Navigator.pushReplacementNamed(context, 'usuarios');
                } else {
                  if (!context.mounted) return debugPrint("El context aun no se a montado");
                  mostrarAlerta(context, 'Registro incorrectos', registerOk['msg']);
                }
              } else {
                if (!context.mounted) return debugPrint("El context aun no se a montado");
                mostrarAlerta(context, 'Datos no completados', 'Todos los campos deben ser llenados');
              }
            },
          )
        ],
      ),
    );
  }
}
