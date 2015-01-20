library LearningRule.Radial;

import "basic_learning.dart";
import 'dart:math';
import '../arquitecture/arquitecture_export.dart';
import '../algorithms/k_means/k_means.dart';
import '../functions/input/radial_function.dart';

class RadialLearning extends BasicLearningRule {

  RadialLearning(int maxIterations):super(maxIterations) {
  }

  void initialization(List<List<double>>trainSet) {

    int numCentroids = this.network.layers[1].neurons.length;
    K_Means k_means = new K_Means(numCentroids, trainSet);
    k_means.cluster();
    List <double> deviations = this.deviations(k_means.centroids);
    int i = 0;
    for (Neuron neuron in this.network.layers[1].neurons) {
      int j = 0;
      for (Connection connection in neuron.inputConnections) {
        connection.weightValue = k_means.clusters[i].centroid[j];
        j++;
      }
      (neuron.inputFunction as Radial).deviation = deviations[i];
      i++;
    }
  }

  List<double> deviations(List<List<double>> centroids) {
    List <double> geometricMeans = [];
    if(centroids.isEmpty)
      throw("No centroids asigned");
    if(centroids.length == 1){
      geometricMeans[0] = 1.0;
    }else if(centroids.length == 2){
        double distance = this.distance(centroids[0],centroids[1]);
        geometricMeans[0] = distance/2;
        geometricMeans[1] = distance/1;
    }else if(centroids.length > 2){
      for (int i = 0; i < centroids.length; i++) {
        List <double> tempDistance = [];
        for (int j = 0; j < centroids.length; j++) {
          tempDistance.add(distance(centroids[i], centroids[j]));
        }
        List<double> tempSortDistance = new List();
        tempSortDistance.addAll(tempDistance);
        tempDistance.sort();
        geometricMeans.add(sqrt(distance(centroids[i], centroids[tempSortDistance.indexOf(tempDistance[1])]).abs() * distance(centroids[i], centroids[tempSortDistance.indexOf(tempDistance[2])]).abs()));
      }
    }
    return geometricMeans;
  }

  double distance(List<double>pointA, List<double>pointB) {
    double Sum = 0.0;
    for (int i = 0;i < pointA.length;i++) {
      Sum = Sum + pow((pointA[i] - pointB[i]), 2.0);
    }
    return sqrt(Sum);
  }
}