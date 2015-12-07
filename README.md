Fake-SQS
==================
Docker image for the fake_sqs gem.

Features
---------
* Uses thin as webserver to prevent reverse dns lookup (causing big slowdowns)
* Exposes fake_sqs database to "/sqs" VOLUME for file based verification
  * Note that fake_sqs does not persist messages, just queues

Running
-------
`$ docker run -it -p 9494:9494 feathj/fake-sqs`

Note that `VIRTUAL_HOST` environment variable can be added if run with dinghy client
`$ docker run -it -p 9494:9494 -e VIRTUAL_HOST=sqs.docker feathj/fake-sqs`

Or from docker-compose.yml:
```
sns:
  image: feathj/fake-sqs
  ports:
    - "9494:9494"
  environment:
    VIRTUAL_HOST: "sqs.docker"
```

Getting started
---------------
The following curl commands can be run to verify that it is working (create queue, send message, receive message, assumes host is 'sqs.docker'):

`$ curl http://sqs.docker:9494 -d "Action=CreateQueue&QueueName=test-queue&AWSAccessKeyId=access%20key%20id"`  
`$ curl http://sqs.docker:9494 -d "Action=SendMessage&QueueUrl=http%3A%2F%2Fsqs.docker%3A9494%2Ftest-queue&MessageBody=testing123&AWSAccessKeyId=access%20key%20id"`  
`$ curl http://sqs.docker:9494 -d "Action=ReceiveMessage&QueueUrl=http%3A%2F%2Fsqs.docker%3A9494%2Ftest-queue&AWSAccessKeyId=access%20key%20id"`


Related Repos
-------------
[fake_sqs](https://github.com/iain/fake_sqs)
[docker-fake-sns](https://github.com/feathj/docker-fake-sns)
