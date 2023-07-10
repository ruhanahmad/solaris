import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';


class Links extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Links'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('links').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final linkDocuments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: linkDocuments.length,
            itemBuilder: (context, index) {
              final link = linkDocuments[index].data() as Map<String, dynamic>;
              final linkText = link['title'];
              final youtubeUrl = link['url'];

              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: mediaQuery.size.height * 0.01,
                  horizontal: mediaQuery.size.width * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () => _launchURL(youtubeUrl),
                  child: Text(linkText),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
