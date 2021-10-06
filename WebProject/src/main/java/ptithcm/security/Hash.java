package ptithcm.security;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
public class Hash {
	 private static final Charset UTF_8 = StandardCharsets.UTF_8;
	    private static final String OUTPUT_FORMAT = "%-20s:%s";
	    private static String secret1 = "@*Z$^Agka";
	    private static String secret2 = "#A!Q%Hb";
	    
	    public static byte[] digest(byte[] input) {
	        MessageDigest md;
	        try {
	            md = MessageDigest.getInstance("SHA-256");
	        } catch (NoSuchAlgorithmException e) {
	            throw new IllegalArgumentException(e);
	        }
	        byte[] result = md.digest(input);
	        return result;
	    }

	    public static String bytesToHex(byte[] bytes) {
	        StringBuilder sb = new StringBuilder();
	        for (byte b : bytes) {
	            sb.append(String.format("%02x", b));
	        }
	        return sb.toString();
	    }
	    
	    public static String getHash256(String plaintext) {
	    	return bytesToHex(digest((secret1 + plaintext + secret2).getBytes()));
	    }
	    
}
