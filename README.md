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

Openshift S2I
=============

Here is a simple step by step procedure to have an Springboot Hello World: https://developers.redhat.com/blog/2017/02/23/getting-started-with-openshift-java-s2i/ 

## Step 1: create a project

```
$ oc new-project myproject
Now using project "myproject" on server "https://master-c1.openshift.zoobab.com:8443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git

to build a new example application in Ruby.
$ 
```

## Step 2: install the 'sdk'

```
$ oc create -f https://gist.githubusercontent.com/tqvarnst/3ca512b01b7b7c1a1da0532939350e23/raw/3869a54c7dd960965f0e66907cdc3eba6d160cad/openjdk-s2i-imagestream.json
imagestream "redhat-openjdk18-openshift" created
$ 
```

## Step 3: trigger a build

```
$ oc new-app myproject/redhat-openjdk18-openshift~https://github.com/zoobab/sbdemo.git
--> Found image da64e35 (2 weeks old) in image stream "myproject/redhat-openjdk18-openshift" under tag "latest" for "myproject/redhat-openjdk18-openshift"

    Java Applications
    -----------------
    Platform for building and running plain Java applications (fat-jar and flat classpath)

    Tags: builder, java

    * A source build using source code from https://github.com/zoobab/sbdemo.git will be created
      * The resulting image will be pushed to image stream "sbdemo:latest"
      * Use 'start-build' to trigger a new build
    * This image will be deployed in deployment config "sbdemo"
    * Ports 8080/tcp, 8443/tcp, 8778/tcp will be load balanced by service "sbdemo"
      * Other containers can access this service through the hostname "sbdemo"

--> Creating resources ...
    imagestream "sbdemo" created
    buildconfig "sbdemo" created
    deploymentconfig "sbdemo" created
    service "sbdemo" created
--> Success
    Build scheduled, use 'oc logs -f bc/sbdemo' to track its progress.
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose svc/sbdemo'
    Run 'oc status' to view your app.

```
    
You should get 2 pods (one for the build, one for the run):
    
```
$ oc get pods
NAME             READY     STATUS      RESTARTS   AGE
sbdemo-1-build   0/1       Completed   0          1m
sbdemo-1-ggrfr   1/1       Running     0          52s
```

Check the logs of the running pod:

```
$ oc logs sbdemo-1-ggrfr
Starting the Java application using /opt/jboss/container/java/run/run-java.sh ...
INFO exec  java -javaagent:/opt/jboss/container/jolokia/jolokia.jar=config=/opt/jboss/container/jolokia/etc/jolokia.properties -XX:+UseParallelOldGC -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MaxMetaspaceSize=100m -XX:+ExitOnOutOfMemoryError -cp "." -jar /deployments/myproject-0.0.1-SNAPSHOT.jar
OpenJDK 64-Bit Server VM warning: If the number of processors is expected to increase from one, then you should configure the number of parallel GC threads appropriately using -XX:ParallelGCThreads=N
I> No access restrictor found, access to any MBean is allowed
Jolokia: Agent started with URL https://10.121.0.97:8778/jolokia/

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::        (v2.1.0.RELEASE)

2019-03-08 09:56:53.114  INFO 1 --- [           main] Example                                  : Starting Example on sbdemo-1-ggrfr with PID 1 (/deployments/myproject-0.0.1-SNAPSHOT.jar started by jboss in /deployments)
2019-03-08 09:56:53.118  INFO 1 --- [           main] Example                                  : No active profile set, falling back to default profiles: default
2019-03-08 09:56:54.717  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2019-03-08 09:56:54.746  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2019-03-08 09:56:54.746  INFO 1 --- [           main] org.apache.catalina.core.StandardEngine  : Starting Servlet Engine: Apache Tomcat/9.0.12
2019-03-08 09:56:54.759  INFO 1 --- [           main] o.a.catalina.core.AprLifecycleListener   : The APR based Apache Tomcat Native library which allows optimal performance in production environments was not found on the java.library.path: [/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib]
2019-03-08 09:56:54.953  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2019-03-08 09:56:54.953  INFO 1 --- [           main] o.s.web.context.ContextLoader            : Root WebApplicationContext: initialization completed in 1768 ms
2019-03-08 09:56:54.980  INFO 1 --- [           main] o.s.b.w.servlet.ServletRegistrationBean  : Servlet dispatcherServlet mapped to [/]
2019-03-08 09:56:54.983  INFO 1 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'characterEncodingFilter' to: [/*]
2019-03-08 09:56:54.983  INFO 1 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'hiddenHttpMethodFilter' to: [/*]
2019-03-08 09:56:54.983  INFO 1 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'formContentFilter' to: [/*]
2019-03-08 09:56:54.984  INFO 1 --- [           main] o.s.b.w.servlet.FilterRegistrationBean   : Mapping filter: 'requestContextFilter' to: [/*]
2019-03-08 09:56:55.235  INFO 1 --- [           main] o.s.s.concurrent.ThreadPoolTaskExecutor  : Initializing ExecutorService 'applicationTaskExecutor'
2019-03-08 09:56:55.590  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2019-03-08 09:56:55.593  INFO 1 --- [           main] Example                                  : Started Example in 2.997 seconds (JVM running for 3.616)
```

TODO
====

1. Expose the 8080 to the outside world
2. Do a curl on the URL
3. Find a config to pull from the GIT periodically to trigger the build
