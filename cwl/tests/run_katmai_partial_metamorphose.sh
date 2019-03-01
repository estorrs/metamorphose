#!/bin/bash

CWL="cwl/metamorphose.partial.cwl"
YAML="cwl/tests/katmai_partial_metamorphose_config.yaml"

mkdir -p cwl/tests/test_results
RABIX_ARGS="--basedir cwl/tests/test_results"

rabix $RABIX_ARGS $CWL $YAML
