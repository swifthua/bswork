package com.zh.utils;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

/**
 * 
 * @author zh
 * @datetime 2018-3-22下午3:11:57
 */
public class WorkUtils {
	
	/**
	 * 将字符串str去空格或者把null变为""
	 * @param str
	 * @return
	 */
	public static String trim(String str) {
		if (str == null || "null".equals(str)) {
			str = "";
		}
		return str.trim();
	}
	
	/**
	 * http协议传参时，以utf-8解析
	 * @author zh
	 * @date 2018年4月9日 下午12:31:49
	 */
	public static String getPar8(String val) {
		try {
			val = trim(val);
			val = java.net.URLDecoder.decode(val, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			val = "";
		}
		return val;
	}
	
	/**
	 * 获取中文对应的拼写 
	 * @author zh
	 * @date 2018年4月21日 下午10:11:32
	 */
    public static String converterToFirstSpell(String chines) {  
        String pinyinName = "";  
        char[] nameChar = chines.toCharArray();  
        HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();  
        defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);  
        defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);  
        for (int i = 0; i < nameChar.length; i++) {  
            String s = String.valueOf(nameChar[i]);  
            if (s.matches("[\\u4e00-\\u9fa5]")) {  
                try {  
                    String[] mPinyinArray = PinyinHelper.toHanyuPinyinStringArray(nameChar[i], defaultFormat);
                    if(nameChar.length<=2){  
                    	pinyinName += mPinyinArray[0];  
                    }else{
                    	if(i==0){
                    		pinyinName += mPinyinArray[0];  
                    	}else{
                    		pinyinName += mPinyinArray[0].substring(0,1); 
                    	}
                    }
                } catch (BadHanyuPinyinOutputFormatCombination e) {  
                    e.printStackTrace();  
                }  
            } else {  
                pinyinName += nameChar[i];  
            }  
        }  
        return pinyinName;  
    }  
    
    /**
     * 把String转换成java.util.Date的类型转换器
     * @author zh
     * @date 2018年4月22日 下午10:18:05
     */
	@SuppressWarnings("rawtypes")
	public static Object convertToDate(Class type, Object value) {
		if(value == null) return null;//如果要转换成值为null，那么直接返回null
		if(!(value instanceof String)) {//如果要转换的值不是String，那么就不转换了，直接返回
			return value;
		}
		String val = (String) value;//把值转换成String
		
		// 使用SimpleDateFormat进行转换
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			return sdf.parse(val);
		} catch (ParseException e) {
			throw new RuntimeException(e);
		}
	}
	
	/**
	 * 获取当前页码
	 * @param req
	 * @return
	 */
	public static int getPc(HttpServletRequest req) {
		int pc = 1;
		String param = req.getParameter("pc");
		if(param != null && !param.trim().isEmpty()) {
			try {
				pc = Integer.parseInt(param);
			} catch(RuntimeException e) {}
		}
		return pc;
	}
	
	/**
	 * 截取url，页面中的分页导航中需要使用它做为超链接的目标！
	 * @param req
	 * @return
	 */
	public static String getUrl(HttpServletRequest req) {
		String url = "";
		if( req.getQueryString()!=null){
			url = req.getRequestURI() + "?" + req.getQueryString();
		}else{
			url = req.getRequestURI() + "?";
		}
		//如果url中存在pc参数，截取掉，如果不存在那就不用截取。
		int index = url.lastIndexOf("&pc=");
		if(index != -1) {
			url = url.substring(0, index);
		}
		return url;
	}
	
}
