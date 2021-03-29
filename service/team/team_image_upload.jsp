<?xml version="1.0" encoding="utf-8"?>
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
* 메뉴 등록(insert)
*******************************************/

boolean result = false;
String msg = "";
String team_no = ParamUtil.getString(request, "team_no", "0");
%>
<%
	try{
		
		//업로드
		String folderName = "team" + team_no;
		String encType = "UTF-8";
		int size = 100*1024*1024; 
		
		String saveDirectory = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.0\\happybusking\\ROOT\\upload\\team\\";
		String path = saveDirectory + folderName;
		
		
		File dir = new File(path);
		
		if(!dir.exists()){
			dir.mkdirs();
		}

		//다중 업로드 처리(중복 방지)
		MultipartRequest multi = new MultipartRequest(request, path, size, encType, new DefaultFileRenamePolicy());
		
		Enumeration files = multi.getFileNames();
		//System.out.println("############getFileNames:" + multi.getFileNames());
		while(files.hasMoreElements()){
			String file = (String) files.nextElement();
			String file_name = multi.getFilesystemName(file);
			String ori_file_name = multi.getOriginalFileName(file);
			
			String imagepath = path + "\\" + ori_file_name;
			File image = new File(imagepath);
			ImageSizeChange.confirmImageSizeAndResize(image, 0, 0);
		}

	}catch(Exception e){
		e.printStackTrace();
	}
%>
<%
%>