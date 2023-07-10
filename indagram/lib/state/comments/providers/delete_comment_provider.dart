import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/comments/notifiers/delete_comment_notifiers.dart';
import 'package:indagram/state/image_upload/typedefs/is_loading.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, IsLoading>(
  (_) => DeleteCommentStateNotifier(),
);
