import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/pref_helper.dart';
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
    final prefHelper = PrefHelper();
    return BlocProvider(
      create: (context) => AuthCubit()..getUserData(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GetUserDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Failed to load user data: ${state.errorMessage}',
                ),
              ),
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1E293B),
                          const Color(0xFF111827),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppColors.kBordersideColor.withValues(alpha: 0.8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).push(AppRouts.editProfileScreen);
                            },
                            icon: const Icon(Icons.edit),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFF0F172A),
                              foregroundColor: AppColors.kPrimaryColor,
                            ),
                            tooltip: 'Edit profile',
                          ),
                        ),
                        CircleAvatar(
                          radius: 52,
                          backgroundColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                          backgroundImage: const AssetImage('assets/imgs/test.jpg'),
                        ),
                        Height(height: 14),
                        FutureBuilder<String?>(
                          future: prefHelper.getUserData('userName'),
                          builder: (context, snapshot) {
                            final displayName =
                                user?.name ?? snapshot.data ?? 'User Name';
                            return Text(
                              displayName,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.kWhiteColor,
                                  ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        FutureBuilder<String?>(
                          future: prefHelper.getUserData('userEmail'),
                          builder: (context, snapshot) {
                            final displayEmail =
                                user?.email ?? snapshot.data ?? 'user@example.com';
                            return Text(
                              displayEmail,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.kGreyColor,
                                  ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Height(height: 20),

                  Text(
                    'Account',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.kWhiteColor,
                        ),
                  ),
                  const Height(height: 12),

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

                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: AppColors.kPrimaryColor,
                        width: 1.5,
                      ),
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      foregroundColor: AppColors.kPrimaryColor,
                    ),
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: AppColors.kPrimaryColor,
                    ),
                    label: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
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
