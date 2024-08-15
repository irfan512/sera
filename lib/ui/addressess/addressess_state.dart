
import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class AddressessState extends Equatable {
  final String sizeIndex;
  final String lengthIndex;
  final DataEvent addressessData;

  const AddressessState(
      {required this.sizeIndex,
      required this.lengthIndex,
      required this.addressessData});

  const AddressessState.initial()
      : this(
          sizeIndex: "",
          lengthIndex: "",
          addressessData: const Initial(),
        );

  AddressessState copyWith({
    String? sizeIndex,
    String? lengthIndex,
    DataEvent? addressessData,
  }) =>
      AddressessState(
        sizeIndex: sizeIndex ?? this.sizeIndex,
        addressessData: addressessData ?? this.addressessData,
        lengthIndex: lengthIndex ?? this.lengthIndex,
      );

  @override
  List<Object> get props => [
        sizeIndex,
        lengthIndex,
        addressessData,
      ];

  @override
  bool get stringify => true;
}
