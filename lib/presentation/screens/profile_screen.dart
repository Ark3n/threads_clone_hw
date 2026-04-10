import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_cubit.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_state.dart';
import 'package:threads_clone/presentation/widgets/profile_content.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USERNAME', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            switch (state.status) {
              case .initial:
                return Center();
              case ProfileStatus.loading:
                return Center(child: CircularProgressIndicator());
              case ProfileStatus.loaded:
                return ProfileContent(
                  posts: state.posts,
                  isOwnProfile: state.user!.id == userId ? true : false,
                );
              case ProfileStatus.failure:
                return Center(
                  child: Text(state.errorMessage ?? 'Something went wrong ('),
                );
            }
          },
        ),
      ),
    );
  }
}
