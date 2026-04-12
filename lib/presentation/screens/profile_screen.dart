import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/data/datasources/local_post_data_source.dart';
import 'package:threads_clone/data/repositories/post_repository_impl.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_cubit.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_state.dart';
import 'package:threads_clone/presentation/widgets/profile_content.dart';
import 'package:threads_clone/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});
  final String userId;

  static MaterialPageRoute route(BuildContext context, String userId) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              ProfileCubit(PostRepositoryImpl(LocalPostDataSource()))
                ..loadProfile(userId),
          child: ProfileScreen(userId: userId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Text(state.user?.username ?? 'dafault');
          },
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.status == .failure) {
            return Column(
              children: [
                Text(state.errorMessage ?? 'Something went wrong'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileCubit>().loadProfile(userId);
                  },
                  child: Text('Retry'),
                ),
              ],
            );
          }
          return Column(
            children: [
              ProfileHeader(user: state.user!, isOwnProfile: userId == 'me'),
              ProfileContent(posts: state.posts, isOwnProfile: userId == "me"),
            ],
          );
        },
      ),
    );
  }
}
