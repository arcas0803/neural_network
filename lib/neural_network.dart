// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library neural_network;

// TODO: Export any libraries intended for clients of this package.

export 'src/arquitecture/network.dart';
export 'src/arquitecture/layer.dart';
export 'src/arquitecture/neuron.dart';
export 'src/arquitecture/connection.dart';
export 'src/arquitecture/weight.dart';

export 'src/dataset/dataset.dart';
export 'src/dataset/instance.dart';

export 'src/filters/filter.dart';
export 'src/filters/normalization.dart';
export 'src/filters/randomization.dart';

export 'src/functions/activation/activation_function.dart';
export 'src/functions/activation/cosh_function.dart';
export 'src/functions/activation/gaussian_function.dart';
export 'src/functions/activation/lineal_function.dart';
export 'src/functions/activation/log_function.dart';
export 'src/functions/activation/sigmoid_function.dart';
export 'src/functions/activation/sinh_function.dart';
export 'src/functions/activation/step_function.dart';
export 'src/functions/activation/tanh_function.dart';

export 'src/functions/error/error_function.dart';
export 'src/functions/error/mean_square_error.dart';

export 'src/functions/input/input_function.dart';
export 'src/functions/input/difference_function.dart';
export 'src/functions/input/sum_function.dart';
export 'src/functions/input/max_function.dart';
export 'src/functions/input/min_function.dart';
export 'src/functions/input/radial_function.dart';
export 'src/functions/input/weight_combination_function.dart';

export 'src/functions/stop/stop_function.dart';
export 'src/functions/stop/max_iterations_function.dart';
export 'src/functions/stop/min_error_function.dart';
export 'src/functions/stop/weight_variation_function.dart';

export 'src/learning_rule/learning_rule.dart';
export 'src/learning_rule/supervised_learning.dart';
export 'src/learning_rule/unsupervised_learning.dart';
export 'src/learning_rule/basic_learning.dart';
export 'src/learning_rule/back_propagation_learning.dart';
export 'src/learning_rule/radial_learning.dart';

export 'src/nets/perceptron.dart';
export 'src/nets/adaline.dart';
export 'src/nets/multilayer_perceptron.dart';
export 'src/nets/radial_base.dart';




