// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library TestingRule;

import '../functions/error/error_function_export.dart';
import '../dataset/dataset_export.dart';
import '../arquitecture/arquitecture_export.dart';

//
// Used to pass a test for supervised network
//

class TestingRule{

  List<double> errorTests;
  List<List<double>> outputNetworkTest;
  ErrorFunction errorFunction;
  Network network;

  //
  // Create a test to validate a trained neural network.
  //

  TestingRule(this.errorFunction, this.network){
    this.errorTests = [];
    this.outputNetworkTest = [];
  }

  //
  // Test process.
  //

  void test(DataSet dataSet){
    for (int i = 0; i < dataSet.instances.length; i++) {
      if(dataSet.instances[i].isForTrain != null && !dataSet.instances[i].isForTrain)
        this.testPattern(dataSet.instanceValues(i), dataSet.instanceClassValues(i));
    }
    this.errorTests.add(this.errorFunction.totalError());
    this.errorFunction.reset();
  }

  //
  // Test a pattern
  //

  void testPattern(List <double> pattern, List<double> desireOutput){
    this.network.inputNetwork = pattern;
    this.network.calculateOutput();
    List <double> outputNetwork = this.network.outputNetwork;
    this.outputNetworkTest.add(outputNetwork);
    List <double> outputNetworkError = this.calculateOutputError(outputNetwork, desireOutput);
    this.errorFunction.addError(outputNetworkError);
  }

  //
  // Calculate the error of the network in the test process.
  //

  List <double> calculateOutputError(List<double>output, List<double>desireOutput) {
    List outputFinal = [];
    for (int i = 0; i < desireOutput.length; i++) {
      outputFinal.add(desireOutput[i] - output[i]);
    }
    return outputFinal;
  }

}