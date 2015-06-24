package com.guy.jms.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class SendMessage
 */
@WebServlet("/SendMessage")
public class SendMessage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SendMessage() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		Connection connection = null;
		ConnectionFactory connectionFactory = null;
		Session session = null;
		try {
			InitialContext initCtx = new InitialContext();
			Context envContext     = (Context) initCtx.lookup("java:comp/env");
			connectionFactory      = (ConnectionFactory) envContext.lookup("jms/ConnectionFactory");
			
			connection               = connectionFactory.createConnection();
			session                  = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);
			Destination destination  = session.createQueue("jms/queue/ProducerOneQueue");
			MessageProducer producer = session.createProducer(destination);
			
			TextMessage msg = session.createTextMessage();
			msg.setText("Production Factory One");
			
			producer.send(msg);
			out.write("0Sending the package along!");
			
		} catch (NamingException e) {
			out.write("NamingException: " + e);
		} catch (JMSException e) {
			if (e.getMessage().contains("Could not connect to broker")) {
				out.write("1Our drivers don't know how to get to the main road! (hint, check ActiveMQ connection)");
			} else {
				out.write(e.getMessage());
			}
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
				
				if (session != null) {
					session.close();
				}
			} catch (JMSException e1) {
				out.write("JMSException closing connection: " + e1);
			}
			
			out.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
