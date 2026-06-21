import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Google Gemini"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text("Prompt básico de Gemini"),
              subtitle: const Text("Usando modelo flash"),
              onTap: () => context.push('/basic-prompt'),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.watch_later_outlined,
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text("Chat conversacional con Gemini"),
              subtitle: const Text("Gemini recuerda el contexto"),
              onTap: () => context.push('/history-chat'),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.watch_later_outlined,
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text("Chat de generacion de Imagenes con Gemini"),
              subtitle: const Text("Gemini recuerda el contexto"),
              onTap: () => context.push('/history-chat-image-generator'),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(
                  Icons.image_outlined,
                  color: Colors.white,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text("Generacion de imagenes"),
              subtitle: const Text("Genera o edita imagenes"),
              onTap: () => context.push('/image-playground'),
            )
          ],
        ),
      ),
    );
  }
}
