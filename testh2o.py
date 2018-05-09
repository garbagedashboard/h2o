import pyspark
#import h2o
from  pysparkling import *

import os
os.environ["PYTHON_EGG_CACHE"] = "~/"
spark = pyspark.sql.SparkSession.builder.appName('etl').getOrCreate()
#h2o.init()
h2o_context = H2OContext.getOrCreate(spark)
h2o_context.stop_with_jvm()
spark.stop()

