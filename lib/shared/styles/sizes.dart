import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context, {double ratio = 1 }){
  return MediaQuery.of(context).size.width * ratio;
}

double getHeight(BuildContext context , {double ratio = 1 }){
  return MediaQuery.of(context).size.height * ratio ;
}

const double PADDING_VALUE = 20 ;
const double DOUBLE_PADDING_VALUE = 42 ;

const EdgeInsets PAGE_EDGES_PADDING_ALL = EdgeInsets.all(PADDING_VALUE);
const EdgeInsets PAGE_EDGES_PADDING_HORIZONTAL = EdgeInsets.symmetric(horizontal: PADDING_VALUE);
const EdgeInsets PAGE_EDGES_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: PADDING_VALUE);

const EdgeInsets ITEM_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: 7);

const EdgeInsets CONTAINER_CONTENT_PADDING_VERTICAL = EdgeInsets.symmetric(vertical: 4);
const EdgeInsets CONTAINER_CONTENT_PADDING_HORIZONTAL = EdgeInsets.symmetric(horizontal: 8);
const EdgeInsets CONTAINER_CONTENT_PADDING_ALL = EdgeInsets.all(8);