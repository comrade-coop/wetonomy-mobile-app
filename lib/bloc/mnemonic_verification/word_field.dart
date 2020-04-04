import 'package:equatable/equatable.dart';

class WordField extends Equatable {
  final String word;
  final bool selected;

  WordField(this.word, this.selected)
      : assert(word != null),
        assert(selected != null),
        super([word, selected]);
}
