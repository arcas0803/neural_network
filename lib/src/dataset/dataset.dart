// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library DataSet.DataSet;

import 'dart:math';
import 'package:collection/equality.dart';
import "package:json_object/json_object.dart";
import 'instance.dart';

///
/// Set of instances used to train and test an artificial neural network.
///

class DataSet {

  String title;
  List <Instance> _instances;
  List <String> _labels;
  bool _isSupervised;
  int _numValues;
  int _numClassValues;

  ///
  /// [new DataSet] use tu create a empty dataSet.
  ///
  /// Example unsupervised dataSet:
  ///   DataSet example = new DataSet("Example", 2); => dataSet with 2 attributes.
  ///
  /// Example supervised dataSet:
  ///   DataSet example = new DataSet("Example", 2, numClassValues: 1); => dataSet with 2 attributes and 1 class value.
  ///
  /// The number of values must be greater than 0 and cant be null.
  /// If the dataSet contains class values, the number of class values must be grater than 0.
  ///

  DataSet(this.title, int numValues, {int numClassValues}){

    if(numValues == null)
      throw ("Number of values can not be null!");
    if(numValues <=0)
      throw ("Number of values has to be greatter than 0!");
    this._numValues = numValues;

    if(numClassValues != null){
      if(numClassValues <=0)
        throw ("Number of class values has to be greatter than 0!");
      this._numClassValues = numClassValues;
      this._isSupervised = true;
    }else{
      this._numClassValues = 0;
      this._isSupervised = false;
    }

    this._instances = [];
    this._labels = [];

  }

  //
  // Create a dataSet from an JsonObject.
  //
  // JSON format:
  // {
  //  "title" : "Example",
  //  "isSupervised" : true,
  //  "numValues" : 2,
  //  "numClassValues" : 2,
  //  "instance" : [ {"elements":[2.1, 2.1, 2.1, 2.1], "isForTrain" : true } , {"elements":[2.1, 2.1, 2.1, 2.1], "isForTrain" : true } ]
  //  }
  //

  DataSet.fromJSON(JsonObject json){

    this.title = json.title;
    this._isSupervised = json.isSupervised;
    this._numValues = json.numValues;
    this._numClassValues = json.numClassValues;
    this._instances = [];

    for(int i = 0; i < json.instances.length; i++){
      this.addInstance(json.instances[i].elements, isForTrain: json.instances[i].isForTrain);
    }
  }

  ///
  /// Get the labels of the dataSet.
  ///

  List<String> get labels => this._labels;

  ///
  /// The number of labels should be equal to number of values and class values. If not an exception will be throw.
  ///

  void set labels(List <String> labels){

    if(labels.length != (this.numValues + this.numClassValues))
      throw("The number of labels must be the same as the number of values and class values.");
    this._labels = labels;

  }

  ///
  /// Set a label at index.
  ///

  void setLabelAt(int index, String label){

    this._labels[index] = label;

  }

  ///
  /// Return true if the dataSet contains class values. If not it will return false.

  bool get isSupervised => this._isSupervised;

  ///
  /// Return the number of values.
  ///

  int get numValues => _numValues;

  ///
  /// Return the number of class values. If the dataSet is unsupervised, the number of class values will be 0.
  ///

  int get numClassValues => _numClassValues;

  ///
  /// Return the number of instances for the train process.
  ///

  int get numberTrainInstances => this.trainSet.length;

  ///
  /// Return the number of instances for the test process.
  ///

  int get numberTestInstances => this.testSet.length;

  ///
  /// Return the number of instances of the dataSet.
  ///

  int get numberInstances => this.instances.length;

  ///
  /// Return a list with all the instances of the dataSet.
  ///

  List<Instance> get instances => this._instances;

  ///
  /// Set instances of the dataSet
  ///

  void set instances (List<Instance> instances){

    this._instances = [];
    for(Instance instance in instances){
      if(instance.elements.length != (this.numValues + this.numClassValues))
        throw("The number of elements in all instances must be the same as the number of values and class values.");
      this._instances.add(instance);
    }

  }

  ///
  /// Returns all instance that are set to used in the train process.
  ///

  List <Instance> get trainSet{
    List <Instance> temp = [];
    for (Instance instance in this.instances){
      if(instance.isForTrain){
          temp.add(instance);
      }
    }
    return temp;
  }

  ///
  /// Returns all instance that are set to used in the test process.
  ///

  List <Instance> get testSet{

    List <Instance> temp = [];
    for (Instance instance in this.instances){
      if (!instance.isForTrain) {
          temp.add(instance);
      }
    }
    return temp;

  }

  ///
  /// Use to set the number of train instance and the number of test instance.
  ///
  /// Example:
  ///   exampleDataSet.sets(5); => 5 instance will be for train and the rest will be for test.
  ///

  void set trainTestSets(int numberInstanceTrain){
    if(this._instances.isEmpty){
      throw("The dataSet has no instances to set");
    }else{
      for(int i = 0; i < this.instances.length; i++){
        if(i < numberInstanceTrain){
          this.instances[i].isForTrain = true;
        }else{
          this.instances[i].isForTrain = false;
        }
      }
    }
  }

  List<List<double>> get instancesValues{

    List<List<double>> temp = [];
    for(Instance instance in this.instances){
      temp.add(instance.elements);
    }
    return temp;

  }

  ///
  /// Return the values of an instance.
  ///

  List<double> instanceValues(int index){

    List <double> temp = [];
    for(int i = 0; i < this.numValues; i++){
      temp.add(this.instances[index].elements[i]);
    }
    return temp;

  }

  ///
  /// Return the class values of an instance.
  ///
  /// If the dataSet is unsupervised, an exception will be thrown.
  ///

  List<double> instanceClassValues(int index){

    if(!isSupervised)
      throw ("DataSet unsupervised does not have class values");
    List <double> temp = [];
    for(int i = 0; i < this.numClassValues; i++){
      temp.add(this.instances[index].elements[i]);
    }
    return temp;

  }


  ///
  /// Return the min value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get minValues{

    List<double> minRow = [];
    for(int i = 0; i < this.numValues + this.numClassValues; i++){
      minRow.add(this.getColumn(i).reduce(min));
    }
    return minRow;

  }

  ///
  /// Return the max value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get maxValues{

    List<double> maxRow = [];
    for(int i = 0; i < this.numValues + this.numClassValues; i++){
      maxRow.add(this.getColumn(i).reduce(max));
    }
    return maxRow;
  }

  ///
  /// Return the mean value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get meanValues{

    List<double> meanRow = [];
    for(int i = 0; i < this.numValues + this.numClassValues; i++){
      List <double> temp = this.getColumn(i);
      double mean = 0.0;
      for(double value in temp){
        mean += value;
      }
      meanRow.add(double.parse((mean/temp.length).toStringAsFixed(2)));
    }
    return meanRow;

  }

  ///
  /// Add a new instance to the dataSet
  /// The number of values should be equal to the number of attributes and class values. If not an exception will be thrown.
  ///

  void addInstance(List <double> values, {bool isForTrain}){

    if(values.length != (this.numValues + this.numClassValues))
      throw("The number of elements the new intance must be the same as the number of values and class values.");

    if(!this._repeatedInstance(values)){
      Instance temp = new Instance();
      temp.elements = values;
      if(isForTrain != null){
        temp.isForTrain = isForTrain;
      }
      this._instances.add(temp);
    }

  }

  ///
  /// Add multiple instances.
  ///

  void addInstances(List<List<double>>values){
    for(List<double>value in values){
      this.addInstance(value);
    }
  }

  ///
  /// Returns true if the instance provided by parameter is already available in the DataSet.
  ///

  bool _repeatedInstance(List <double> instance){
    bool repeated = false;
    for(List <double> temp in this.instancesValues){
      Function eq = const ListEquality().equals;
      if(eq(temp, instance)){
       return true;
      }
    }
    return false;
  }

  ///
  /// Remove an instance at index.
  ///

  void removeInstance(int index){
    this._instances.removeAt(index);
  }

  ///
  /// Remove all the instances in the dataSet.
  ///

  void removeAllInstance(){
    this._instances = [];
  }

  ///
  /// Set the values of a column. The number of values of the new column must be the same as the number of values of the
  /// other columns.
  ///

  void setColumn(int index, List <double> values){

    if(values.length != this.instances.length)
      throw ("The number of elements of the new column has to be equal to the number of items of other columns");
    for(Instance instance in this.instances){
      instance.elements[index] = values [index];
    }

  }

  //
  // Return a column of the dataSet. If you imagine the dataSet as a bi-dimensional table, the rows are the instances and with
  // this method you can get the column.
  //

  List<double> getColumn(int index){

    List <double> values = [];
    for(Instance temp in this._instances) {
      values.add(temp.elements[index]);
    }
    return values;

  }

  //
  // Return the JsonObject of the dataSet.
  //

  JsonObject toJSON(){

    JsonObject dataSet = new JsonObject();
    dataSet.title = this.title;
    dataSet.isSupervised = this.isSupervised;
    dataSet.numValues = this.numValues;
    dataSet.numClassValues = this.numClassValues;
    dataSet.instances = new List();

    for(Instance instance in this.instances){
      dataSet.instance.add(instance.toJSON());
    }

    return dataSet;

  }

}



