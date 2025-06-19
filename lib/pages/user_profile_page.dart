// TODO Implement this library.import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  // These will be managed by Provider in your implementation
  String userName = 'John Doe';
  String userEmail = 'john.doe@example.com';
  String userBio = 'Flutter developer passionate about creating beautiful mobile experiences.';
  String userLocation = 'San Francisco, CA';
  String profileImageUrl = 'https://via.placeholder.com/150';
  bool isFollowing = false;
  int followersCount = 1234;
  int followingCount = 567;
  int postsCount = 89;
  bool isOnline = true;
  
  // Settings that could be managed by Provider
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  bool privateProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditProfileDialog(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'settings':
                  Navigator.pushNamed(context, '/settings');
                  break;
                case 'logout':
                  _showLogoutDialog();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Picture with Online Status
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImageUrl),
                        onBackgroundImageError: (_, __) => setState(() {
                          profileImageUrl = 'https://via.placeholder.com/150';
                        }),
                      ),
                      if (isOnline)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // User Name and Email
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        userLocation,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Bio
                  Text(
                    userBio,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  
                  // Follow Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isFollowing = !isFollowing;
                          followersCount += isFollowing ? 1 : -1;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(isFollowing ? 'Following!' : 'Unfollowed'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(isFollowing ? 'Following' : 'Follow'),
                    ),
                  ),
                ],
              ),
            ),
            
            // Stats Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Posts', postsCount),
                  _buildStatDivider(),
                  _buildStatColumn('Followers', followersCount),
                  _buildStatDivider(),
                  _buildStatColumn('Following', followingCount),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Quick Settings
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Quick Settings',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildSettingTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Receive push notifications',
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    subtitle: 'Switch to dark theme',
                    value: darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        darkModeEnabled = value;
                      });
                    },
                  ),
                  _buildDivider(),
                  _buildSettingTile(
                    icon: Icons.lock,
                    title: 'Private Profile',
                    subtitle: 'Only followers can see your posts',
                    value: privateProfile,
                    onChanged: (value) {
                      setState(() {
                        privateProfile = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action Buttons
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildActionButton(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () => _showEditProfileDialog(),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.history,
                    title: 'Activity History',
                    onTap: () => _showActivityHistory(),
                  ),
                  const SizedBox(height: 12),
                  _buildActionButton(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () => _showHelpDialog(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[200],
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userName);
    final bioController = TextEditingController(text: userBio);
    final locationController = TextEditingController(text: userLocation);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userBio = bioController.text;
                userLocation = locationController.text;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated!')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showActivityHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Activity History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text('Liked 5 posts'),
              subtitle: Text('2 hours ago'),
            ),
            const ListTile(
              leading: Icon(Icons.comment, color: Colors.blue),
              title: Text('Commented on a post'),
              subtitle: Text('4 hours ago'),
            ),
            const ListTile(
              leading: Icon(Icons.person_add, color: Colors.green),
              title: Text('Started following 3 users'),
              subtitle: Text('1 day ago'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Text(
          'Need help? Contact our support team at support@example.com or visit our FAQ section.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}