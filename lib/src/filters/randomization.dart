// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library Filter.Randomization;

import '../dataset/dataset.dart';
import '../dataset/instance.dart';
import 'filter.dart';

class RandomizeFilter extends Filter {

  RandomizeFilter() {

    this.name = "Randomize";
  }

  List<Instance> applyFilter(DataSet input) {
    if(input.instances.length > 0){
      input.instances.shuffle();
    }
    return input.instances;
  }

}