Helloworld in Springboot, with Docker and Kubernetes
====================================================

This demo builds a simple helloworld in Springboot, makes Docker container, and
deploys it in a Kubernetes cluster.

Run
===

Run it from Docker:

```
$ docker run -p8080:8080 zoobab/sbdemo
Application is running as root (UID 0). This is considered insecure.

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.0.RELEASE)

2019-03-04 17:11:44.220  INFO 23 --- [           main] Example                                  : Starting Example on 0d514a92b992 with PID 23 (/app/target/myproject-0.0.1-SNAPSHOT.jar started by root in /app/target)
2019-03-04 17:11:44.224  INFO 23 --- [           main] Example                                  : No active profile set, falling back to default profiles: default
2019-03-04 17:11:45.459  INFO 23 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2019-03-04 17:11:45.482  INFO 23 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2019-03-04 17:11:45.483  INFO 23 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet Engine: Apache Tomcat/9.0.12
2019-03-04 17:11:45.494  INFO 23 --- [           main] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/usr/java/packages/lib:/usr/lib/x86_64-linux-gnu/jni:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/lib/jni:/lib:/usr/lib]
2019-03-04 17:11:45.570  INFO 23 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-03-04 17:11:45.570  INFO 23 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1288 ms
2019-03-04 17:11:45.597  INFO 23 --- [           main] o.s.b.w.servlet.ServletRegistrationBean  : Servlet dispatcherServlet mapped to [/]
2019-03-04 17:11:45.600  INFO 23 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'characterEncodingFilter' to: [/*]
2019-03-04 17:11:45.601  INFO 23 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
2019-03-04 17:11:45.601  INFO 23 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'formContentFilter' to: [/*]
2019-03-04 17:11:45.601  INFO 23 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'requestContextFilter' to: [/*]
2019-03-04 17:11:45.942  INFO 23 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2019-03-04 17:11:46.180  INFO 23 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2019-03-04 17:11:46.186  INFO 23 --- [           main] Example                                  : Started Example in 2.56 seconds (JVM running for 3.003)
```

Then hit port 8080 with curl:

```
$ curl localhost:8080
Hello World 15H10!
```

Kubernetes yaml
===============

TODO

Openshift s2i
=============

To document here
