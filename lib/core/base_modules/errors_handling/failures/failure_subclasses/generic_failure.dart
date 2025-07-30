part of '../failure__entity.dart';

/// ⚙️ [GenericFailure] — system/platform issues (plugin missing, etc.)
//
final class GenericFailure extends Failure {
  ///-----------------------------------
  //
  final ErrorPlugins plugin;

  GenericFailure({
    required this.plugin,
    required String super.code,
    required super.message,
    FailureKeys? translationKey,
  }) : super._(
         statusCode: plugin.code,
         translationKey: translationKey?.translationKey,
       );

  @override
  List<Object?> get props => super.props..add(plugin);

  //
}
