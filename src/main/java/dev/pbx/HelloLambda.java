package dev.pbx;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SQSEvent;

public class HelloLambda implements RequestHandler<SQSEvent, String> {

	private final Logger logger = LoggerFactory.getLogger( HelloLambda.class);

	@Override
	public String handleRequest( final SQSEvent sqsEvent, final Context context ) {

		sqsEvent.getRecords().forEach( sqsMessage -> logger.info( "Processing message {}", sqsMessage ) );

		return "Bye!";
	}
}
