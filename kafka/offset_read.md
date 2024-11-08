https://developer.confluent.io/tutorials/kafka-console-consumer-read-specific-offsets-partitions/kafka.html

kafka-console-consumer --topic example-topic --bootstrap-server broker:9092 \
 --property print.key=true \
 --property key.separator="-" \
 --partition 1 \
 --offset 6


use max messages if the consumer blocks when you want are redirecting. i have a python script also that I will store here later.
