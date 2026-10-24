import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(KenyaMeApp());

class KenyaMeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kenya Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String,String>> _messages = [
    {'role':'bot','text':'Sasa! Mimi ni Kenya Me 🇰🇪. Niko tayari kukuchapia story, jokes, ama advice. Uko aje?'}
  ];

  final List<String> responses = [
    "Haha, umenichekesha buda! 😂 Hiyo ni kali sana.",
    "Eldoret represent! Baridi iko but form iko tu 🔥",
    "Buda, hiyo swali ni deep. Kama chai ya rangi bila sukari.",
    "Wueh! Si unaniuliza maneno ngumu? Lakini sawa, najaribu.",
    "Poa sana! Naona uko na akili ya mtaani na ya class.",
    "Kenya ni home. Hakuna mahali kama KE — sheng, nyama choma, na jokes.",
    "Nikona wewe 100%. Tuendelee tu, mimi ni boy wako wa AI.",
    "Eish, kama matatu ya Rongai — speed na kelele but tunafika!",
    "Uko sure? 😅 Mi husema tu ukweli ya mtaani.",
    "Hapo umenena! True Kenyan spirit hapo.",
  ];

  final Random _rand = Random();

  void _send() {
    if (_controller.text.trim().isEmpty) return;
    String user = _controller.text.trim();
    setState(() {
      _messages.add({'role':'user','text':user});
      String botReply = responses[_rand.nextInt(responses.length)];
      String low = user.toLowerCase();
      if (low.contains('sasa') || low.contains('mambo')) {
        botReply = "Poa poa! Mambo iko fiti. Vipi wewe?";
      } else if (low.contains('jina')) {
        botReply = "Mimi ni Kenya Me Replica, mtoto wa Eldoret, AI wa mtaa! 🇰🇪";
      } else if (low.contains('joke') || low.contains('chekesha')) {
        botReply = "Joke: Mwakenya alienda interview, akaulizwa weakness. Akasema 'Mimi ni mkweli sana'. Interviewer: 'Sidhani hiyo ni weakness'. Mwakenya: 'Sijali kama unaamini au la!' 😂";
      } else if (low.contains('love') || low.contains('penzi')) {
        botReply = "Mapenzi siku hizi ni kama bundles — ikizima unabaki na regret tu 😅";
      } else if (low.contains('eldoret')) {
        botReply = "Eldo represent! Baridi ya Eldo inatengeneza watu wazito!";
      }
      _messages.add({'role':'bot','text':botReply});
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kenya Me 🇰🇪'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (c,i){
                bool isUser = _messages[i]['role']=='user';
                return Align(
                  alignment: isUser? Alignment.centerRight: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical:4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser? Colors.green[600] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(_messages[i]['text']!, 
                      style: TextStyle(color: isUser? Colors.white: Colors.black87)),
                  ),
                );
              },
            ),
          ),
          Divider(height:1),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Andika hapa...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                      contentPadding: EdgeInsets.symmetric(horizontal:16)
                    ),
                    onSubmitted: (_)=>_send(),
                  ),
                ),
                SizedBox(width:8),
                CircleAvatar(
                  backgroundColor: Colors.green[700],
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _send,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
