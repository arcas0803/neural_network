// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library Filter;

import '../dataset/dataset.dart';
import '../dataset/instance.dart';

///
/// Interface for implementing a filter.
///

abstract class Filter {

  /// Name of the filter.
  String name;

  /// Apply method will return the new list of instances.
  List<Instance> applyFilter(DataSet dataSet);

}




