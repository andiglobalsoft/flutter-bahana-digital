part of 'routes.dart';

PagesEvent? prevPageEvant;
List<PagesEvent> _listPageEvant = [];
String? moreTag;
String? moreSearchTitle;

PagesEvent _back() {
  PagesEvent inPageEvent = _listPageEvant.last;
  _listPageEvant.removeLast();
  return inPageEvent;
}

void _from(PagesEvent pageEvant) {
  return _listPageEvant.add(pageEvant);
}

navigation(BuildContext context,
    {required PagesEvent fromEvent, required PagesEvent toEvent}) {
  _from(fromEvent);
  context.read<PagesBloc>().add(toEvent);
}

navigationClear() {
  _listPageEvant.removeRange(0, _listPageEvant.length - 1);
}

navigationPop(BuildContext context) {
  moreTag = null;
  moreSearchTitle = null;
  context.read<PagesBloc>().add(_back());
}
