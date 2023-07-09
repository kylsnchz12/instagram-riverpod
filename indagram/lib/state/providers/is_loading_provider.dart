import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/auth/providers/auth_state_provider.dart';
import 'package:indagram/state/image_upload/providers/image_uploader_provider.dart';

final isLoadingProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploaderProvider);
  return authState.isLoading || isUploadingImage;
});
