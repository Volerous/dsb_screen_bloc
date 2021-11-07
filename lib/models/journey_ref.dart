import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'journey_ref.g.dart';

@JsonSerializable()
class JourneyDetailRef extends Equatable {
  final String? ref;

  @override
  List<Object> get props => [ref!];

  const JourneyDetailRef({this.ref});

  factory JourneyDetailRef.fromJson(Map<String, dynamic> json) =>
      _$JourneyDetailRefFromJson(json);

  Map<String, dynamic> toJson() => _$JourneyDetailRefToJson(this);
}
