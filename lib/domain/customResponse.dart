class CustomResponse {
  int? _code;
  String? _title;
  dynamic _body;


  CustomResponse(this._code, this._title, this._body);

  dynamic get body => _body;

  set body(dynamic value) {
    _body = value;
  }

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  int? get code => _code;

  set code(int? value) {
    _code = value;
  }
}
