#!/bin/bash

export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="lab --ip=0.0.0.0 --no-browser"
export AWS_PROFILE=delta_sharing
export SPARK_LOCAL_IP=localhost

PYSPARK_BIN=/usr/local/spark/default/bin/pyspark
${PYSPARK_BIN} --packages org.apache.hadoop:hadoop-aws:3.2.0,org.apache.hadoop:hadoop-common:3.2.0,io.delta:delta-core_2.12:1.0.0 \
  --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" \
  --conf "spark.hadoop.fs.s3a.aws.credentials.provider=com.amazonaws.auth.profile.ProfileCredentialsProvider"
