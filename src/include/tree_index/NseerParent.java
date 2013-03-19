package include.tree_index;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.Security;

public class NseerParent {
	private SecretKey deskey;
	private Cipher c;	

	public NseerParent() {
		init();
	}	
	public void init() {
		Security.addProvider(new com.sun.crypto.provider.SunJCE());
		try {
			String key = "nSe@68er";
			DESKeySpec desKeySpec = new DESKeySpec(key.getBytes("UTF-8"));
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			deskey = keyFactory.generateSecret(desKeySpec);
			c = Cipher.getInstance("DES");
		} catch (NoSuchAlgorithmException ex) {
			ex.printStackTrace();
		} catch (NoSuchPaddingException ex) {
			ex.printStackTrace();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public String E(String str) {
		String a = "";
		try {
			byte[] cipherByte;
			c.init(Cipher.ENCRYPT_MODE, deskey);
			cipherByte = c.doFinal(str.getBytes("UTF-8"));
			a = new sun.misc.BASE64Encoder().encode(cipherByte);
		} catch (java.security.InvalidKeyException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.BadPaddingException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.IllegalBlockSizeException ex) {
			ex.printStackTrace();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return a;
	}

	public String D(String str) {
		String a = "";
		try {
			byte[] cipherByte;
			byte[] b = new sun.misc.BASE64Decoder().decodeBuffer(str);
			c.init(Cipher.DECRYPT_MODE, deskey);
			cipherByte = c.doFinal(b);
			a = new String(cipherByte, "UTF-8");
		} catch (java.security.InvalidKeyException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.BadPaddingException ex) {
			ex.printStackTrace();
		} catch (javax.crypto.IllegalBlockSizeException ex) {
			ex.printStackTrace();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return a;
	}
}
