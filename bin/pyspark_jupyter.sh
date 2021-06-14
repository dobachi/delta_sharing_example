#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..
. .profile

export PYSPARK_DRIVER_PYTHON=${PYSPARK_DRIVER_PYTHON:-jupyter}
export PYSPARK_DRIVER_PYTHON_OPTS=${PYSPARK_DRIVER_PYTHON_OPTS:-lab --ip=0.0.0.0 --no-browser}
export AWS_PROFILE=${delta_sharing:-delta_sharing}
export SPARK_LOCAL_IP=${SPARK_LOCAL_IP:-localhost}
export S3_TEST_URL=${S3_TEST_URL:-s3a://test}

PYSPARK_BIN=${PYSPARK_BIN:-/usr/local/spark/default/bin/pyspark}

if [ -z ${S3_ENDPOINT} ]; then
${PYSPARK_BIN} --packages org.apache.hadoop:hadoop-aws:3.2.0,org.apache.hadoop:hadoop-common:3.2.0,io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" --conf "spark.hadoop.fs.s3a.aws.credentials.provider=com.amazonaws.auth.profile.ProfileCredentialsProvider"
else
${PYSPARK_BIN} --packages org.apache.hadoop:hadoop-aws:3.2.0,org.apache.hadoop:hadoop-common:3.2.0,io.delta:delta-core_2.12:1.0.0 --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog" --conf "spark.hadoop.fs.s3a.aws.credentials.provider=com.amazonaws.auth.profile.ProfileCredentialsProvider" --conf "spark.hadoop.fs.s3a.endpoint=${S3_ENDPOINT}"
fi
