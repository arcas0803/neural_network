// Copyright (c) 2014, <Alvaro Arcas Garcia>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library StopCondition.StopCondition;

import "package:json_object/json_object.dart";

/// Interface for implementing new stop conditions.

abstract class StopCondition {

  bool isReached();

}




