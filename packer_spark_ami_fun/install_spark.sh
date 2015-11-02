sudo apt-get update
sudo apt-get -y install curl unzip
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# -- JAVA --
export JAVA_HOME="/usr/jdk1.8.0_31"
export PATH="$PATH:$JAVA_HOME/bin"

curl -sL \
  --retry 3 \
  --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz" \
  | sudo gunzip \
  | sudo tar x -C /usr/ \
  && sudo ln -s $JAVA_HOME /usr/java \
  && sudo rm -rf $JAVA_HOME/man

# -- SPARK --
export SPARK_VERSION=1.4.1
export HADOOP_VERSION=2.4
export SPARK_PACKAGE="$SPARK_VERSION-bin-hadoop$HADOOP_VERSION"
export SPARK_HOME="/usr/spark-$SPARK_PACKAGE"
export PATH="$PATH:$SPARK_HOME/bin"
curl -sL \
  --retry 3 \
  "http://mirrors.ibiblio.org/apache/spark/spark-$SPARK_VERSION/spark-$SPARK_PACKAGE.tgz" \
  | gunzip \
  | sudo tar x -C /usr/ \
  && sudo ln -s $SPARK_HOME /usr/spark

# -- HADOOP/S3 --
curl -sL \
  --retry 3 \
  "http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.6.0/hadoop-aws-2.6.0.jar" \
  -o $SPARK_HOME/lib/hadoop-aws-2.6.0.jar
curl -sL \
  --retry 3 \
  "http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.14/aws-java-sdk-1.7.14.jar" \
  -o $SPARK_HOME/lib/aws-java-sdk-1.7.14.jar
curl -sL \
  --retry 3 \
  "http://central.maven.org/maven2/com/google/collections/google-collections/1.0/google-collections-1.0.jar" \
  -o $SPARK_HOME/lib/google-collections-1.0.jar
curl -sL \
  --retry 3 \
  "http://central.maven.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2.jar" \
  -o $SPARK_HOME/lib/joda-time-2.8.2.jar

sleep 60
