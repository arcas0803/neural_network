// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library DataSet;

import 'dart:math';
import 'package:collection/equality.dart';
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

  DataSet(String title, int numValues, {int numClassValues}){
    if(title == null){
      this.title = "dataset";
    }else{
      this.title = title;
    }

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
      this._isSupervised = false;
    }

    this._instances = [];
    this._labels = [];

  }

  List<String> get labels => this._labels;

  ///
  /// The number of labels should be equal to the number of attributes in the case of a DataSet unsupervised and
  /// as the number of attributes and class values ​​in case of a dataset supervised.
  ///

  void set labels(List <String> labels){
    if(_isSupervised){
      if(labels.length != (this._numValues + this._numClassValues))
        throw ("You set a list of "+labels.length.toString()+" labels but the dataSet has "+this._labels.length.toString()+" labels");
      this._labels = labels;
    }else{
      if(labels.length != this._numValues)
        throw ("You set a list of "+labels.length.toString()+" labels but the dataSet has "+this._labels.length.toString()+" labels");
      this._labels = labels;
    }
  }

  void setLabelAt(int index, String label){
    this._labels[index] = label;
  }

  bool get isSupervised => this._isSupervised;

  int get numValues => _numValues;

  int get numClassValues => _numClassValues;

  List<Instance> get instances => this._instances;

  ///
  /// All instance must be supervised if the dataSet is supervised or unsupervised if the dataSet is unsupervised.
  ///

  void set instances (List<Instance> instances){
    this._instances=[];
    for(Instance instance in instances){
      if((this.isSupervised && !instance.isSupervised)||(!this.isSupervised && instance.isSupervised))
        throw ("Invalid instance for this dataSet");
      this._instances.add(instance);
    }
  }

  ///
  /// Returns all instance that are set to used in the train process.
  ///

  List <Instance> get trainSet{
    List <Instance> temp = [];
    for (Instance instance in this.instances){
      if(instance.isForTrain == null){
       throw ("No instances has not been set for train or test. Before you use the train set or test set you must set the instances for train and test");
      }else{
        if(instance.isForTrain){
          temp.add(instance);
        }
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
      if(instance.isForTrain == null){
        throw ("No instances has not been set for train or test. Before you use the train set or test set you must set the instances for train and test");
      }else {
        if (!instance.isForTrain) {
          temp.add(instance);
        }
      }
    }
    return temp;
  }

  int get numberTrainInstances => this.trainSet.length;

  int get numberTestInstances => this.testSet.length;

  int get numberInstances => this.instances.length;

  ///
  /// Use to set the number of train instance and the number of test instance.
  ///
  /// Example:
  ///   exampleDataSet.sets(5); => 5 instance will be for train and the rest will be for test.
  ///

  void set sets(int numberInstanceTrain){
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
      temp.add(instance.allValues);
    }
    return temp;
  }

  ///
  /// Return the min value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get minValues{
    int numberRows = 0;
    List<double> minRow = [];
    if(this.isSupervised){
      numberRows += this.numValues + this.numClassValues;
    }else{
      numberRows += this.numValues;
    }
    for(int i = 0; i < numberRows; i++){
      minRow.add(this.getRow(i).reduce(min));
    }
    return minRow;
  }

  ///
  /// Return the max value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get maxValues{
    int numberRows = 0;
    List<double> maxRow = [];
    if(this.isSupervised){
      numberRows += this.numValues + this.numClassValues;
    }else{
      numberRows += this.numValues;
    }
    for(int i = 0; i < numberRows; i++){
      maxRow.add(this.getRow(i).reduce(max));
    }
    return maxRow;
  }

  ///
  /// Return the mean value of all the attributes and class values(if exists).
  /// Use to get some stats of the dataSet,
  ///

  List<double> get meanValues{
    int numberRows = 0;
    List<double> meanRow = [];
    if(this.isSupervised){
      numberRows += this.numValues + this.numClassValues;
    }else{
      numberRows += this.numValues;
    }
    for(int i = 0; i < numberRows; i++){
      List <double> temp = this.getRow(i);
      double mean = 0.0;
      for(double value in temp){
        mean += value;
      }
      meanRow.add(double.parse((mean/temp.length).toStringAsFixed(2)));
    }
    return meanRow;
  }

  ///
  /// The number of values should be equal to the number of attributes in the case of a DataSet unsupervised and
  /// as the number of attributes and class values ​​in case of a dataSet supervised.
  /// If the new instance is already available in the DataSet will be included there .
  /// You can specify whether the new instance is to train or test
  ///

  void addInstance(List <double> values, [bool isForTrain]){
    if(this.isSupervised){
      if(values.length != (this._numValues + this._numClassValues))
        throw ("You add a instance of "+values.length.toString()+" values, but an instance in this dataSet has "+this._numValues.toString()+" attributes and "+this._numClassValues.toString()+" class values. So an instance must have a total of "+(this._numValues+this._numClassValues).toString()+" values");
      Instance temp = new Instance(values.getRange(0,this._numValues).toList(),classValues: values.getRange(this._numValues, this._numValues + this._numClassValues).toList());
      if(isForTrain != null){
        temp.isForTrain = isForTrain;
      }
      if(!this.hasInstance(temp.allValues)){
        this._instances.add(temp);
      }
    }else{
      if(values.length != this._numValues)
        throw ("You add a instance of "+values.length.toString()+" values, but an instance in this dataSet has "+this._numValues.toString()+" attributes. So an instance must have a total of "+this._numValues.toString()+" values");
      Instance temp = new Instance(values);
      if(isForTrain != null){
        temp.isForTrain = isForTrain;
      }
      if(!this.hasInstance(temp.allValues)){
        this._instances.add(temp);
      }
    }
  }

  ///
  /// Add multiple instances with just one call.
  ///

  void addInstances(List<List<double>>values){
    for(List<double>value in values){
      this.addInstance(value);
    }
  }

  ///
  /// Returns true if the instance provided by parameter already available in the DataSet.
  ///

  bool hasInstance(List <double> instance){
    bool repeated = false;
    for(List <double> temp in this.instancesValues){
      Function eq = const ListEquality().equals;
      if(eq(temp, instance)){
       return true;
      }
    }
    return false;
  }

  void removeInstance(int index){
    this._instances.removeAt(index);
  }

  ///
  /// A row represents all values that an attribute or a class value can take.
  /// For setting a Row the number of values has to be the same as the number of instances.
  /// Its possible to set the label of that row.
  ///

  void setRow(int index, List <double> values, [String label]){
    if(label!= null) {
      this.setLabelAt(index, label);
    }
    if(_isSupervised){
      if(index < this._numValues){
        if(values.length != this._instances.length)
          throw ("You set a row of "+values.length.toString()+" values, but the dataSet has rows of "+this._instances.length.toString()+" values.");
        int count = 0;
        for(Instance temp in this._instances){
          temp.values[index] = values[count];
          count++;
        }
      }else{
        if(values.length != this._instances.length)
          throw ("You set a row of "+values.length.toString()+" values, but the dataSet has rows of "+this._instances.length.toString()+" values.");
        index-=this._numValues;
        int count = 0;
        for(Instance temp in this._instances){
          temp.classValues[index] = values[count];
          count++;
        }
      }
    }else{
      if(values.length != this._instances.length)
        throw ("You set a row of "+values.length.toString()+" values, but the dataSet has rows of "+this._instances.length.toString()+" values.");
      int count = 0;
      for(Instance temp in this._instances){
        temp.values[index] = values[count];
        count++;
      }
    }
  }

  List<double> getRow(int index){
    List <double> values = [];
    if(index < this._numValues){
      for(Instance temp in this._instances){
        values.add(temp.values[index]);
      }
    }else{
      index -= this._numValues;
      for(Instance temp in this._instances){
        values.add(temp.classValues[index]);
      }
    }
    return values;
  }

  ///
  /// For adding a Row the number of values has to be the same as the number of instances.
  /// If the row is a class value and the dataSet is unsupervised an exception will be throw.
  ///

  void addRow(List <double> values, String label, bool isClassValue){
    if(!this._isSupervised){
     throw("Unsupervised dataset cant hava class values");
    }else{
      if(isClassValue){
        if(values.length != this._instances.length)
          throw ("You set a row of "+values.length.toString()+" values, but the dataSet has rows of "+this._instances.length.toString()+" values.");
        this._numClassValues++;
        int count = 0;
        for(Instance temp in this._instances){
          temp.addClassValue(values[count]);
          count++;
        }

        this._labels.add(label);
      }else{
        if(values.length != this._instances.length)
          throw ("You set a row of "+values.length.toString()+" values, but the dataSet has rows of "+this._instances.length.toString()+" values.");
        this._numValues++;
        int count = 0;
        for(Instance temp in this._instances){
          temp.addValue(values[count]);
          count++;
        }
        this._labels.insert(_numValues, label);
      }
    }

  }

  void removeRow(int index){
    this._labels.removeAt(index);
    if(_isSupervised){
      if(index < this._numValues){
        this._numValues --;
        for(Instance temp in this._instances){
          temp.removeValue(index);
        }
      }else{
        if(this.numClassValues > 1){
          this._numClassValues--;
          index-=this._numValues;
          for(Instance temp in this._instances){
            temp.removeClassValue(index);
          }
        }else{
          throw("Supervised dataSet must have 1 or more class values");
        }
      }
    }else{
      this._numValues--;
      for(Instance temp in this._instances){
        temp.removeValue(index);
      }
    }
  }
}



