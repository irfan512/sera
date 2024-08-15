import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class ProfileScreenState extends Equatable {
  final String userImage;
  final DataEvent currentUserData;

  const ProfileScreenState({
    required this.currentUserData,
    required this.userImage,
  });

  const ProfileScreenState.initial()
      : this(
          currentUserData: const Initial(),
          userImage: "",
        );

  ProfileScreenState copyWith({
    String? userImage,
    DataEvent? currentUserData,
  }) =>
      ProfileScreenState(
        currentUserData: currentUserData ?? this.currentUserData,
        userImage: userImage ?? this.userImage,
      );

  @override
  List<Object> get props => [
        currentUserData,
        userImage,
      ];

  @override
  bool get stringify => true;
}
