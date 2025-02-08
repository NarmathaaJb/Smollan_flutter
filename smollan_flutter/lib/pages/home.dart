import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smollan_flutter/util/bubble_stories.dart';
import 'package:smollan_flutter/util/user_posts.dart';

class UserHome extends StatelessWidget {
  final List people = ['smollan1931','elsa','zuckerberk','shreya','anshi','zoyaa','nirvin','kyia'];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Instagram',
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                Icon(Icons.add),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Icon(Icons.favorite),
                ),
                Icon(Icons.share),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // stories
          Container(
            height: 130,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: people.length,
              itemBuilder: (context, index){
              return BubbleStories(text: people[index]);
            }),
          ),

          // posts
          UserPosts(name: 'lisa'),
        ],
      ),
    );
  }
}