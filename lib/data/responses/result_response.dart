
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Result<T> {
  final T? data;
  final String? error;

  Result({this.data, this.error});
}