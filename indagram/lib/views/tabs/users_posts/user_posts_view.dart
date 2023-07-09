import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/posts/providers/user_posts_provider.dart';
import 'package:indagram/views/components/post/posts_grid_view.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(data: (posts) {
        if (posts.isEmpty) {
          return const Text('No posts');
        } else {
          return PostsGridView(posts: posts);
        }
      }, error: (error, stackTrace) {
        return const Text('Error');
      }, loading: () {
        return const Text('Loading');
      }),
    );
  }
}
