<?xml version="1.0" encoding="utf-8"?>
<%@page import="org.apache.commons.io.FileUtils"%>
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
* 팀 등록(create)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

int result = 0;
String msg = "";

String imagepath = "";

byte[] tturl = null;
%>


<%
	try{
		conn = dbconn.dbconnect();
		
		//업로드
		String folderName = "imagetest";
		String encType = "UTF-8";
		int size = 5*1024*1024; 
		
		//String saveDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\team\\";
		String saveDirectory = "D:\\heartpay\\workspace\\HeartPay\\web\\upload\\test\\";
		String path = saveDirectory + folderName;
		
		
		File dir = new File(path);
		
		if(!dir.exists()){
			dir.mkdirs();
		}

		/* String file1 = "";
		String originalName1 = "";
		String fileName1 = "";
		String fileType = "";
		int fileSize; */
		
		//다중 업로드 처리(중복 방지)
		MultipartRequest multi = new MultipartRequest(request, path, size, encType, new DefaultFileRenamePolicy());
		
		File file = multi.getFile("testFile");
		
		/* Enumeration files = multi.getFileNames();
		//System.out.println("############getFileNames:" + multi.getFileNames());
		while(files.hasMoreElements()){
			String file = (String) files.nextElement();
			String file_name = multi.getFilesystemName(file);
			String ori_file_name = multi.getOriginalFileName(file);
			
			imagepath = path + "\\" + ori_file_name;
			
			file1 = (String)files.nextElement();
			originalName1 = multi.getOriginalFileName(file1);
			fileName1 = multi.getFilesystemName(file1);
			fileType = multi.getContentType(file1);
			fileSize = file.length();
		} */
		
		byte[] buf = FileUtils.readFileToByteArray(file);
		
		sql = "INSERT INTO" + "\r\n" +
				"TEST_TABLE(TTURL)" + "\r\n" +
				"VALUES(?)";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setBytes(1, buf);
		
		result = pstmt.executeUpdate();
		
		if(result > 0){
			System.out.println(tturl);
		}

	}catch(Exception e){
		result = 0;
		msg = "팀 신청에 실패하였습니다. 잠시후 다시 시도해주세요.\n해당 현상이 지속되면 1:1문의에 문의 부탁드리겠습니다.";
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<TTURL><%=tturl%></TTURL>
		</DATA>
	</ROOT> 
<%
try {
	pstmt.close();
} catch (Exception ex) {}
try {
	conn.close();
} catch (Exception ex) {}
%>