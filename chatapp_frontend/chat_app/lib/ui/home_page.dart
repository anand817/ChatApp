import 'package:chat_app/ui/base_view.dart';
import 'package:chat_app/viemodels/chat_viemodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatViemodel>(
      onModelReady: (model) => model.onModelReady(),
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text('Chat')),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: model.messageStream,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text('Start the Chat!!'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    model.messageList.add(snapshot.data);
                    return ListView.builder(
                      itemCount: model.messageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            title: Text(model.messageList[index].toString()),
                          ),
                        );
                      },
                    );
                  }
                  return Text('Some Failure Occured');
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: model.controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      model.sendMessage(model.controller.text);
                      model.controller.clear();
                    },
                    child: Icon(Icons.send),
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
