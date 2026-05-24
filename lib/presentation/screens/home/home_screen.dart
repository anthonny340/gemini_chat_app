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
            )
          ],
        ),
      ),
    );
  }
}
