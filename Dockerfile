#h2o spark cluster ubuntu image

FROM  jiata/aztk:0.1.0-spark2.2.0-python3.5.4
MAINTAINER Daisy Deng

# Add Usr h2o

#RUN useradd -m h2o && echo "h2o:h2o" | chpasswd && adduser h2o sudo

#ADD /sudoers.txt /etc/sudoers
#RUN chmod 440 /etc/sudoers

#USER h2o
#CMD /bin/bash


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libatlas-base-dev gfortran 

RUN mkdir -p /opt/pandas/build/

COPY requirements.txt /opt/pandas/build/requirements.txt

RUN pip install -r /opt/pandas/build/requirements.txt
  
RUN \
  # Fetch h2o_pysparkling
  apt-get -y install python-pip && \
  pip install http://h2o-release.s3.amazonaws.com/h2o/rel-weierstrass/7/Python/h2o-3.14.0.7-py2.py3-none-any.whl && \
  pip install h2o_pysparkling_2.2 && \
  wget http://h2o-release.s3.amazonaws.com/sparkling-water/rel-2.2/2/sparkling-water-2.2.2.zip && \
  apt-get install unzip && \
  unzip sparkling-water-2.2.2.zip && \
  pip install azure-storage-blob

ENV SPARKLING_WATER=/sparkling-water-2.2.2/assembly/build/libs/sparkling-water-assembly_2.11-2.2.2-all.jar
  
CMD \
  ["/bin/bash"]
