import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'board_page_state.dart';

class BoardPageCubit extends Cubit<BoardPageState> {
  BoardPageCubit() : super(BoardPageInitial());
  static BoardPageCubit get(ctx) => BlocProvider.of(ctx);

  List<Tab> homePageTabs = const [
    Tab(text: 'All'),
    Tab(text: 'Completed'),
    Tab(text: 'UnCompleted'),
    Tab(text: 'Favorite'),
  ];
  List tasks = [];
}
