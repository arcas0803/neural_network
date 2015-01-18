// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library DataSet.Instance;

import "package:json_object/json_object.dart";

///
/// An instance has a collection of double elements and a bool that specifies if is form train (true) or not (false)
///

class Instance {

  List<double>elements;
  bool isForTrain;

  //
  // Constructor of instance. Just initialize the list of elements.
  //

  Instance() {

    elements = [];

  }

  //
  // Create an instance from an JsonObject.
  //
  // JSON format:
  // {
  //  "elements" : [2.1,1.3,2.3],
  //  "isForTrain : true
  //  }
  //

  Instance.fromJSON(JsonObject json){

    this.elements = json.elements;
    this.isForTrain = json.isForTrain;

  }

  //
  // Return the JsonObject of the instance.
  //

  JsonObject toJSON() {

    JsonObject instance = new JsonObject();
    instance.elements = this.elements;
    instance.isForTrain = this.isForTrain;
    return instance;

  }

}