// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library KMeans;

import "dart:math";
import 'cluster.dart';


class K_Means {

  int numCluster;
  List <Cluster> clusters;

  K_Means(this.numCluster, List<List<double>>points) {
    this.clusters = [];
    for (int i = 0; i < this.numCluster; i++) {
      Cluster tempCluster = new Cluster();
      tempCluster.initialization(points[0].length);
      this.clusters.add(tempCluster);
    }
  }

  void cluster() {
    do{
      this.association();
      this.recalculateCentroids();
    }while(!_isReached());
  }

  void recalculateCentroids() {
    for (Cluster cluster in this.clusters) {
      List <double> centroid = [];
      for (int i = 0; i < cluster.centroid.length; i++) {
        double mean = 0.0;
        for (int j = 0; cluster.instances.length; j++) {
          mean += cluster.instances[j].attributes[i];
        }
        centroid.add(mean / cluster.instances.length);
      }
      cluster.centroid = centroid;
    }
  }

  void association() {
    List
    for (Cluster cluster in this.clusters) {
      cluster.instances = [];
    }

    for (Instance instance in this.instances) {
      List<double> distances = [];
      for (Cluster cluster in this.clusters) {
        distances.add(this.distance(cluster.centroid, instance.attributes));
      }
      this.clusters[distances.indexOf(distances.reduce(min))].instances.add(instance);
    }
  }

  double distance(List<double>pointA, List<double>pointB) {
    double Sum = 0.0;
    for (int i = 0;i < pointA.length;i++) {
      Sum = Sum + pow((pointA[i] - pointB[i]), 2.0);
    }
    return sqrt(Sum);
  }

  bool _isReached(){
    return false;
  }
}

