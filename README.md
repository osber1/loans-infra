# Loans Project Config Files

In this folder lays all configuration files and Argo CD setup. Other part of the project can be found [here](https://github.com/osber1/loans).

## Links

| Docker                                                           | Kubernetes                                                               |
|------------------------------------------------------------------|--------------------------------------------------------------------------|
| [Back-office Actuator](http://localhost:8080/actuator)           | [Back-office Actuator](http://back-office.osber.io/actuator)             |
| [Risk Checker Actuator](http://localhost:8081/actuator)          | [Risk Checker Actuator](http://risk.osber.io/actuator)                   |
| [Notifications Service Actuator](http://localhost:8082/actuator) | [Notifications Service Actuator](http://notifications.osber.io/actuator) |
| [RabbitMQ](http://localhost:15672)                               | [RabbitMQ](http://rabbitmq.osber.io)                                     |
| [Mailhog](http://localhost:8025)                                 | [Mailhog](http://mailhog.osber.io)                                       |
| [pgAdmin](http://localhost:5050)                                 | [pgAdmin](http://pgadmin.osber.io)                                       |
| [Redis Commander](http://localhost:5123)                         | [Redis Commander](http://redis.osber.io)                                 |
| [Vault](http://localhost:8200)                                   | [Vault](http://vault.osber.io)                                           |
| [Prometheus](http://localhost:9090)                              | [Prometheus](http://prometheus.osber.io)                                 |
| [Grafana](http://localhost:3000)                                 | [Grafana](http://grafana.osber.io)                                       |
| [Kibana](http://localhost:5601)                                  | [Kibana](http://kibana.osber.io)                                         |

## Startup

### Command Line

Run `./start.sh` to start everything.

## pgAdmin

* Username: admin@admin.com
* Password: admin

### Add new server connection

- url: postgres
- username: root
- password: root

## Vault

* Method: Token
* Token: super-secret-token

## RabbitMQ

* Username: guest
* Password: guest

## Grafana

* Username: admin
* Password: admin