// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library KMeans;

import "dart:math";
import 'cluster.dart';


class K_Means {

  int numCluster;
  List <Cluster> clusters;
  List<List<double>> points;
  int maxIterations = 50;
  int currentIteration;

  K_Means(this.numCluster, this.points) {
    this.clusters = [];
    this.initialization();
    this.currentIteration = 0;
  }

  void initialization() {
    if(this.points.isEmpty)
      throw("No points for cluster");
    for(int i = 0; i < this.numCluster; i++){
      Cluster cluster = new Cluster();
      cluster.centroid = this.points[new Random().nextInt(points.length)];
      this.clusters.add(cluster);
    }

  }

  void cluster() {
    do{
      this.associatingPoints();
      this.recalculateCentroids();
      this.currentIteration++;
    }while(this.currentIteration < this.maxIterations);
  }

  void recalculateCentroids() {
    for (Cluster cluster in this.clusters) {
      List <double> newCentroid = [];
      for(int k = 0; k < cluster.points[0].length; k++){
        double mean = 0.0;
        for(int i = 0; i < cluster.points.length ; i++){
          mean += cluster.points[i][k];
        }
        newCentroid.add(mean/cluster.points.length);
      }
      cluster.centroid = newCentroid;
    }
  }

  void associatingPoints() {

    for (Cluster cluster in this.clusters) {
      cluster.points = [];
    }

    for (List<double> point in this.points) {
      List<double> distances = [];
      for (Cluster cluster in this.clusters) {
        distances.add(this.distance(cluster.centroid, point));
      }
      this.clusters[distances.indexOf(distances.reduce(min))].points.add(point);
    }
  }

  double distance(List<double>pointA, List<double>pointB) {
    double Sum = 0.0;
    for (int i = 0;i < pointA.length;i++) {
      Sum = Sum + pow((pointA[i] - pointB[i]), 2.0);
    }
    return sqrt(Sum);
  }

  List<List<double>> get centroids{
    List<List<double>> centroids = [];
    for(Cluster cluster in this.clusters){
      centroids.add(cluster.centroid);
    }
    return centroids;
  }

}

