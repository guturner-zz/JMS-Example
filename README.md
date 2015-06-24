# JMS-Example
An academic project involving Java Messaging Services, AJAX, and jQuery.

**This application is under heavy development!** Check back for updates.

# Intro
Demonstrates knowledge of:
- Java
- Java Messaging Service (JMS)
- jQuery
- AJAX
- JavaServer Pages (JSP)
- Servlets
- Apache ActiveMQ
- Apache Tomcat

This repository contains multiple projects, each under the 'jms-example' directory (which serves as an Eclipse workspace). As of this edit, there are two projects:
- **controller**   : A hub for consuming messages. 
- **producer-one** : A "factory" for producing messages.

# Pre-Work
This project has some dependencies:
- The Apache ActiveMQ message broker should be running ([get ActiveMQ here](http://activemq.apache.org/)).
  - Navigate to apache-activemq-5.11.1\bin and run "activemq.bat start"
- An Apache Tomcat 7 server should be configured with the two projects.

Note that the necessary queues and connection factories are set up for you in the context.xml files.

# Running JMS-Example
It's recommended that you run each project in a separate browser (for example, utilizing Windows splitscreen mode).

Start your Apache Tomcat server and navigate to: 
- [localhost:8080/controller/](http://localhost:8080/controller/)
- [localhost:8080/producer-one/](http://localhost:8080/producer-one/)

Construct a message in the "producer-one" project by building the necessary components to form a widget. Then click the button to send the widget off to the "controller" project. In your other window, have some workers wait for a package.

# Explanation
The "producer-one" project largely served as a sandbox to test jQuery and AJAX code (including the progress bars for building components). By clicking the "send" ("Load Trucks") button, a servlet is called that forms a JMS-ready message and places it on the queue. The "controller" project lets you queue up listeners ("workers") ready to consume a message.

# More
With ActiveMQ running, you can visit [localhost:8161/admin/queues.jsp](http://localhost:8161/admin/queues.jsp) to manage your queue. (default credentials should be "admin" and "admin")
