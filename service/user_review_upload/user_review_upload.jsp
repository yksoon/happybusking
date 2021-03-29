<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/xml; charset=euc-kr" pageEncoding="utf-8"%>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@include file="/service_include.jsp" %>



<%
/*******************************************
* 공연
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
Date nowdate = new Date();

String now = sdf.format(nowdate);

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//업로드
		String folderName = "user" + USER_NO;
		String encType = "UTF-8";
		int size = 5*1024*1024; 
		
		String saveDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\user\\";
		String path = saveDirectory + folderName;
		
		//System.out.println("path : " + path);
		
		File dir = new File(path);
		
		if(!dir.exists()){
			dir.mkdirs();
		}

		//다중 업로드 처리(중복 방지)
		MultipartRequest multi = new MultipartRequest(request, path, size, encType, new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		while(files.hasMoreElements()){
			String file = (String) files.nextElement();
			String file_name = multi.getFilesystemName(file);
			String ori_file_name = multi.getOriginalFileName(file);
			
			String imagepath = path + "\\" + ori_file_name;
			File image = new File(imagepath);
			ImageSizeChange.confirmImageSizeAndResize(image, 0, 0);
		}
		
		String team_no = multi.getParameter("team_no");
		String pf_no = multi.getParameter("pf_no");
		String rimage = multi.getParameter("rimage");
		String rating = multi.getParameter("rating");
		String rtitle = multi.getParameter("rtitle");
		String rcontent = multi.getParameter("rcontent");
		
		
		sql = "INSERT INTO" + "\r\n" +
				"EPILOGUE(PF_NO, TEAM_NO, USER_NO, EPILOGUE_IMG, EPILOGUE_TITLE, EPILOGUE_CONTENT, RATY_STAR, EPILOGUE_DATE, EPILOGUE_DEL)" + "\r\n" +
				"VALUES('{pf_no}', '{team_no}', '{user_no}', '{rimage}', '{rtitle}', '{rcontent}', '{rating}', '{now}', 'N')";
		
		sql = sql.replace("{pf_no}", pf_no);
		sql = sql.replace("{user_no}", USER_NO);
		sql = sql.replace("{team_no}", team_no);
		sql = sql.replace("{rimage}", rimage);
		sql = sql.replace("{rtitle}", rtitle);
		sql = sql.replace("{rcontent}", rcontent);
		sql = sql.replace("{rating}", rating);
		sql = sql.replace("{now}", now);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate(sql);
		
		sql2 = "UPDATE USER_PERFORM_RECORD" + "\r\n" +
				"SET RECORD_CHK = 'Y'" + "\r\n" +
				"WHERE USER_NO = '" + USER_NO + "'\r\n" +
				"AND PF_NO = " + pf_no;
		
		pstmt.executeUpdate(sql2);
		
		result = true;
		msg = "등록되었습니다.";

	}catch(Exception e){
		result = false;
		msg = "다시 시도해주세요.";
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>
		</DATA>
	</ROOT> 
<%
try {
	rs.close();
} catch (Exception ex) {}
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>