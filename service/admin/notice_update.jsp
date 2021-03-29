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
	String ntNo = multi.getParameter("ntNo");
	
	sql = "UPDATE NOTICE" + "\r\n" +
			"SET NT_TYPE = ?, NT_TITLE = ?, NT_CONTENT = ?" + "\r\n" +
			"WHERE NT_NO = ?" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, ntType);
	pstmt.setString(2, ntTitle);
	pstmt.setString(3, ntContent);
	pstmt.setString(4, ntNo);
	
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