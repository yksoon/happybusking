<?xml version="1.0" encoding="utf-8"?>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Date"%>
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
* 관리자 페이지 - 공지사항 작성(UPDATE)
*******************************************/
String sql = "";
String sql2 = "";
Connection conn = null;
PreparedStatement pstmt = null;

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat ntSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
String tno1 = ntSdf.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
String tno2 = String.format("%04d", randNum);
String ntNo = tno1 + tno2;


//현재 날짜 구해서 INSERT
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String now = sdf.format(nowdate);


conn = dbconn.dbconnect();

try{

	String encType = "UTF-8";
	int size = 5*1024*1024; 
	
	String saveDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\user\\user0";
	
	File dir = new File(saveDirectory);
	
	if(!dir.exists()){
		dir.mkdirs();
	}
	
	//다중 업로드 처리(중복 방지)
	MultipartRequest multi = new MultipartRequest(request, saveDirectory, size, encType, new DefaultFileRenamePolicy());
	
	Enumeration files = multi.getFileNames();
	//System.out.println("############getFileNames:" + multi.getFileNames());
	while(files.hasMoreElements()){
		String file = (String) files.nextElement();
		String file_name = multi.getFilesystemName(file);
		String ori_file_name = multi.getOriginalFileName(file);
		
		String imagepath = saveDirectory + "\\" + ori_file_name;
		File image = new File(imagepath);
		ImageSizeChange.confirmImageSizeAndResize(image, 0, 0);
	}

	String ntType = multi.getParameter("ntType");
	String ntTitle = multi.getParameter("ntTitle");
	String ntContent = multi.getParameter("ntContent");
	
	sql = "INSERT INTO" + "\r\n" +
			"NOTICE(USER_NO, NT_NO, NT_TYPE, NT_TITLE, NT_CONTENT, NT_REGDATE, NT_DEL)" + "\r\n" +
			"VALUES(?, ?, ?, ?, ?, ?, ?)" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, 0);
	pstmt.setString(2, ntNo);
	pstmt.setString(3, ntType);
	pstmt.setString(4, ntTitle);
	pstmt.setString(5, ntContent);
	pstmt.setString(6, now);
	pstmt.setString(7, "N");
	
	//System.out.println(sql);
	
	pstmt.executeUpdate();
	
} catch(Exception e){
	System.out.println(e.getMessage());
}

if(pstmt != null){
	pstmt.close();	
}
if(conn != null){
	conn.close();	
}

%>