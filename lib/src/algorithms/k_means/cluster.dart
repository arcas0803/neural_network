// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library KMeans.Cluster;

import 'dart:math';
import '../../dataSet/instance.dart';

class Cluster {
  List <double> centroid;
  List <Instance> instances;

  Cluster() {
    this.centroid = [];
    this.instances = [];
  }

  void initialization(int dimensions) {
    for (int i = 0; i < dimensions; i++) {
      Random rd = new Random();
      this.centroid.add(rd.nextDouble());
    }
  }
}