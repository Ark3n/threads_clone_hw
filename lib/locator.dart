import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/data/datasources/local_comment_data_source.dart';
import 'package:threads_clone/data/datasources/local_post_data_source.dart';
import 'package:threads_clone/data/datasources/remote_comment_data_source.dart';
import 'package:threads_clone/data/datasources/remote_post_data_source.dart';
import 'package:threads_clone/data/repositories/comment_repository_impl.dart';
import 'package:threads_clone/data/repositories/post_repository_impl.dart';
import 'package:threads_clone/domain/repositories/comment_repository.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  // MARK: - external services
  locator.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  locator.registerLazySingleton<ImagePicker>(() => ImagePicker());

  // MARK: - datasources
  locator.registerLazySingleton<LocalPostDataSource>(
    () => LocalPostDataSource(),
  );
  locator.registerLazySingleton<LocalCommentDataSource>(
    () => LocalCommentDataSource(),
  );
  locator.registerLazySingleton<RemotePostDataSource>(
    () => RemotePostDataSource(locator<SupabaseClient>()),
  );
  locator.registerLazySingleton<RemoteCommentDataSource>(
    () => RemoteCommentDataSource(locator<SupabaseClient>()),
  );

  // MARK: - repositories
  locator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      locator<LocalPostDataSource>(),
      locator<RemotePostDataSource>(),
    ),
  );

  locator.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(
      locator<LocalCommentDataSource>(),
      locator<RemoteCommentDataSource>(),
    ),
  );
}
