// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Filter.Normalization;

import '../dataset/dataset_export.dart';
import 'filter.dart';
import 'dart:math';

class NormalizationFilter implements Filter {


  NormalizationFilter() {}

  List<Instance> applyFilter(DataSet input) {
    for (int i = 0; i < input.numValues + input.numClassValues; i++) {
        input.setColumn(i, normalizationColumn(input.getColumn(i)));
    }
    return input.instances;
  }

  List normalizationColumn(List <double> column) {
    num maxim = column.reduce(max);
    num minim = column.reduce(min);
    List columnNormalized = [];
    for (num i = 0; i < column.length; i++) {
      columnNormalized.add((column[i] - minim) / (maxim - minim));
    }
    return columnNormalized;
  }
}