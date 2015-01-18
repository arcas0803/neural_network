library DataSet;

import 'dart:math';
import 'package:collection/equality.dart';
import "package:json_object/json_object.dart";
import 'instance.dart';

///
/// Set of instances used to train and test the artificial neural networks.
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

  DataSet(this.title, int numValues, {int numClassValues}) {

    if (numValues == null)
      throw ("Number of values can not be null!");
    if (numValues <= 0)
      throw ("Number of values has to be greatter than 0!");
    this._numValues = numValues;

    if (numClassValues != null) {
      if (numClassValues <= 0)
        throw ("Number of class values has to be greatter than 0!");
      this._numClassValues = numClassValues;
      this._isSupervised = true;
    } else {
      this._isSupervised = false;
      this._numClassValues = 0;
    }

    this._instances = [];
    this._labels = [];

  }

  DataSet.FromJSON(JsonObject json){
    this.title = json.title;
    this._labels = json.labels;
    this._numValues = json.numValues;
    this._numClassValues = json.numClassValues;
    this._isSupervised = json.isSupervised;
    this._instances = [];
    for(int i = 0; i < json.instances.length; i++){
      this.addInstance(json.instances[i]);
    }
  }

  ///
  /// Return labels.
  ///

  List<String> get labels => this._labels;

  ///
  /// The number of labels should be equal to the number of attributes in the case of a DataSet unsupervised and
  /// as the number of attributes and class values ​​in case of a dataset supervised.
  ///

  void set labels(List <String> labels) {
    if (labels.length != (this._numValues + this._numClassValues))
      throw ("The number of labels must be the same as the number of attributes and class values");
    this._labels = labels;

  }

  ///
  /// Set label value at a index.
  ///

  void setLabelAt(int index, String label) {
    this._labels[index] = label;
  }

  ///
  /// Return true if the dataSet is supervised; false if its unsupervised.
  ///

  bool get isSupervised => this._isSupervised;

  ///
  /// Return the number of values.
  ///

  int get numValues => _numValues;

  ///
  /// Return the number of class values.
  ///

  int get numClassValues => _numClassValues;

  ///
  /// Return a list with all instances.
  ///

  List<Instance> get instances => this._instances;

  ///
  /// All instance must be supervised if the dataSet is supervised or unsupervised if the dataSet is unsupervised.
  ///

  void set instances(List<Instance> instances) {
    this._instances = [];
    for (Instance instance in instances) {
      this._instances.add(instance);
    }
  }

  ///
  /// Returns all instance that are set to used in the train process.
  ///

  List <Instance> get trainSet {
    List <Instance> temp = [];
    for (Instance instance in this.instances) {
      if (instance.isForTrain) {
        temp.add(instance);
      }
    }
    return temp;
  }

  ///
  /// Returns all instance that are set to used in the test process.
  ///

  List <Instance> get testSet {
    List <Instance> temp = [];
    for (Instance instance in this.instances) {
      if(!instance.isForTrain){
        temp.add(instance);
      }
    }
    return temp;
  }

  ///
  /// Return the number of instances used for train.
  ///

  int get numberTrainInstances => this.trainSet.length;

  ///
  /// Return the number of instances used for test.
  ///

  int get numberTestInstances => this.testSet.length;

  ///
  /// Return the number of instances.
  ///

  int get numberInstances => this.instances.length;

  ///
  /// Use to set the number of train instance and the number of test instance.
  ///
  /// Example:
  ///   exampleDataSet.trainTestSet(5); => 5 instance will be for train and the rest will be for test.
  ///

  void set trainTestSet(int numberInstanceTrain) {
    if (this._instances.isEmpty) {
      throw("The dataSet has no instances");
    } else {
      for (int i = 0; i < this.instances.length; i++) {
        if (i < numberInstanceTrain) {
          this.instances[i].isForTrain = true;
        } else {
          this.instances[i].isForTrain = false;
        }
      }
    }
  }

  ///
  /// Return the values of all instances.
  ///

  List<List<double>> get instancesValues {
    List<List<double>> temp = [];
    for (Instance instance in this.instances) {
      temp.add(instance.elements);
    }
    return temp;
  }

  ///
  /// Return the min value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get minValues {
    List <double> minRow = [];
    for (int i = 0; i < this.numValues + this.numClassValues; i++) {
      minRow.add(this.getColumn(i).reduce(min));
    }
    return minRow;
  }

  ///
  /// Return the max value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get maxValues {
    List<double> maxRow = [];
    for (int i = 0; i < this.numValues+this.numClassValues; i++) {
      maxRow.add(this.getColumn(i).reduce(max));
    }
    return maxRow;
  }

  ///
  /// Return the mean value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get meanValues {
    List<double> meanRow = [];
    for (int i = 0; i < this.numValues + this.numClassValues; i++) {
      List <double> temp = this.getColumn(i);
      double mean = 0.0;
      for (double value in temp) {
        mean += value;
      }
      meanRow.add(double.parse((mean / temp.length).toStringAsFixed(2)));
    }
    return meanRow;
  }

  ///
  /// The number of values should be equal to the number of attributes in the case of a DataSet unsupervised and
  /// as the number of attributes and class values ​​in case of a dataSet supervised.
  /// If the new instance is already available in the DataSet will be included there .
  /// You can specify whether the new instance is to train or test
  ///

  void addInstance(List <double> values, [bool isForTrain]) {
    if(values.length != this.numValues+this.numClassValues)
      throw("The number of elements of th new instance must be the same as the number of values and class values of the dataset");
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
  /// Add multiple instances with just one call.
  ///

  void addInstances(List<List<double>>values) {
    for (List<double>value in values) {
      this.addInstance(value);
    }
  }

  ///
  /// Returns true if the instance provided by parameter already available in the DataSet.
  ///

  bool _repeatedInstance(List <double> instance) {
    bool repeated = false;
    for (List <double> temp in this.instancesValues) {
      Function eq = const ListEquality().equals;
      if (eq(temp, instance)) {
        return true;
      }
    }
    return false;
  }

  ///
  /// Remove an instance at a index.
  ///

  void removeInstance(int index) {
    this._instances.removeAt(index);
  }

  ///
  /// A row represents all values that an attribute or a class value can take.
  /// For setting a Row the number of values has to be the same as the number of instances.
  /// Its possible to set the label of that row.
  ///

  void setColumn(int index, List <double> values) {
    int i = 0;
    for(Instance instance in this.instances){
      instance.elements[index] = values [i];
      i++;
    }
  }

  ///
  /// Return all values of the column at an index.
  ///

  List<double> getColumn(int index) {
    List <double> values = [];
    for(Instance instance in this.instances){
      values.add(instance.elements[index]);
    }
    return values;
  }

  ///
  /// Return the attributes of an instances.
  ///

  List<double> instanceValues(int index){
    List<double> temp = [];
    for(int i = 0; i < this.numValues; i++){
      temp.add(this.instances[index].elements[i]);
    }
    return temp;
  }

  ///
  /// Return the class values of an instance.
  ///

  List<double> instanceClassValues(int index){
    List<double> temp = [];
    for(int i = this.numValues; i < this.numValues + this.numClassValues; i++){
      temp.add(this.instances[index].elements[i]);
    }
    return temp;
  }

  ///
  /// Return the json object of a dataset.
  ///

  JsonObject toJSON(){
    JsonObject dataSet = new JsonObject();
    dataSet.title = this.title;
    dataSet.labels = new List();
    for(String label in this.labels){
      dataSet.labels.add(label);
    }
    dataSet.isSupervised = this.isSupervised;
    dataSet.numValues = this.numValues;
    dataSet.numClassValues = this.numClassValues;
    dataSet.instances = new List();
    for(Instance instance in this.instances){
      dataSet.instances.add(instance.toJSON());
    }
  }

}



