import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bahana_digital/services/services.dart';

part 'data_list_ebook_event.dart';
part 'data_list_ebook_state.dart';

class DataListEbookBloc extends Bloc<DataListEbookEvent, DataListEbookState> {
  DataListEbookBloc() : super(DataListEbookInitial()) {
    on<FetchDataListEbookEvent>((event, emit) async {
      DataListEbookModel dataListEbookModel =
          await ListEbookServices.getListEbook();
      emit(DataListEbookLoaded(dataListEbookModel: dataListEbookModel));
    });
  }
}
