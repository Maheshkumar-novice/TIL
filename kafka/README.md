List consumer groups

```sh
kafka-consumer-groups --bootstrap-server localhost:9092 --describe --all-groups
```

Stats Callback for Consumer

```py
# https://github.com/confluentinc/confluent-kafka-python/blob/master/tests/test_misc.py
def test_stats_cb():
    """ Tests stats_cb. """
    seen_stats_cb = False

    def stats_cb(stats_json_str):
        nonlocal seen_stats_cb
        seen_stats_cb = True
        stats_json = json.loads(stats_json_str)
        assert len(stats_json['name']) > 0

    conf = {'group.id': 'test',
            'session.timeout.ms': 1000,  # Avoid close() blocking too long
            'statistics.interval.ms': 200,
            'stats_cb': stats_cb
            }

    kc = confluent_kafka.Consumer(**conf)

    kc.subscribe(["test"])
    while not seen_stats_cb:
        kc.poll(timeout=0.1)
    kc.close()
```

Confluent kafka logging,

https://github.com/confluentinc/confluent-kafka-python/blob/master/tests/test_log.py

We can use `debug` and `logger` conf.
