import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileProvider with ChangeNotifier {
  Map<String, dynamic> profileData = {};

  Future<void> fetchProfile() async {
    final url = Uri.parse('https://api.mocklets.com/p6903/getProfileAPI');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      profileData = json.decode(response.body);
      notifyListeners();
    }
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider()..fetchProfile(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            if (provider.profileData.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: [
                  ProfileHeader(profile: provider.profileData),
                  SizedBox(height: 20),
                  HighlightSection(highlights: provider.profileData['highlights']),
                  SizedBox(height: 20),
                  GallerySection(gallery: provider.profileData['gallery']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final Map<String, dynamic> profile;
  ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 50,  // Adjusted for better proportion
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(profile['profile_pic']),
            ),
            Column(
              children: [
                Text(profile['posts'].toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Posts", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Text(profile['followers'].toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Followers", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            Column(
              children: [
                Text(profile['following'].toString(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("Following", style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(profile['username'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(profile['bio']['designation'],
            style: TextStyle(fontSize: 15, color: Colors.grey[700])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
          child: Text(profile['bio']['description'],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ),
        Text(profile['bio']['website'],
            style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500)),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _ProfileActionButton(icon: Icons.people, label: "Follow")),
            SizedBox(width: 5),
            Expanded(child: _ProfileActionButton(icon: Icons.message, label: "Message")),
            SizedBox(width: 5),
            Expanded(child: _ProfileActionButton(icon: Icons.call, label: "Call")),
          ],
        ),
      ],
    );
  }
}

class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  _ProfileActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[200], 
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      icon: Icon(icon, size: 18, color: Colors.black),
      label: Text(label, style: TextStyle(fontSize: 14, color: Colors.black)),
    );
  }
}


class ProfileStat extends StatelessWidget {
  final String label;
  final String value;
  ProfileStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      ],
    );
  }
}

class HighlightSection extends StatelessWidget {
  final List<dynamic> highlights;
  HighlightSection({required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: highlights.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(highlights[index]['cover']),
                ),
                SizedBox(height: 5),
                Text(highlights[index]['title'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GallerySection extends StatelessWidget {
  final List<dynamic> gallery;
  GallerySection({required this.gallery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: gallery.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPage(),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(gallery[index]['image'], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post')),
      body: Center(
        child: Column(
          children: [
            Image.network('https://random-image-pepebigotes.vercel.app/api/random-image'),
            SizedBox(height: 10),
            Text('WISHING YOU JOY', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('35 Likes', style: TextStyle(fontSize: 16)),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Thank you for this opportunity',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}