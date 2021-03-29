<?xml version="1.0" encoding="utf-8"?>
<%@page import="src.util.ParamUtil"%>
<%@page import="src.util.ConvertUtil"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<ROOT>
	<%
	

	request.setCharacterEncoding("utf-8");
	
	String start = request.getParameter("start");
	String team_no = ParamUtil.getString(request, "team_no", "");
	String sort = request.getParameter("sort");
	
	Connection conn = dbconn.dbconnect();
	String orderby = "";
	
	if (sort.equals("0")) {
		orderby = "ORDER BY e.EPILOGUE_NO DESC";
	} else {
		orderby = "ORDER BY e.RATY_STAR DESC";
	}
	
	String sql = "SELECT * FROM epilogue e INNER JOIN perform p ON e.PF_NO = p.PF_NO INNER JOIN team t ON t.TEAM_NO = e.TEAM_NO INNER JOIN user u ON u.USER_NO = e.USER_NO WHERE e.TEAM_NO = ? AND e.EPILOGUE_DEL = 'N' " +  orderby + " LIMIT ?, 5";
	
	//System.out.println(sql);
	
	PreparedStatement pstat = conn.prepareStatement(sql);
	
	pstat.setString(1, team_no);
	pstat.setString(2, start);
	
	ResultSet rs = pstat.executeQuery();
	
	while (rs.next()) {
		String img = "";
		if (rs.getString("EPILOGUE_IMG") == null || rs.getString("EPILOGUE_IMG").equals("")) {
			img = "noimage.gif"; 
		} else {
			img = rs.getString("EPILOGUE_IMG");
		}
		
	%>
	<DATA>
		<TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO"))%></TEAM_NO>
		<USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO"))%></USER_NO>
		<USER_ID><%=ConvertUtil.toString(rs.getString("USER_ID"))%></USER_ID>
		<NICKNAME><%=ConvertUtil.toString(rs.getString("NICKNAME"))%></NICKNAME>
		<RATY_STAR><%=ConvertUtil.toString(rs.getString("RATY_STAR"))%></RATY_STAR>
		<EPILOGUE_NO><%=ConvertUtil.toString(rs.getString("EPILOGUE_NO")) %></EPILOGUE_NO>
		<EPILOGUE_TITLE><%=ConvertUtil.toString(rs.getString("EPILOGUE_TITLE"))%></EPILOGUE_TITLE>
		<EPILOGUE_CONTENT><%=ConvertUtil.toString(rs.getString("EPILOGUE_CONTENT"))%></EPILOGUE_CONTENT>
		<EPILOGUE_DATE><%=ConvertUtil.toString(rs.getString("EPILOGUE_DATE"))%></EPILOGUE_DATE>
		<EPILOGUE_IMG><%= img %></EPILOGUE_IMG>
		<CODE_AREA><%=ConvertUtil.toString(rs.getString("CODE_AREA")) %></CODE_AREA>
		<PF_INTRO><%=ConvertUtil.toString(rs.getString("PF_INTRO")) %></PF_INTRO>
	</DATA>	
	<%				
	}
	conn.close();
	 %>
	
</ROOT>