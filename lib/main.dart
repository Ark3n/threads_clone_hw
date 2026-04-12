import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/data/models/comment_model.dart';
import 'package:threads_clone/data/models/post_model.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/locator.dart';
import 'package:threads_clone/presentation/bloc/feed/feed_cubit.dart';
import 'package:threads_clone/presentation/screens/feed_screen.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load supabase key and api from .env file
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['API_URL'] ?? '',
    anonKey: dotenv.env['API_KEY'] ?? '',
  );

  // Hive DB
  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(CommentModelAdapter());
  await _seedData();

  // Dependencies (GetIt)
  await setupDependencies();
  runApp(const MyApp());
}

// MOCK data
Future<void> _seedData() async {
  final box = await Hive.openBox<PostModel>('posts');
  // Mock data Posts
  final posts = [
    Post(
      id: '1',
      content: 'Pretty day in Astana',
      authorId: '1',
      createdAt: DateTime.now().toString(),
      likes: 3,
    ),
    Post(
      id: '2',
      content: 'Working on my Flutter project',
      authorId: '2',
      createdAt: DateTime.now().toString(),
      likes: 6,
    ),
    Post(
      id: '3',
      content: 'This is my first post',
      authorId: '3',
      createdAt: DateTime.now().toString(),
      likes: 9,
    ),
  ];

  await box.putAll(
    posts.asMap().map(
      (key, post) => MapEntry(post.id, PostModel.fromEntity(post)),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCubit(locator<PostRepository>())..loadFeed(),
      child: MaterialApp(home: FeedScreen()),
    );
  }
}
