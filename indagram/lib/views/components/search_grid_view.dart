import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/posts/providers/post_by_search_term_provider.dart';
import 'package:indagram/views/components/post/posts_sliver_grid_view.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;

  const SearchGridView({
    super.key,
    required this.searchTerm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                'Enter your search term in order to get started. You can search in the description of all posts available in the system'),
          ),
        ),
      );
    }

    final posts = ref.watch(
      postsBySearchTermProvider(
        searchTerm,
      ),
    );

    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Data not found"),
            ),
          );
        } else {
          return PostsSliverGridView(
            posts: posts,
          );
        }
      },
      error: (error, stackTrace) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Text('Error'),
          ),
        );
      },
      loading: () {
        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
