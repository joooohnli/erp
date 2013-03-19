package include.tree_index;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.Security;

public class Nseer{
	NseerParent n=new NseerParent();
	public void init() {
		n.init();
	}
	public String E(String str) {
		String a = str;
		return a;
	}
	public String D(String str) {
		String a = str;
		return a;
	}
}