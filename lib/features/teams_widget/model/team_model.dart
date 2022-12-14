import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_model.freezed.dart';
part 'team_model.g.dart';

@freezed
class TeamModel with _$TeamModel {
  const factory TeamModel({required String title, required List<String> members}) = _TeamModel;

  factory TeamModel.fromJson(Map<String, Object?> json)
  => _$TeamModelFromJson(json);
}
