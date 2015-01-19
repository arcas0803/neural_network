# neural_network

A neural network library for Dart developers. Build your own networks. Extends the library functions and contribute.

## Usage data

To start using artificial neural networks on the data, we treat these data.
There are two types of sets, supervised and unsupervised :

    // The first parameter is the title of the dataSet.
    // The second parameter sets the number of attributes of the dataset.
    // The third parameter is optional and indicates the number of class values of the dataset.
    // In this case the data set is suspervised because it has class values (2).

    DataSet supervisedDataSetExample = new DataSet("SupervisedDataSetTest", 2, numClassValues: 2);

    // For an unsupervised data set dont use the optional parameter.

    DataSet unsupervisedDataSetExample = new DataSet("UnSupervisedDataSetTest", 2);

Add instances to your data set:

    //
    // Adding instances to the data set. The number of values in the list must be the same as the number of values and class values.
    // If not an exception will be throw.If you add an instance that is already in the dataset, this instance will not be added.
    //

    supervisedDataSetExample.addInstance([1.0,1.1,1.2,1.3]);
    unsupervisedDataSetExample.addInstance([1.0,1.1]);

    //
    // You can set if the new instance for add will be for train or for test.
    //

    supervisedDataSetExample.addInstance([0.0,0.1,0.2,0.3], true); // For train
    unsupervisedDataSetExample.addInstance([0.0,0.1], false); // For test

    //
    // Adding multiple instance. All instance must have the same number of values as the number of attributes and class values
    // of the data set.
    //
    supervisedDataSetExample.addInstances([[2.0,2.1,2.2,2.3],[3.0,3.1,3.2,3.3]]);
    unsupervisedDataSetExample.addInstances([[2.0,2.1],[3.0,3.1]]);

Removing instances:

      //
      // Removing instances. You can remove one instance or all instance from the dataSet.
      // For removing one instance just provide the index of that instance.
      //

      supervisedDataSetExample.removeInstance(3);
      unsupervisedDataSetExample.removeInstance(2);

      supervisedDataSetExample.removeAllInstances();
      unsupervisedDataSetExample.removeAllInstances();

Its possible to set label for the attributes of the data set:

    //
    // You can set the labels of the attributes and class values. Be sure that the number of labels is the same as the
    // number of attributes and class values. It is not equal an exception will be throw.
    //

    supervisedDataSetExample.labels = ["First", "Second", "Third", "Fourth"];
    unsupervisedDataSetExample.labels = ["First", "Second"];

You must choose which instances of the data set will be used to train and test them for :

    //
    // Set the number of instance for train and the instance for test.
    //

    supervisedDataSetExample.trainTestSet = 2; /// The dataset has 3 instances. 2 will be for train and 1 for test.
    unsupervisedDataSetExample.trainTestSet = 2; /// The dataset has 3 instances. 2 will be for train and 1 for test.


You may know many parameters of the data set :

      //
      // DataSet info. You can get a lot of information about the dataset.
      //

      supervisedDataSetExample.addInstances([[2.0,2.1,2.2,2.3],[3.0,3.1,3.2,3.3]]);
      unsupervisedDataSetExample.addInstances([[2.0,2.1],[3.0,3.1]]);

      // Get the number of attributes.

      int numAttributesSupervised = supervisedDataSetExample.numValues;
      int numAttributesUnsupervised = unsupervisedDataSetExample.numValues;

      // Get the number of class values. If the number of class values is 0, the dataset will be unsupervised.

      int numClassValuesSupervised = supervisedDataSetExample.numClassValues;
      int numClassValuesUnsupervised = unsupervisedDataSetExample.numClassValues; //Its 0

      // Get if the dataset is supervised. If true, the dataset is supervised, if not the dataset is unsupervised.

      supervisedDataSetExample.isSupervised; //True
      unsupervisedDataSetExample.isSupervised; //False

      // Get the minimum value present in each attribute or class value. If there are no instances it will return an empty array.

      List <double> minValuesSupervised = supervisedDataSetExample.minValues;
      List <double> minValuesUnsupervised = unsupervisedDataSetExample.minValues;

      // Get the maximum value present in each attribute or class value. If there are no instances it will return an empty array.

      List <double> maxValuesSupervised = supervisedDataSetExample.maxValues;
      List <double> maxValuesUnsupervised = unsupervisedDataSetExample.maxValues;

      // Get the mean value in each attribute or class value. If there are no instances it will return an empty array.

      List <double> meanValuesSupervised = supervisedDataSetExample.meanValues;
      List <double> meanValuesUnsupervised = unsupervisedDataSetExample.meanValues;

The application of filters to the data set is also possible :

      // Filters
      //
      // This library constains 2 basic filters that you can apply to a dataset.
      //

      //
      // Normalization filter. If there are no instances it will throw an exception.
      //

      NormalizationFilter normalization = new NormalizationFilter();
      supervisedDataSetExample.instances = normalization.applyFilter(supervisedDataSetExample);
      unsupervisedDataSetExample.instances = normalization.applyFilter(unsupervisedDataSetExample);

      //
      // Randomization filter. If there are no instances it will throw an exception.
      //

      RandomizeFilter random = new RandomizeFilter();
      supervisedDataSetExample.instances = random.applyFilter(supervisedDataSetExample);
      unsupervisedDataSetExample.instances = random.applyFilter(unsupervisedDataSetExample);

The library allows you to create custom networks neurons :



There are also four already implemented network topologies :

Adaline:

      // Adaline network.
      // The first parameter determines the number of cells input from the network.
      // The second parameter sets the maximum number of iterations of the network during learning.

      Adaline adalineNetwork = new Adaline(3,100);

      // Learn Process

      // Set the learning rate.

      adalineNetwork.learningRule.learningRate = 0.01;

      // Learn

      adalineNetwork.learningRule.learn(supervisedDataSetExample); //The dataset must be supervised

      // Get the error of all iterations.

      List<double> errorIterationsAdaline = (adalineNetwork.learningRule as BasicLearningRule).errorIterations;

Simple Perceptron:

        //Simple Perceptron network.
        // The first parameter determines the number of cells input from the network.
        // The second parameter sets the maximum number of iterations of the network during learning.

        Perceptron simplePerceptron = new Perceptron(3,100);

        // Learn Process

        // Set the learning rate.

        simplePerceptron.learningRule.learningRate = 0.01;

        // Learn

        simplePerceptron.learningRule.learn(supervisedDataSetExample); //The dataset must be supervised. The class value has to ve 1.o for one class and -1 for the other.

        // Get the error of all iterations.

        List<double> errorIterationsPerceptron = (simplePerceptron.learningRule as BasicLearningRule).errorIterations;

Multilayer Perceptron:

        // Multilayer Perceptron
        // The first parameter is a list of integer values. Each value indicates the number of neurons in one layer. The lenght
        // of the list indicates the number of network layers.
        // The second parameter sets the maximum number of iterations of the network during learning.

        MultilayerPerceptron multilayerPerceptron = new MultilayerPerceptron([3,3,3,3,3,1], 100);

        multilayerPerceptron.learningRule.learn(supervisedDataSetExample); //Supervised dataset needed.

        // Get the error of all iterations.

        List<double> errorIterationsMultilayer = (multilayerPerceptron.learningRule as BackPropagationLearningRule).errorIterations;

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
