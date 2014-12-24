// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
library DataSet.Instance;

///
/// Set of attribute values​​. In case of a supervised instance also includes the values ​​of the class value.
///

class Instance{

  List <double> _values;
  List <double> _classValues;
  bool isForTrain;
  int _numValues;
  int _numClassValues;

  ///
  /// [new Instance] use to create a instance.
  ///
  /// Example unsupervised instance:
  ///   Instance example = new Instance(some_values_in_a_list);
  ///
  /// Example supervised instance:
  ///   Instance example = new Instance(some_values_in_a_list, classValues: some_class_values);
  ///

  Instance(List <double> values, {List <double> classValues}){

    if(values == null){
      this.values = [];
    }else{
      this.values = values;
    }

    if(classValues != null){
      this.classValues = classValues;
    }

  }

  List<double> get values => this._values;

  List<double> get classValues => this._classValues;

  void set values(List <double> values){
    if(values != null){
      this._values = values;
      this._numValues = values.length;
    }
  }

  void set classValues(List <double> classValues){
    if(classValues != null){
      this._classValues = classValues;
      this._numClassValues = classValues.length;
    }
  }

  int get numValues => this._numValues;

  int get numClassValues => this._numClassValues;

  ///
  /// If is a unsupervised instance will return the values of the instance.
  /// If is a supervised instance will return the values and class values of the instance
  ///

  List<double> get allValues{

    List <double> instanceValues = [];
    if(this.values != null){
      instanceValues.addAll(this.values);
    }
    if(this.classValues != null){
      instanceValues.addAll(this.classValues);
    }
    return instanceValues;

  }

  ///
  /// If is a supervised instance the list of values must have the same length as the sum of numValues and numClassValues.
  ///

  void set allValues(List<double> values){

    if(numClassValues != null){
      if(values.length != (this.numValues + this.numClassValues))
        throw ("The values list size is different than the number of values and class values");
      this.values = values.getRange(0, numValues-1);
      this.classValues = values.getRange(numValues, numClassValues-1);
    }else{
      if(values.length != this.numValues)
        throw ("The values list size is different than the number of values and class values");
      this.values = values;
    }
  }

  ///
  /// Return true if the instance has class values.
  ///

  bool get isSupervised {
    if(this.numClassValues == null || this.numClassValues == 0){
      return false;
    }else{
      return true;
    }
  }

  void addClassValue(double value){
    this._numClassValues ++;
    this.classValues.add(value);
  }

  void removeClassValue(int index){
    this._numClassValues --;
    this.classValues.removeAt(index);

  }

  void addValue(double value){
    this._numValues++;
    this.values.add(value);
  }

  removeValue(int index){
    this._numValues--;
    this.values.removeAt(index);
  }
}