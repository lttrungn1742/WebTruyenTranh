package ptithcm.security;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;

import org.json.JSONException;
import org.json.JSONObject;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;

public class JsonWebToken {
	
	private static String secret = "@Z#Aza$secret^G&Haz*";
	static DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE_TIME;
	
	public static String createJWT(String field) {
		  try {
			    Algorithm algorithm = Algorithm.HMAC256(secret);
			    
			    LocalDateTime dateTime = LocalDateTime.now().plusHours(1);
			    
			    String    token = JWT.create().withClaim("User", field)
			    		.withClaim("time",	dateTime.format(formatter))
			    			.sign(algorithm);
			    
			    return token;
			    
			} catch (JWTCreationException exception){
			    //Invalid Signing configuration / Couldn't convert Claims.
				return null;
			}   
	}
	
	public static JSONObject getJson(String token) throws JSONException {
		JSONObject obj;
		  try {
		      Algorithm algorithm = Algorithm.HMAC256(secret);
		      JWTVerifier verifier = JWT.require(algorithm).build(); //Reusable verifier instance
		      DecodedJWT jwt = verifier.verify(token);
		      byte[] bytes = Base64.getUrlDecoder().decode(jwt.getPayload());
		      obj  = new JSONObject((new String(bytes, StandardCharsets.UTF_8)));
		  } catch (JWTVerificationException exception){
			  obj = new JSONObject("{\"success\":false}");
		  }
		return obj;
	}
	
	public static boolean verifier(String token)  {
		  try {
		      Algorithm algorithm = Algorithm.HMAC256(secret);
		      JWTVerifier verifier = JWT.require(algorithm).build(); //Reusable verifier instance
		      DecodedJWT jwt = verifier.verify(token);
		      return true;
		  } catch (JWTVerificationException exception){
			  return false;
		  }
		
	}
	
}

