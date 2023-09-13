part of 'symbols_bloc.dart';

@immutable
sealed class SymbolsState {}

final class SymbolsInitial extends SymbolsState {}
 class SymbolsBlocInitialFetchSuccessState extends SymbolsState {
  final List<List<GroupModel>>  symbols;
  List<Map<String, dynamic>> sortResult = [];

  SymbolsBlocInitialFetchSuccessState({required this.symbols,required this.sortResult});
  
}

final class SymbolsBlocInitialFetchLoadingState extends SymbolsState {}

final class SymbolsFetchErrorState extends SymbolsState {}
final class SymbolsAddedToGroupSuccessState extends SymbolsState {
  final List<Map<String, dynamic>> result;
  SymbolsAddedToGroupSuccessState({required this.result});
}
final class OpenBottomSheetSuccessEvent extends SymbolsState {}
