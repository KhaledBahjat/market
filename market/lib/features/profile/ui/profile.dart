import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:market/core/helper/spacing.dart';
import 'package:market/core/routing/app_routs.dart';
import 'package:market/core/widgets/error_widget.dart';
import 'package:market/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:market/features/profile/widgets/custom_card_profile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthCubit>().loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          context.goNamed(AppRouts.signInScreen);
        }

        if (state is SignOutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }

        if (state is GetUserDataError) {
          showDialog(
            context: context,
            builder: (context) {
              return CustomErrorDialog(
                message: state.errorMessage,
                onPressed: () {
                  context.pop();
                },
              );
            },
          );
        }
      },

      builder: (context, state) {
        final isLoading = state is GetUserDataLoading;
        final user = state is GetUserDataSuccess ? state.user : null;

        return Skeletonizer(
          enabled: isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRouts.editProfileScreen,
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),

            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  const CircleAvatar(
                    radius: 48,
                    backgroundImage: AssetImage(
                      'assets/imgs/test.jpg',
                    ),
                  ),

                  const Height(height: 12),

                  Text(
                    user?.name ?? 'User Name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Height(height: 4),

                  Text(
                    user?.email ?? 'user@example.com',
                    style: const TextStyle(
                      color: Colors.grey,
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
                    onTap: () {
                      context.pushNamed(
                        AppRouts.myOrderScreen,
                      );
                    },
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

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final isLoggingOut = state is SignOutLoading;

                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                        ),
                        onPressed: isLoggingOut
                            ? null
                            : () {
                                context.read<AuthCubit>().signOut();
                              },
                        icon: isLoggingOut
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.logout),
                        label: Text(
                          isLoggingOut ? 'Logging out...' : 'Log out',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
