# Loans Project Config Files

In this folder lays all configuration files and Argo CD setup. Other part of the project can be found [here](https://github.com/osber1/loans).

## Links

- [Back-office Actuator](http://back-office.osber.io/actuator)
- [Risk Checker Actuator](http://risk.osber.io/actuator)
- [Notifications Service Actuator](http://notifications.osber.io/actuator)
- [RabbitMQ](http://rabbitmq.osber.io)
- [Mailhog](http://mailhog.osber.io)
- [pgAdmin](http://pgadmin.osber.io)
- [Redis Commander](http://redis.osber.io)
- [Vault](http://vault.osber.io)
- [Prometheus](http://prometheus.osber.io)
- [Grafana](http://grafana.osber.io)
- [Kibana](http://kibana.osber.io)

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