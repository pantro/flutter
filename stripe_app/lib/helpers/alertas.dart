part of 'helpers.dart';

mostrarLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // evita que se cierre cuando tocan fuera, especialmente en android
    builder: (_) => const AlertDialog(
      title: Text('Espere...'),
      content: LinearProgressIndicator(),
    )
  );
}

// Alerta que la persona va a tener que darle en OK para que se cierre
mostrarAlerta(BuildContext context, String titulo, String mensaje) {
  showDialog(
    context: context, 
    barrierDismissible: false, // evita que se cierre cuando tocan fuera, especialmente en android
    builder: (_) => AlertDialog(
      title: Text(titulo),
      content: Text(mensaje),
      actions: [
        MaterialButton(
          child: const Text('Ok'),
          onPressed: () => Navigator.of(context).pop(), // Otra forma de hacer cerrar la ventana
        )
      ],
    )
  );
}