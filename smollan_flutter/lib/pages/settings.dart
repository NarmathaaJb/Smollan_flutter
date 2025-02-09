import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_flutter/util/theme_provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                   // Replace with actual image
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Smollan1931', // Replace with user’s name
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '@smollan1931', // Replace with username
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),

          Divider(),

          // Dark Mode Toggle
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                leading: Icon(Icons.dark_mode, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                title: Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) => themeProvider.toggleTheme(),
                  activeColor: Colors.blueAccent,
                ),
              );
            },
          ),

          Divider(),

          // More Settings (Example)
          ListTile(
            leading: Icon(Icons.lock_outline, color: Colors.blueGrey),
            title: Text(
              'Privacy & Security',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {}, // Navigate to Privacy Page
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.blueGrey),
            title: Text(
              'Help & Support',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {}, // Navigate to Help Page
          ),

          Divider(),

          ListTile(
            leading: Icon(Icons.logout, color: Colors.redAccent),
            title: Text(
              'Log Out',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.redAccent),
            ),
            onTap: () {
              // Add logout functionality
            },
          ),
        ],
      ),
    );
  }
}
