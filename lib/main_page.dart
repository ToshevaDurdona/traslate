import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:translator/translator.dart';
 String translated ='Translation';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.translate),
        title: const Text('translation'),
      ),
      body: Card(
        margin: const EdgeInsets.all(12),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('English(US)'),
            const SizedBox(height: 8,),
            TextField(
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter text',
              ),
              onChanged: (text)async{
                const apiKey='10395562431f436cb3c8b019e16ac16a';
                const to='uz';
                final url=Uri.parse('https://translation.googleapis.com/language/translate/v2'
                '?q=$text &target=$to &key=$apiKey',
                );
                var http;
                final response= await http.post(url);
                if(response.statusCode==200){
                  final body=json.decode(response.body);
                  final translations=body['data']['tranlations'] as List;
                  final translation= HtmlUnescape().convert(
                    translations.first['translatedText'],
                  );
                }
               final translation =await text.translate(
                  from: 'en',
                  to: 'uz',
                );
                setState((){
                  translated=translation.text;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
