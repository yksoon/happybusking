<?xml version="1.0" encoding="utf-8"?>
<%@page import="db.dbconn"%>
<%@page import="src.util.ConvertUtil"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<ROOT>
	<%
	

	request.setCharacterEncoding("utf-8");
	
	String seq = request.getParameter("seq");

	Connection conn = dbconn.dbconnect();
	
	String sql = "SELECT * FROM epilogue e INNER JOIN perform p ON e.PF_NO = p.PF_NO INNER JOIN team t ON t.TEAM_NO = e.TEAM_NO INNER JOIN user u ON u.USER_NO = e.USER_NO WHERE e.EPILOGUE_NO = " + seq;
	
	PreparedStatement pstat = conn.prepareStatement(sql);
	
	ResultSet rs = pstat.executeQuery();
	
	if (rs.next()) {
		
		
	%>
	<DATA>
		<USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>	
		<USER_ID><%=ConvertUtil.toString(rs.getString("USER_ID"))%></USER_ID>
		<NICKNAME><%=ConvertUtil.toString(rs.getString("NICKNAME"))%></NICKNAME>
		<RATY_STAR><%=ConvertUtil.toString(rs.getString("RATY_STAR"))%></RATY_STAR>
		<EPILOGUE_TITLE><%=ConvertUtil.toString(rs.getString("EPILOGUE_TITLE"))%></EPILOGUE_TITLE>
		<EPILOGUE_CONTENT><%=ConvertUtil.toString(rs.getString("EPILOGUE_CONTENT"))%></EPILOGUE_CONTENT>
		<EPILOGUE_DATE><%=ConvertUtil.toString(rs.getString("EPILOGUE_DATE"))%></EPILOGUE_DATE>
		<EPILOGUE_IMG><%=ConvertUtil.toString(rs.getString("EPILOGUE_IMG"))%></EPILOGUE_IMG>
		<EPILOGUE_VIDEO><%=ConvertUtil.toString(rs.getString("EPILOGUE_VIDEO"))%></EPILOGUE_VIDEO>
		<PF_PLACE><%=ConvertUtil.toString(rs.getString("PF_PLACE")) %></PF_PLACE>
		<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
	</DATA>	
	<%				
	}
	conn.close();
	%>
	
</ROOT>