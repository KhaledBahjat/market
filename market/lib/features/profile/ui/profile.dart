import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/features/profile/widgets/custom_card_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouts.editProfileScreen);
            },
            icon: const Icon(Icons.edit),
            tooltip: 'Edit profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage('assets/imgs/test.jpg'),
                    // If the asset isn't present, Flutter will still render an empty circle.
                  ),
                  Height(height: 12),
                  Text(
                    'User Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Height(height: 4),
                  Text(
                    'user@example.com',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Height(height: 24),

            CustomCard(
              icon: Icons.favorite_border,
              title: 'Favorites',
              subtitle: 'Your saved items',
            ),

            const Height(height: 8),

            CustomCard(
              icon: Icons.history,
              title: 'Order History',
              subtitle: 'Your past orders',
            ),

            const Height(height: 8),
            CustomCard(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'Account settings',
            ),

            const Height(height: 8),

            CustomCard(
              icon: Icons.help_outline,
              title: 'Help & Support',
              subtitle: 'Get help or contact us',
            ),

            const Height(height: 24),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                // TODO: implement logout flow
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
