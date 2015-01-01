// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library Arquitecture.Weight;

import 'dart:math';
import "package:json_object/json_object.dart";

///
/// Value that is associated with a connection between two neurons which
/// determines the importance of the entry into the aggregation function
/// of the neuron.
///

class Weight {

  double _value;
  double _previousValue;
  double _variation;

  ///
  /// [new Weight] use to create a weight.
  /// Its possible to set a specific value. By default the value will be a random double.
  ///
  /// Example:
  ///   Weight example = new Weight(2.1); => this.value = 2.1
  ///                                        this.previousValue = null;
  ///                                        this.variation = null;
  ///

  Weight([double value]) {

    if (value != null) {
      this._value = value;
    } else {
      Random r = new Random();
      this._value = r.nextDouble();
    }

  }

  //
  // Create a Weight from an JsonObject.
  //
  // JSON format:
  // {
  //  "value" : 2.1,
  //  "previousValue" : 2.1,
  //  "variation" : 0.0
  //  }
  //

  Weight.fromJSON(JsonObject json){

    this._value = json.value;
    this._previousValue = json.previousValue;
    this._variation = json.variation;

  }

  ///
  /// When you set a value, the old value will be previous value and the
  /// variation will be the difference between both (absolute value).
  ///
  /// Example:
  ///   example.value = 1.2; => this.value = 1.2
  ///                           this.previousValue = 2.1;
  ///                           this.variation = 1.0;
  ///

  void set value(double value) {

    this._previousValue = this._value;
    this._value = value;
    this._variation = (this._value - this._previousValue).abs();

  }

  ///
  /// Get the actual value of the weight.
  ///

  double get value => this._value;

  ///
  /// Get the previous value of the weight.
  ///

  double get previousValue => this._previousValue;

  ///
  /// Get variation between the previous value and the actual one.
  ///

  double get variation => this._variation;

  ///
  /// Increases the weight value.
  ///
  /// Example:
  ///   example.increment(1.0) => this.value = 2.2
  ///                             this.previousValue = 1.2;
  ///                             this.variation = 1.0;
  ///

  void increment(double value) {

    this.value = this._value + value;

  }

  //
  // Return the JsonObject of the weight.
  //

  JsonObject toJSON(){

    JsonObject weight = new JsonObject();
    weight.value = this.value;
    weight.previousValue = this.previousValue;
    weight.variation = this.variation;
    return weight;

  }

}