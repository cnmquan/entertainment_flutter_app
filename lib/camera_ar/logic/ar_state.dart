import 'package:equatable/equatable.dart';
import 'package:flutter_camera_app/camera_ar/model/ar_filter_model.dart';
import 'package:flutter_camera_app/camera_ar/utils.dart';

class DeepArState extends Equatable {
  final Status? status;
  final ArModel? filter;
  final ArModel? effect;
  final ArModel? masked;
  final String? path;

  const DeepArState({
    this.status,
    this.filter,
    this.effect,
    this.masked,
    this.path,
  });

  DeepArState copyWith({
    Status? status,
    ArModel? filter,
    ArModel? masked,
    ArModel? effect,
    String? path,
  }) {
    return DeepArState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      masked: masked ?? this.masked,
      effect: effect ?? this.effect,
      path: path ?? this.path,
    );
  }

  @override
  List<Object?> get props => [
        status,
        filter,
        masked,
        effect,
        path,
      ];

  @override
  bool? get stringify => true;
}
