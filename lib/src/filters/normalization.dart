// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library Filter.Normalization;

import '../dataset/dataset.dart';
import '../dataset/instance.dart';
import 'filter.dart';
import 'dart:math';

class NormalizationFilter extends Filter {


  NormalizationFilter() {
    this.name = "Normailization";
  }

  List<Instance> applyFilter(DataSet input) {
    if(input.isSupervised){
      for (int i = 0; i < input.numValues+input.numClassValues; i++) {
        input.setRow(i,_normalizationColumn(input.getRow(i)));
      }
    }else{
      for (int i = 0; i < input.numValues; i++) {
        input.setRow(i,_normalizationColumn(input.getRow(i)));
      }
    }

    return input.instances;
  }

  List _normalizationColumn(List <double> column) {
    num maxim = column.reduce(max);
    num minim = column.reduce(min);
    List columnNormalized = [];
    for (num i = 0; i < column.length; i++) {
      columnNormalized.add((column[i] - minim) / (maxim - minim));
    }
    return columnNormalized;
  }
}