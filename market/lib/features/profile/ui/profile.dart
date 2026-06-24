import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/theme/app_colors.dart';
import 'package:market/features/auth/logic/cubit/auth_cubit.dart';
import 'package:market/features/auth/logic/models/user_model.dart';
import 'package:market/features/profile/widgets/custom_card_profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..getUserData(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GetUserDataFailure) {
            Center(
              child: Text('Failed to load user data: ${state.errorMessage}'),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to load user data: ${state.errorMessage}',
                ),
              ),
            );
          }
          if (state is GetUserDataLoading) {
            Center(
              child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ),
            );
          }
          if (state is GetUserDataSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('User data loaded successfully!')),
            );
          }
          if (state is LogoutLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging out...')),
            );
          }
          if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state is LogoutSuccess) {
            GoRouter.of(context).pushReplacement(AppRouts.signInScreen);
          }
          if (state is LogoutLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logging out...')),
            );
          }
          if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
          if (state is LogoutSuccess) {
            GoRouter.of(context).pushReplacement(AppRouts.signInScreen);
          }
        },
        builder: (context, state) {
          UserModel? user = context.read<AuthCubit>().userData;
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
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage('assets/imgs/test.jpg'),
                          // If the asset isn't present, Flutter will still render an empty circle.
                        ),
                        Height(height: 12),
                        Text(
                          user?.name ?? 'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Height(height: 4),
                        Text(
                          user?.email ?? 'user@example.com',
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
                    title: 'My Orders',
                    subtitle: 'View your order history',
                    onTap: () =>
                        GoRouter.of(context).push(AppRouts.myOrderScreen),
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
                      context.read<AuthCubit>().signOut();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Log out'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
