/*
 * <OWNER> = Alvaro Arcas Garcia
 * <YEAR> = 2014
 *
 * In the original BSD license, the occurrence of "copyright holder" in the 3rd clause read "ORGANIZATION", placeholder for "University of California". In the original BSD license, both occurrences of the phrase "COPYRIGHT HOLDERS AND CONTRIBUTORS" in the disclaimer read "REGENTS AND CONTRIBUTORS".
 *
 * Here is the license template:
 *
 * Copyright (c) <2014>, <Alvaro Arcas Garcia>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
library Filter.Normalization;

import '../DataSet/dataset.dart';
import '../DataSet/instance.dart';
import 'filter.dart';
import 'dart:math';

class NormalizationFilter extends Filter {


  NormalizationFilter() {
    this.name = "Normailization";
  }

  List<Instance> applyFilter(DataSet input) {
    if (input.isSupervised) {
      for (int i = 0; i < input.numValues + input.numClassValues; i++) {
        input.setColumn(i, normalizationColumn(input.getColumn(i)));
      }
    } else {
      for (int i = 0; i < input.numValues; i++) {
        input.setColumn(i, normalizationColumn(input.getColumn(i)));
      }
    }

    return input.instances;
  }

  List normalizationColumn(List <double> column) {
    num maxim = column.reduce(max);
    num minim = column.reduce(min);
    List columnNormalized = [];
    for (num i = 0; i < column.length; i++) {
      columnNormalized.add((column[i] - minim) / (maxim - minim));
    }
    return columnNormalized;
  }
}