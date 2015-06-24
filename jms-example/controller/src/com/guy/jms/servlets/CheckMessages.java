package com.guy.jms.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.activemq.ActiveMQConnectionFactory;

/**
 * Servlet implementation class JMSTest
 */
@WebServlet("/CheckMessages")
public class CheckMessages extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckMessages() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = "tcp://localhost:61616";
		
		PrintWriter out = response.getWriter();
		ActiveMQConnectionFactory connectionFactory = new ActiveMQConnectionFactory(url);
		QueueConnection connection = null;
		MessageConsumer consumer = null;
		Session session = null;
		try {
			connection = (QueueConnection) connectionFactory.createQueueConnection();
			connection.start();
			
			session     = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			Queue queue = session.createQueue("jms/queue/ProducerOneQueue");
			consumer    = session.createConsumer(queue);
			
			Message message    = consumer.receive();
			TextMessage txtMsg = (TextMessage) message;
			out.write("Producer One says: " + txtMsg.getText());
			
			
		} catch (JMSException e) {
			
			e.printStackTrace();
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
				
				if (consumer != null) {
					consumer.close();
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
