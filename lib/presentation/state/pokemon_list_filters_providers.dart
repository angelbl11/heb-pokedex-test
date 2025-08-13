import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SortMode { number, name }

final sortModeProvider = StateProvider<SortMode>((_) => SortMode.number);

final searchQueryProvider = StateProvider<String>((_) => '');
