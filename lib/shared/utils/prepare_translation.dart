import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
const String directory = "H:/work/flutter_projects/manzel" ;
main(){

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

_prepareFileToChanges({required File file}){

}