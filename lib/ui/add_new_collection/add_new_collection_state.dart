import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class AddCollectionState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool collectionNameValidate;
  final bool lastNameValidate;
  final bool mobileNumberValidate;
  final DataEvent fileDataEvent;

  const AddCollectionState({
    required this.pagerIndex,
    required this.errorText,
    required this.collectionNameValidate,
    required this.lastNameValidate,
    required this.mobileNumberValidate,
    required this.fileDataEvent,
  });

  const AddCollectionState.initial()
      : this(
          pagerIndex: 0,
          errorText: '',
          fileDataEvent: const Initial(),
          collectionNameValidate: false,
          lastNameValidate: false,
          mobileNumberValidate: false,
        );

  AddCollectionState copyWith({
    int? pagerIndex,
    String? errorText,
    bool? collectionNameValidate,
    bool? lastNameValidate,
    bool? mobileNumberValidate,
    DataEvent? fileDataEvent,
  }) =>
      AddCollectionState(
        fileDataEvent: fileDataEvent ?? this.fileDataEvent,
        pagerIndex: pagerIndex ?? this.pagerIndex,
        errorText: errorText ?? this.errorText,
        collectionNameValidate:
            collectionNameValidate ?? this.collectionNameValidate,
        lastNameValidate: lastNameValidate ?? this.lastNameValidate,
        mobileNumberValidate: mobileNumberValidate ?? this.mobileNumberValidate,
      );

  @override
  List<Object> get props => [
        fileDataEvent,
        pagerIndex,
        errorText,
        collectionNameValidate,
        lastNameValidate,
        mobileNumberValidate,
      ];

  @override
  bool get stringify => true;
}
