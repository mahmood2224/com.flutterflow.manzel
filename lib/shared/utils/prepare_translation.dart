import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
const String directory = "H:/work/flutter_projects/manzel" ;
main(){
  _prepareFileToChanges(file: File('$directory/lib/login/login_widget.dart'));
}

void _searchAndPrepare({Directory? dir }){
  Directory project = dir ?? new Directory("$directory/lib");
  List contents = project.listSync();
  for(var dirOrFile in contents){
    if(dirOrFile is File){
      print ("File Name : ${ basename(dirOrFile.path)} in directorry ${basename(project.path)}");
      _prepareFileToChanges(file: dirOrFile);
    }else {
      _searchAndPrepare(dir: dirOrFile);
    }
  }
}
///'FFLocalizations.of\(context\).getText\([a-zA-Z0-9, \/*\'|\n]+\)[,;]'
_prepareFileToChanges({required File file}){
  String content = file.readAsStringSync();
  String subContent = file.readAsLinesSync().join('').replaceAll(' ', '');
  RegExp regExp = new RegExp(r"FFLocalizations.of\([context]+\).getText\([a-zA-Z0-9', /*]+\)[,;]",multiLine: true ,caseSensitive: true);
  Iterable<RegExpMatch> matches = regExp.allMatches(subContent);
  int size = matches.length ;

}