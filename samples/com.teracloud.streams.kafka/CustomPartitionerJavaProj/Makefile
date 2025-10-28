.PHONY: all clean

JAVAC = $(STREAMS_JAVA_HOME)/bin/javac
JAR = $(STREAMS_JAVA_HOME)/bin/jar
CLASSPATH = $(STREAMS_INSTALL)/toolkits/com.teracloud.streams.kafka/opt/downloaded/*:../../com.teracloud.streams.kafka/opt/downloaded/*

all:
	mkdir -p build/classes/main; \
	mkdir -p build/libs; \
	$(JAVAC) -sourcepath src -d build/classes/main -classpath $(CLASSPATH) src/main/java/com/teracloud/streams/kafka/samples/partitioner/*.java ; \
	$(JAR) -cvf build/libs/custom-partitioner.jar -C build/classes/main com; \

clean:
	rm -rf build
