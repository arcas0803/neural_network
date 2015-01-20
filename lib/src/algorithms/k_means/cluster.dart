// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library KMeans.Cluster;

import 'dart:math';


class Cluster {
  List <double> centroid;
  List <List<double>> points;

  Cluster() {
    this.centroid = [];
    this.points = [];
  }
}