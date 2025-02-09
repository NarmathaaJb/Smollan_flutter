import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FeedProvider with ChangeNotifier {
  List<dynamic> stories = [];
  List<dynamic> posts = [];

  Future<void> fetchFeed() async {
    final url = Uri.parse('https://api.mocklets.com/p6903/getFeedAPI');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      stories = data['stories'];
      posts = data['posts'];
      notifyListeners();
    }
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FeedProvider()..fetchFeed(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Feed Page', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: Consumer<FeedProvider>(
          builder: (context, provider, child) {
            if (provider.stories.isEmpty && provider.posts.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StorySection(stories: provider.stories),
                  PostSection(posts: provider.posts),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StorySection extends StatelessWidget {
  final List<dynamic> stories;
  StorySection({required this.stories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.orange, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(stories[index]['profile_pic']),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  stories[index]['username'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PostSection extends StatelessWidget {
  final List<dynamic> posts;
  PostSection({required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: posts.map((post) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          shadowColor: Colors.grey.withOpacity(0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(post['profile_pic']),
                ),
                title: Text(post['username'], style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("2h ago", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ),
              
              // Post Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(post['image'], height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              
              // Likes & Captions
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${post['likes']} likes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: post['username'] + " ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: post['caption']),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "View all 12 comments",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
