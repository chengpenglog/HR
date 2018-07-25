package top.goingtop.util;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * 加密工具
 * @author cheng
 *
 */
public class MD5Util {

	
	/**
	 * Md5加密
	 * @param str
	 * @param salt
	 * @return
	 */
	public static String md5(String str,String salt){
		return new Md5Hash(str,salt).toString();
	}
	
	public static void main(String[] args) {
		String password="111";
		System.out.println("Md5加密："+MD5Util.md5(password, "152872"));
	}
}
