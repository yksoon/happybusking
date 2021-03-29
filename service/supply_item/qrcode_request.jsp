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
* QR신청쪽 팀 정보 가져오기
*******************************************/
String team_name = "";
String team_no = "";

String temp2 = "";
%>

<ROOT>
<%
	try{

		
		List team_list = new ArrayList<>();
		team_list = GetTeamSelect.getMyTeam(USER_NO);
		
		for(int i=0; i<team_list.size(); i++){
			//System.out.println(team_list.size());
			temp2 = String.valueOf(team_list.get(i));
			//System.out.println(temp2);
			String[] array = temp2.split("@");
			
			team_no = String.valueOf(array[0]);
			team_name = String.valueOf(array[1]);

			
			/* if(item_count != 0){ */
			%>
				<DATA>
					<TEAM_NO><%=team_no%></TEAM_NO>
					<TEAM_NAME><%=team_name%></TEAM_NAME>
				</DATA>	
			
	<% 	
			//}
		}	
		
				
		
	%>
	</ROOT>	
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>

