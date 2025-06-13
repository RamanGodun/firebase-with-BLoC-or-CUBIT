part of '../failure_entity.dart';

/// ⚙️ [GenericFailure] — system/platform issues (plugin missing, etc.)
final class GenericFailure extends Failure {
  ///---------------------------------------

  final ErrorPlugin plugin;

  GenericFailure({
    required this.plugin,
    required String super.code,
    required super.message,
    FailureKey? translationKey,
  }) : super._(
         statusCode: plugin.code,
         translationKey: translationKey?.translationKey,
       );

  @override
  List<Object?> get props => super.props..add(plugin);

  //
}
