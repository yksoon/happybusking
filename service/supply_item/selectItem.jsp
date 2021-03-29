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
* 선택한 지원물품
*******************************************/
int itme_no = 0;
String item_img = "";
String item_name = "";
int item_count = 0;

String temp = "";

String msg = "";

String item_no = ParamUtil.getString(request, "item_no", "");
//System.out.println("물품번호!!!!!! : " + item_no);


%>

<ROOT>
<%
	try{
		List item_list = new ArrayList<>();
		item_list = GetSupplyItem.selectSupplyItem(Integer.parseInt(item_no));
		
		for(int i=0; i<item_list.size(); i++){
			//System.out.println(item_list.size());
			temp = String.valueOf(item_list.get(i));
			//System.out.println(temp);
			String[] array = temp.split("@");
			
			itme_no = Integer.valueOf(array[0]);
			item_img = String.valueOf(array[1]);
			item_name = String.valueOf(array[2]);
			item_count = Integer.valueOf(array[3]);
			if(item_count != 0){
				msg = "S";//재고 있음
			%>
				<DATA>
					<ITEM_NO><%=itme_no%></ITEM_NO>
					<ITEM_IMG><%=item_img%></ITEM_IMG>
					<ITEM_NAME><%=item_name%></ITEM_NAME>
					<ITEM_COUNT><%=item_count%></ITEM_COUNT>	
					<ITEM_COUNT><%=item_count%></ITEM_COUNT>
					<MESSAGE><%=msg%></MESSAGE>
				</DATA>	
			
	<% 	
			}else{
				msg = "F";//재고 없음
				%>
				<DATA>
					<ITEM_NO><%=itme_no%></ITEM_NO>
					<ITEM_IMG><%=item_img%></ITEM_IMG>
					<ITEM_NAME><%=item_name%></ITEM_NAME>
					<ITEM_COUNT><%=item_count%></ITEM_COUNT>	
					<ITEM_COUNT><%=item_count%></ITEM_COUNT>
					<MESSAGE><%=msg%></MESSAGE>
				</DATA>	
			
			<% 					
			}
		}
		
		
		
				
		
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>

