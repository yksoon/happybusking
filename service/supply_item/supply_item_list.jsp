<?xml version="1.0" encoding="utf-8"?>
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
* 지원물품 조회
*******************************************/
int itme_no = 0;
String item_img = "";
String item_name = "";
int item_count = 0;

String temp = "";
%>

<ROOT>
<%
	try{
		List item_list = new ArrayList<>();
		item_list = GetSupplyItem.getSupplyItem();
		
		for(int i=0; i<item_list.size(); i++){
			//System.out.println(item_list.size());
			temp = String.valueOf(item_list.get(i));
			//System.out.println(temp);
			String[] array = temp.split("@");
			
			itme_no = Integer.valueOf(array[0]);
			item_img = String.valueOf(array[1]);
			item_name = String.valueOf(array[2]);
			item_count = Integer.valueOf(array[3]);
			%>
				<DATA>
					<ITEM_NO><%=itme_no%></ITEM_NO>
					<ITEM_IMG><%=item_img%></ITEM_IMG>
					<ITEM_NAME><%=item_name%></ITEM_NAME>
					<ITEM_COUNT><%=item_count%></ITEM_COUNT>	
				</DATA>	
			
	<% 	
		}
		
		
		
				
		
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>

