// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library neural_network.test;

import 'package:unittest/unittest.dart';
import 'package:neural_network/neural_network.dart';

main() {

  group('Arquitecture test',(){

    test('Weight test', () {
      Weight weightTest = new Weight();

      expect(weightTest.variation == null,true);
      expect(weightTest.value > 0,true);
      expect(weightTest.previousValue == null, true);

      weightTest.increment(0.1);

      expect((weightTest.previousValue + 0.1) == weightTest.value, true);
      expect((weightTest.value - weightTest.previousValue).abs() == weightTest.variation,true);

      weightTest.increment(-0.1);

      expect((weightTest.previousValue - 0.1) == weightTest.value, true);
      expect((weightTest.value - weightTest.previousValue).abs() == weightTest.variation,true);


    });

    test('Connection test',(){
      Connection connectionTest = new Connection(new Neuron("origin"), new Neuron("destiny"));

      expect(connectionTest.neuronOrigin.id == "origin", true);
      expect(connectionTest.neuronDestination.id == "destiny", true);

      expect(connectionTest.weightPreviousValue == null, true);
      expect(connectionTest.weightVariation == null, true);
      expect(connectionTest.weightValue > 0, true);

      expect(connectionTest.inputNeuronDestination == 0.0, true);

      connectionTest.increment(0.1);

      expect((connectionTest.weightPreviousValue + 0.1) == connectionTest.weightValue, true);
      expect((connectionTest.weightValue - connectionTest.weightPreviousValue).abs() == connectionTest.weightVariation,true);

      connectionTest.increment(-0.1);

      expect((connectionTest.weightPreviousValue - 0.1) == connectionTest.weightValue, true);
      expect((connectionTest.weightValue - connectionTest.weightPreviousValue).abs() == connectionTest.weightVariation,true);

    });

    test('Neuron test', (){
      Neuron neuronTest = new Neuron("NeuronTest");

      expect(neuronTest.activationFunction == null, true);
      expect(neuronTest.inputFunction == null, true);
      expect(neuronTest.inputConnections.isEmpty , true);
      expect(neuronTest.outputConnections.isEmpty, true);
      expect(neuronTest.isThreshold, false);
      expect(neuronTest.hasInputConnection, false);
      expect(neuronTest.hasOutputConnection, false);

      neuronTest.addInputConnectionFromNeuron(new Neuron("InputNeuron1"));
      neuronTest.addInputConnectionFromNeuron(new Neuron("InputNeuron2"));
      neuronTest.addInputConnectionFromNeuron(new Neuron("InputNeuron3"));
      neuronTest.addInputConnectionFromNeuron(new Neuron("InputNeuron4"));

      expect(neuronTest.hasInputConnection, true);
      expect(neuronTest.weights.length == 4, true);

      Neuron neuronInputTest = new Neuron("InputNeuron5");

      neuronTest.addInputConnectionFromNeuron(neuronInputTest);

      expect(neuronTest.hasInputConnection, true);
      expect(neuronTest.weights.length == 5, true);
      expect(neuronTest.hasConnectionFromNeuron(neuronInputTest),true);
      expect(neuronInputTest.outputConnections.length == 1, true);
      expect(neuronTest.inputConnections[4].neuronDestination == neuronInputTest.outputConnections[0].neuronDestination, true);
      expect(neuronTest.inputConnections[4].neuronOrigin == neuronInputTest.outputConnections[0].neuronOrigin, true);

      Neuron neuronTestUmbral = new Neuron("UmbralTest");
      neuronTestUmbral.input = 1.0;
      neuronTestUmbral.output = 1.0;

      neuronTest.addInputConnectionFromNeuron(neuronTestUmbral);

      expect(neuronTestUmbral.isThreshold, true);
      neuronTestUmbral.calculateOutput();
      expect(neuronTestUmbral.input == neuronTestUmbral.output, true);

      neuronTest.removeInputConnectionFromNeuron(neuronInputTest);

      expect(neuronTest.hasConnectionFromNeuron(neuronInputTest),false);
      expect(neuronInputTest.hasConnectionToNeuron(neuronTest), false);

      neuronTest.removeAllInputConnections();

      expect(neuronTest.hasInputConnection, false);
      expect(neuronInputTest.hasOutputConnection, false);
    });

    test('Layer test',(){
      Layer layerTest = new Layer("LayerTest");

      expect(layerTest.hasNeurons, false);
      expect(layerTest.numNeurons == 0, true);

      Neuron neuronTest = new Neuron("NeuronTest");
      layerTest.addNeuron(neuronTest);

      expect(layerTest.hasNeurons, true);
      expect(layerTest.numNeurons == 1, true);
      expect(layerTest.getNeuron(0)==neuronTest,true);

      layerTest.removeNeuronAt(0);

      expect(layerTest.hasNeurons, false);
      expect(layerTest.numNeurons == 0, true);

      layerTest.createNeurons(5);

      expect(layerTest.hasNeurons, true);
      expect(layerTest.numNeurons == 5, true);

      layerTest.removeAllNeurons();

      expect(layerTest.hasNeurons, false);
      expect(layerTest.numNeurons == 0, true);


    });

    test('Network test', (){

      Layer layerTest0 = new Layer("inputLayer");
      Layer layerTest1 = new Layer("inputLayer1");
      Layer layerTest2 = new Layer("inputLayer2");
      Layer layerTest3 = new Layer("inputLayer3");
      Layer layerTest4 = new Layer("inputLayer4");

      layerTest0.createNeurons(4);
      layerTest1.createNeurons(8);
      layerTest2.createNeurons(8);
      layerTest3.createNeurons(6);
      layerTest4.createNeurons(3);

      Network networkTest = new Network();

      networkTest.addLayer(layerTest0);
      networkTest.addLayer(layerTest1);
      networkTest.addLayer(layerTest2);
      networkTest.addLayer(layerTest3);
      networkTest.addLayer(layerTest4);

      expect(networkTest.hasLayers, true);
      expect(networkTest.numNeurons == 29, true);
      expect(networkTest.numEntries == 4, true);
      expect(networkTest.numLayers == 5, true);
      expect(networkTest.numOutputs == 3, true);

      networkTest.inputNetwork = [2.1,2.3,4.1,1.1];

      expect(networkTest.layers[0].getNeuron(0).input == 2.1, true);
      expect(networkTest.layers[0].getNeuron(1).input == 2.3, true);
      expect(networkTest.layers[0].getNeuron(2).input == 4.1, true);
      expect(networkTest.layers[0].getNeuron(3).input == 1.1, true);

      expect(networkTest.inputNeurons ,equals(networkTest.layers[0].neurons));
      expect(networkTest.outputNeurons ,equals(networkTest.layers[4].neurons));

      networkTest = new Network();

      layerTest0.createNeurons(2);
      layerTest1.createNeurons(2);

      networkTest.addLayer(layerTest0);
      networkTest.addLayer(layerTest1);

      expect(networkTest.numEntries == 2, true);
      expect(networkTest.numOutputs == 2, true);
      expect(networkTest.numNeurons == 4, true);
      expect(networkTest.numLayers == 2, true);

      networkTest.connectLayers();

      expect(networkTest.layers[0].getNeuron(0).outputConnections.length == 2, true);
      expect(networkTest.layers[0].getNeuron(1).outputConnections.length == 2, true);
      expect(networkTest.layers[1].getNeuron(0).inputConnections.length == 2, true);
      expect(networkTest.layers[1].getNeuron(1).inputConnections.length == 2, true);

      expect(networkTest.layers[0].getNeuron(0).outputConnections[0].neuronDestination == networkTest.layers[1].getNeuron(0), true);
      expect(networkTest.layers[0].getNeuron(0).outputConnections[1].neuronDestination == networkTest.layers[1].getNeuron(1), true);
      expect(networkTest.layers[0].getNeuron(1).outputConnections[0].neuronDestination == networkTest.layers[1].getNeuron(0), true);
      expect(networkTest.layers[0].getNeuron(1).outputConnections[1].neuronDestination == networkTest.layers[1].getNeuron(1), true);

    });

  });

  group('Dataset test',(){
    test('SupervisedDataSet', (){
      DataSet dataSetTest = new DataSet("TEST",2,numClassValues:1);
      expect(dataSetTest.isSupervised, true);
      expect(dataSetTest.title == "TEST", true);
      expect(dataSetTest.numValues == 2, true);
      expect(dataSetTest.numClassValues == 1, true);
      expect(dataSetTest.instances.isEmpty , true);
      expect(dataSetTest.labels.isEmpty, true);

      dataSetTest.labels = ["At1","At2","At3"];
      expect(dataSetTest.labels, equals(["At1","At2","At3"]));

      dataSetTest.setLabelAt(0,"testSet");
      expect(dataSetTest.labels, equals(["testSet","At2","At3"]));

      expect(() => dataSetTest.labels = ["At1","At2","At3","At4"], throwsA(new isInstanceOf<String>()));


      dataSetTest.addInstances([[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]]);

      expect(dataSetTest.instancesValues, equals([[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]]));
      expect(dataSetTest.numberInstances == 3, true);

      dataSetTest.addInstance([5.1, 4.2, 5.2]);

      expect(dataSetTest.instancesValues, equals([[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4],[5.1, 4.2, 5.2]]));
      expect(dataSetTest.numberInstances == 4, true);

      dataSetTest.removeInstance(0);
      expect(dataSetTest.instancesValues, equals([[2.3, 4.3, 2.5],[2.2, 4.2, 2.4],[5.1, 4.2, 5.2]]));
      expect(dataSetTest.numberInstances == 3, true);

      expect(() => dataSetTest.trainSet, throws);
      expect(() => dataSetTest.testSet, throws);

      dataSetTest.sets = 2;

      expect(dataSetTest.numberTrainInstances == 2, true);
      expect(dataSetTest.numberTestInstances == 1, true);

      expect(dataSetTest.minValues, equals([2.2,4.2,2.4]));
      expect(dataSetTest.maxValues, equals([5.1, 4.3, 5.2]));
      expect(dataSetTest.meanValues, equals([3.2, 4.23, 3.37]));

      dataSetTest.setRow(0,[1.1,1.2,1.3]);

      expect(dataSetTest.getRow(0), equals([1.1,1.2,1.3]));

      expect(()=>dataSetTest.setRow(0,[1.1,1.2,1.3,1.4]), throws);

      expect(() => dataSetTest.removeRow(2),throws);

      dataSetTest.removeRow(0);

      expect(dataSetTest.instancesValues,equals([[4.3, 2.5],[4.2, 2.4],[4.2, 5.2]]));

    });

    test('NoSupervisedDataSet', (){
      DataSet dataSetTest = new DataSet("TEST",2);
      expect(dataSetTest.isSupervised, false);
      expect(dataSetTest.title == "TEST", true);
      expect(dataSetTest.numValues == 2, true);
      expect(dataSetTest.numClassValues == null, true);
      expect(dataSetTest.instances.isEmpty , true);
      expect(dataSetTest.labels.isEmpty, true);
    });
  });

  group('Filter test', (){
    test('Random', (){
      List <List <double>> values = [[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]];
      List <String> labels = ["At1","At2","At3"];

      DataSet dataSetTest = new DataSet("TEST",2,numClassValues: 1);
      dataSetTest.labels = labels;
      dataSetTest.addInstances(values);


      RandomizeFilter random = new RandomizeFilter();
      dataSetTest.instances = random.applyFilter(dataSetTest);

      expect(dataSetTest.instances.length==3,true);
    });
    test('Normalize', (){
      List <List <double>> values = [[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]];
      List <String> labels = ["At1","At2","At3"];

      DataSet dataSetTest = new DataSet("TEST",2,numClassValues: 1);
      dataSetTest.labels = labels;
      dataSetTest.addInstances(values);

      NormalizationFilter normalize = new NormalizationFilter();

      dataSetTest.instances = normalize.applyFilter(dataSetTest);

      expect(dataSetTest.instances.length==3,true);
      expect(dataSetTest.getRow(0), equals([0.0,1.0,0.5000000000000011]));
      expect(dataSetTest.getRow(1), equals([0.0,1.0,0.5000000000000022]));
      expect(dataSetTest.getRow(2), equals([0.0,1.0,0.5]));
    });
  });

  group('activation function test', (){
    test('CosH test',(){
      Cosh test = new Cosh();
      expect(test.getOutput(1.1) == 1.6685185538222564,true);
      expect(test.getDerivedOutput(1.1) == 1.335647470124177, true);
    });
    test('Gaussian test',(){
      Gaussian test = new Gaussian();
      expect(test.getOutput(1.1) == 0.0889216174593863,true);
      expect(test.getDerivedOutput(1.1) == -0.39125511682129976, true);
    });
    test('Lineal test',(){
      Lineal test = new Lineal();
      expect(test.getOutput(1.1) == 1.1,true);
      expect(test.getDerivedOutput(1.1) == 1.1, true);
    });
    test('Log test',(){
      Log test = new Log();
      expect(test.getOutput(1.1) == 0.09531017980432493,true);
      expect(test.getDerivedOutput(1.1) == 0.9090909090909091, true);
    });
    test('Sigmoid test',(){
      Sigmoid test = new Sigmoid();
      expect(test.getOutput(1.1) == 0.7502601055951177,true);
      expect(test.getDerivedOutput(1.1) == 0.18736987954752055, true);
    });
    test('SinH test',(){
      Sinh test = new Sinh();
      expect(test.getOutput(1.1) == 1.335647470124177 ,true);
      expect(test.getDerivedOutput(1.1) == 1.6685185538222564, true);
    });
    test('Step test',(){
      Step test = new Step();
      expect(test.getOutput(1.1) == 1.0,true);
      expect(test.getDerivedOutput(1.1) == null, true);
    });
    test('TanH test',(){
      Tanh test = new Tanh();
      expect(test.getOutput(1.1) == 0.8004990217606297 ,true);
      expect(test.getDerivedOutput(1.1) == 0.5993340605707929, true);
    });
  });

  group('Error function test', (){
    test('Mean Square Error test',(){
      MeanSquareError errorTest = new MeanSquareError();
      errorTest.addError([2.3,2.4,2.5]);
      expect(errorTest.error == 8.649999999999999, true);
      errorTest.addError([2.3,2.4,2.5]);
      errorTest.addError([2.3,2.4,2.5]);
      errorTest.addError([2.3,2.4,2.5]);
      errorTest.addError([2.3,2.4,2.5]);
      expect(errorTest.totalError() == 8.649999999999999,true);
      errorTest.reset();
      expect(errorTest.error == 0.0, true);
      expect(errorTest.numberSteps == 0, true);
    });
  });

  group('input function test', (){
    test('Difference test',(){
      Difference inputTest = new Difference();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 56.991227395100026, true);
    });

    test('Max test',(){
      Max inputTest = new Max();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 343.0,true);
    });

    test('Min test',(){
      Min inputTest = new Min();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 0.0, true);
    });

    test('Radial test',(){
      Radial inputTest = new Radial();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 56.991227395100026,true);
    });

    test('Sum test',(){
      Sum inputTest = new Sum();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 140.0,true);
    });

    test('Weight combination test',(){
      WeightCombination inputTest = new WeightCombination();
      List<Connection> inputConnections = [];
      for(int i = 0; i < 8; i++){
        Connection temp = new Connection(new Neuron("Neuron"+i.toString()),new Neuron("Neuron -"+i.toString()),double.parse(i.toString()));
        temp.neuronOrigin.output = double.parse((i*i).toString());
        inputConnections.add(temp);
      }
      expect(inputTest.getOutput(inputConnections) == 784.0, true);
    });
  });

  group('Net test', (){
    test('Adaline',(){
      DataSet dataSetTest = new DataSet("TEST",2,numClassValues:1);
      dataSetTest.labels = ["At1","At2","At3"];
      dataSetTest.addInstances([[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]]);
      dataSetTest.sets = 2;


      Adaline adaline = new Adaline(2,5);

      expect(adaline.inputNeurons.length == 2, true);
      expect(adaline.outputNeurons.length == 1, true);

      adaline.learningRule.learn(dataSetTest.trainSet);

    });

    test('Perceptron',(){
      DataSet dataSetTest = new DataSet("TEST",2,numClassValues:1);
      dataSetTest.labels = ["At1","At2","At3"];
      dataSetTest.addInstances([[2.1, 4.1, 2.3],[2.3, 4.3, 2.5],[2.2, 4.2, 2.4]]);
      dataSetTest.sets = 2;


      Perceptron perceptron = new Perceptron(2,5);

      expect(perceptron.inputNeurons.length == 2, true);
      expect(perceptron.outputNeurons.length == 1, true);

      perceptron.learningRule.learn(dataSetTest.trainSet);
    });

    test('Multilayer perceptron',(){
      DataSet dataSetTest = new DataSet("TEST",2,numClassValues:2);
      dataSetTest.labels = ["At1","At2","At3","At4"];
      dataSetTest.addInstances([[2.1, 4.1, 2.3,1.2],[2.3, 4.3, 2.5,1.3],[2.2, 4.2, 2.4,1.5]]);
      dataSetTest.sets = 2;

      MultilayerPerceptron multiLayerPerceptron = new MultilayerPerceptron([2,4,2],50000);

      expect(multiLayerPerceptron.inputNeurons.length == 2, true);
      expect(multiLayerPerceptron.outputNeurons.length == 2, true);

      multiLayerPerceptron.learningRule.learn(dataSetTest.trainSet);

    });

    test('Radial base',(){



    });
  });
}