#!/bin/bash

CWL="cwl/amphibolite.cwl"
YAML="cwl/tests/amphibolite_config.yaml"

mkdir -p cwl/tests/test_results
RABIX_ARGS="--basedir cwl/tests/test_results"

rabix $RABIX_ARGS $CWL $YAML
