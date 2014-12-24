// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library LearningRule.Radial;

import "basic_learning.dart";
import 'dart:math';
import '../dataset/instance.dart';
import "../arquitecture/neuron.dart";
import "../arquitecture/connection.dart";
import '../algorithms/k_means/k_means.dart';
import '../algorithms/k_means/cluster.dart';
import '../functions/input/radial_function.dart';

/// Specific learning rule for radial base networks.

class RadialLearning extends BasicLearningRule{

  RadialLearning(int maxIterations):super(maxIterations){}

  ///
  /// Calculates the centroids and amplitudes for learning.
  ///

  void initialization(List<Instance>trainSet){
    int numCentroids = this.network.layers[1].neurons.length;
    K_Means k_means = new K_Means(numCentroids,trainSet,100);
    k_means.cluster();
    List<Cluster> clusters = k_means.clusters;
    List<List<double>>centroidsValues = [];
    for(Cluster cluster in clusters){
      centroidsValues.add(cluster.centroid);
    }
    List <double> amplitudes = this._amplitudes(centroidsValues);
    int i = 0;
    for(Neuron neuron in this.network.layers[1].neurons){
      List <double> centroid = clusters[i].centroid;
      int j = 0;
      for(Connection connection in neuron){
        connection.weightValue = centroid[j];
        j++;
      }
      (neuron.inputFunction as Radial).amplitude = amplitudes[i];
      i++;
    }
  }

  List<double> _amplitudes(List<List<double>> centroids){
    List <double> geometricMeans = [];
    for(int i = 0; i < centroids.length; i++) {
      Map <int, double> tempDistance = new Map();
      for (int j = 0; j < centroids.length; j++) {
        if (i != j) {
          tempDistance[j] = _distance(centroids[i], centroids[j]);
        }
      }

      List <int> nearest = [];
      do{
        double minDistance = tempDistance.values.reduce(min);
        for (int i = 0; i < tempDistance.length; i++) {
          if (tempDistance[i] == minDistance) {
            nearest.add(i);
            tempDistance.remove(i);
            break;
          }
        }
      }while(nearest.length < 2);
      geometricMeans.add(sqrt(_distance(centroids[i] , centroids[nearest[0]]).abs() * _distance(centroids[i] , centroids[nearest[1]]).abs()));
    }
  }

  double _distance( List<double>pointA, List<double>pointB){
    double Sum = 0.0;
    for(int i=0;i<pointA.length;i++) {
      Sum = Sum + pow((pointA[i]-pointB[i]),2.0);
    }
    return sqrt(Sum);
  }
}