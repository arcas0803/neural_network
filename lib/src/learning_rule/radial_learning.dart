library LearningRule.Radial;

import "basic_learning.dart";
import 'dart:math';
import '../dataset/instance.dart';
import '../arquitecture/arquitecture_export.dart';
import '../algorithms/k_means/k_means.dart';
import '../algorithms/k_means/cluster.dart';

class RadialLearning extends BasicLearningRule {

  RadialLearning(int maxIterations):super(maxIterations) {
  }

  void initialization(List<Instance>trainSet) {
    int numCentroids = this.network.layers[1].neurons.length;
    K_Means k_means = new K_Means(numCentroids, trainSet, 100);
    k_means.cluster();
    List<Cluster> clusters = k_means.clusters;
    List<List<double>>centroidsValues = [];
    for (Cluster cluster in clusters) {
      centroidsValues.add(cluster.centroid);
    }
    List <double> deviations = this.deviations(centroidsValues);
    int i = 0;
    for (Neuron neuron in this.network.layers[1].neurons) {
      List <double> centroid = clusters[i].centroid;
      int j = 0;
      for (Connection connection in neuron) {
        connection.weightValue = centroid[j];
        j++;
      }


      i++;
    }
  }

  List<double> deviations(List<List<double>> centroids) {
    List <double> geometricMeans = [];
    for (int i = 0; i < centroids.length; i++) {
      Map <int, double> tempDistance = new Map();
      for (int j = 0; j < centroids.length; j++) {
        if (i != j) {
          tempDistance[j] = distance(centroids[i], centroids[j]);
        }
      }

      List <int> nearest = [];
      do {
        double minDistance = tempDistance.values.reduce(min);
        for (int i = 0; i < tempDistance.length; i++) {
          if (tempDistance[i] == minDistance) {
            nearest.add(i);
            tempDistance.remove(i);
            break;
          }
        }
      } while (nearest.length < 2);
      geometricMeans.add(sqrt(distance(centroids[i], centroids[nearest[0]]).abs() * distance(centroids[i], centroids[nearest[1]]).abs()));
    }
  }

  double distance(List<double>pointA, List<double>pointB) {
    double Sum = 0.0;
    for (int i = 0;i < pointA.length;i++) {
      Sum = Sum + pow((pointA[i] - pointB[i]), 2.0);
    }
    return sqrt(Sum);
  }
}