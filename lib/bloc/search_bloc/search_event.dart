import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchResultEvent extends SearchEvent {
  SearchResultEvent({required this.searchKey});
  final String searchKey;
}
