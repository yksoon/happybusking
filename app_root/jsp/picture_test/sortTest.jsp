<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%@ page session="false" %>
<%@ page import = "java.sql.*, java.io.*, java.util.*, java.lang.*,java.net.*,org.json.simple.*"%>
<%@ page import = "java.io.File, java.util.Arrays, java.util.Date, java.util.Comparator"%>

<%@ page import = "com.oreilly.servlet.*,com.oreilly.servlet.multipart.*" %>
<%@ page import = "org.json.simple.JSONObject"%>
<%!
    public String GetDate(String sFormat) {
        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat(sFormat);
        java.util.Date   currentdate =  new java.util.Date();
        return  formatter.format(currentdate);
    }
%>
<%
	// Create a file object
	File file = new File("D://heartpay/workspace/HeartPay/web/app_root/testImg");
	File[] fileList = file.listFiles();
	int len = fileList.length;
	//fileList = sortFileList(file,COMPARETYPE_DATE); // Date·Î Sort½ÇÇà
	//String callBack = request.getParameter("callback"); 
	String callBack = "fileName";
	
	JSONObject jsonObj = new JSONObject(); 
	jsonObj.put("success", fileList[len-1].getName()); 
	
	PrintWriter pw = response.getWriter(); 

	pw.print(callBack+"("+jsonObj.toString()+")"); 
	pw.flush(); 
	pw.close();

%>
