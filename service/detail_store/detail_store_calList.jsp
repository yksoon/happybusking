<?xml version="1.0" encoding="utf-8"?>
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
* 공연 신청/계약 이력
*******************************************/
String sql = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String store_user_no = ParamUtil.getString(request, "store_user_no", "");
String search_date = ParamUtil.getString(request, "search_date", "");
String buskingstatus_ck = ParamUtil.getString(request, "buskingstatus_ck", "");
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();

        if(buskingstatus_ck.equals("Y")){
			sql = "SELECT    perform_no," + "\r\n" +  
                            "buskingdate," + "\r\n" +  
                            "startingtime," + "\r\n" +  
                            "finishingtime," + "\r\n" +  
                            "dayoftheweek," + "\r\n" +   
                            "offerprice," + "\r\n" +     
                            "team_name," + "\r\n" +  
                            "team_no," + "\r\n" +   
                            "business_workname," + "\r\n" +   
                            "address," + "\r\n" +  
                            "hashtag," + "\r\n" +   
                            "user_no," + "\r\n" +   
                            "space_picture," + "\r\n" +  
                            "tintro_img," + "\r\n" +   
                            "group_concat(merge_column) as ARTIST_MATCHING," + "\r\n" +    
                    "CASE" + "\r\n" +   
                    "WHEN buskingdate < Date(Now())" + "\r\n" +  
                    "AND team_name = '' THEN '모집마감'" + "\r\n" +   
                    "WHEN buskingdate < Date(Now()) THEN '5'" + "\r\n" +    
                    "ELSE buskingstatus" + "\r\n" +     
                    "END AS buskingstatus" + "\r\n" +   
                    "FROM (" + "\r\n" +  
                         " SELECT    a.perform_no," + "\r\n" +  
									"a.buskingdate," + "\r\n" +  
									"a.startingtime," + "\r\n" +   
									"a.finishingtime," + "\r\n" +  
									"a.dayoftheweek," + "\r\n" +   
									"a.offerprice," + "\r\n" +     
									"a.team_name," + "\r\n" +  
									"a.team_no," + "\r\n" +   
									"b.business_workname," + "\r\n" +   
									"c.address," + "\r\n" +   
									"c.hashtag," + "\r\n" +   
									"a.user_no," + "\r\n" +   
									"c.space_picture," + "\r\n" +  
									"e.tintro_img," + "\r\n" +   
									"concat(f.user_no, '/', f.matching_chk) as merge_column," + "\r\n" +    
								    "a.buskingstatus" + "\r\n" +  
									"FROM   reg_buskingtime a" + "\r\n" +   
									"JOIN business b" + "\r\n" +  
									"ON a.user_no = b.user_no" + "\r\n" +   
									"JOIN store c" + "\r\n" +     
										"ON a.user_no = c.user_no" + "\r\n" +     
									"JOIN area_code d" + "\r\n" +    
										"ON d.area_name = Substring(c.address, 1, 2)" + "\r\n" +   
									"LEFT JOIN team e" + "\r\n" +   
										"ON a.team_no = e.team_no" + "\r\n" +   
									"LEFT JOIN reg_perform f" + "\r\n" +   
										"ON a.perform_no = f.perform_no" + "\r\n" +   
									"WHERE  a.user_no <> '해피버스킹'" + "\r\n" +  
			                        "AND a.buskingstatus = '3'" + "\r\n" +  
									"AND a.delete_chk='N'" + "\r\n" +     
			                        "AND a.buskingdate >= Date(Now())" + "\r\n" +  
									"AND a.user_no = '"+store_user_no+"'" + "\r\n" +     
									"AND a.buskingdate LIKE '%"+search_date+"%'" + "\r\n" +   
									"ORDER  BY a.buskingdate ASC) as T1 GROUP BY perform_no";
		}
        else{
            sql = "SELECT    perform_no," + "\r\n" +  
                            "buskingdate," + "\r\n" +  
                            "startingtime," + "\r\n" +  
                            "finishingtime," + "\r\n" +  
                            "dayoftheweek," + "\r\n" +   
                            "offerprice," + "\r\n" +     
                            "team_name," + "\r\n" +  
                            "team_no," + "\r\n" +   
                            "business_workname," + "\r\n" +   
                            "address," + "\r\n" +  
                            "hashtag," + "\r\n" +   
                            "user_no," + "\r\n" +   
                            "space_picture," + "\r\n" +  
                            "tintro_img," + "\r\n" +   
                            "group_concat(merge_column) as ARTIST_MATCHING," + "\r\n" +    
                    "CASE" + "\r\n" +   
                    "WHEN buskingdate < Date(Now())" + "\r\n" +  
                    "AND team_name = '' THEN '모집마감'" + "\r\n" +   
                    "WHEN buskingdate < Date(Now()) THEN '5'" + "\r\n" +    
                    "ELSE buskingstatus" + "\r\n" +     
                    "END AS buskingstatus" + "\r\n" +   
                    "FROM (" + "\r\n" +  
                         " SELECT    a.perform_no," + "\r\n" +  
									"a.buskingdate," + "\r\n" +  
									"a.startingtime," + "\r\n" +   
									"a.finishingtime," + "\r\n" +  
									"a.dayoftheweek," + "\r\n" +   
									"a.offerprice," + "\r\n" +     
									"a.team_name," + "\r\n" +  
									"a.team_no," + "\r\n" +   
									"b.business_workname," + "\r\n" +   
									"c.address," + "\r\n" +   
									"c.hashtag," + "\r\n" +   
									"a.user_no," + "\r\n" +   
									"c.space_picture," + "\r\n" +  
									"e.tintro_img," + "\r\n" +   
									"concat(f.user_no, '/', f.matching_chk) as merge_column," + "\r\n" +    
								    "a.buskingstatus" + "\r\n" +  
									"FROM   reg_buskingtime a" + "\r\n" +   
									"JOIN business b" + "\r\n" +  
									"ON a.user_no = b.user_no" + "\r\n" +   
									"JOIN store c" + "\r\n" +     
										"ON a.user_no = c.user_no" + "\r\n" +     
									"JOIN area_code d" + "\r\n" +    
										"ON d.area_name = Substring(c.address, 1, 2)" + "\r\n" +   
									"LEFT JOIN team e" + "\r\n" +   
										"ON a.team_no = e.team_no" + "\r\n" +   
									"LEFT JOIN reg_perform f" + "\r\n" +   
										"ON a.perform_no = f.perform_no" + "\r\n" +   
									"WHERE  a.user_no <> '해피버스킹'" + "\r\n" + 
									"AND a.delete_chk='N'" + "\r\n" +     
			                        "AND a.buskingdate >= Date(Now())" + "\r\n" +  
									"AND a.user_no = '"+store_user_no+"'" + "\r\n" +     
									"AND a.buskingdate LIKE '%"+search_date+"%'" + "\r\n" +   
									"ORDER  BY a.buskingdate ASC) as T1 GROUP BY perform_no";
            //sql = "SELECT    a.perform_no," + "\r\n" +  
						//"a.buskingdate, " + "\r\n" +  
						//"a.startingtime, " + "\r\n" +  
						//"a.finishingtime, " + "\r\n" +  
						//"a.dayoftheweek, " + "\r\n" +  
						//"a.offerprice, " + "\r\n" +  
						//"a.team_name, " + "\r\n" +  
						//"a.team_no, " + "\r\n" +  
						//"b.business_workname, " + "\r\n" +  
						//"c.address, " + "\r\n" +  
						//"c.hashtag, " + "\r\n" +  
						//"a.user_no, " + "\r\n" +  
						//"c.space_picture, " + "\r\n" +  
						//"e.tintro_img, " + "\r\n" +  
						//"f.matching_chk, " + "\r\n" +  
						//"CASE " + "\r\n" +  
							//"WHEN a.buskingdate < Date(Now()) " + "\r\n" +  
								//"AND a.team_name = '' THEN '모집마감' " + "\r\n" +  
							//"WHEN a.buskingdate < Date(Now()) THEN '5' " + "\r\n" +  
							//"ELSE a.buskingstatus " + "\r\n" +  
						//"END AS buskingstatus " + "\r\n" +  
						//"FROM   reg_buskingtime a " + "\r\n" +  
						//"JOIN business b " + "\r\n" +  
						//"	ON a.user_no = b.user_no " + "\r\n" +  
						//"JOIN store c " + "\r\n" +  
							//"ON a.user_no = c.user_no " + "\r\n" +  
						//"JOIN area_code d " + "\r\n" +  
							//"ON d.area_name = Substring(c.address, 1, 2) " + "\r\n" +  
						//"LEFT JOIN team e " + "\r\n" +  
								//"ON a.team_no = e.team_no " + "\r\n" +  
						//"LEFT JOIN reg_perform f " + "\r\n" +  
								//"ON a.perform_no = f.perform_no " + "\r\n" +  
						//"WHERE  a.user_no <> '해피버스킹' " + "\r\n" +
						//"AND a.delete_chk='N' " + "\r\n" +
                        //"AND a.buskingdate >= Date(Now())" + "\r\n" +
						//"AND a.user_no = '"+store_user_no+"' " + "\r\n" +  
						//"AND a.buskingdate LIKE '%"+search_date+"%' " + "\r\n" +  
						//"ORDER  BY a.buskingdate ASC";
        }
		
		
		
		rs = pstmt.executeQuery(sql);
		
		System.out.println(sql);
		
		while(rs.next()){
        %>
			<DATA>
				<PERFORM_NO><%=ConvertUtil.toString(rs.getString("PERFORM_NO"))%></PERFORM_NO>
				<BUSKINGDATE><%=ConvertUtil.toString(rs.getString("BUSKINGDATE")) %></BUSKINGDATE>
                <STARTINGTIME><%=ConvertUtil.toString(rs.getString("STARTINGTIME")) %></STARTINGTIME>
                <FINISHINGTIME><%=ConvertUtil.toString(rs.getString("FINISHINGTIME")) %></FINISHINGTIME>
                <DAYOFTHEWEEK><%=ConvertUtil.toString(rs.getString("DAYOFTHEWEEK")) %></DAYOFTHEWEEK>
                <OFFERPRICE><%=ConvertUtil.toString(rs.getInt("OFFERPRICE")) %></OFFERPRICE>
                <TEAM_NO><%=ConvertUtil.toString(rs.getString("TEAM_NO")) %></TEAM_NO>
                <TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME")) %></TEAM_NAME>
				<BUSINESS_WORKNAME><%=ConvertUtil.toString(rs.getString("BUSINESS_WORKNAME")) %></BUSINESS_WORKNAME>
				<ADDRESS><%=ConvertUtil.toString(rs.getString("ADDRESS")) %></ADDRESS>
				<HASHTAG><%=ConvertUtil.toString(rs.getString("HASHTAG")) %></HASHTAG>
				<USER_NO><%=ConvertUtil.toString(rs.getString("USER_NO")) %></USER_NO>
				<SPACE_PICTURE><%=ConvertUtil.toString(rs.getString("SPACE_PICTURE")) %></SPACE_PICTURE>
				<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG")) %></TINTRO_IMG>
				<BUSKINGSTATUS><%=ConvertUtil.toString(rs.getString("BUSKINGSTATUS")) %></BUSKINGSTATUS>
                <ARTIST_MATCHING><%=ConvertUtil.toString(rs.getString("ARTIST_MATCHING")) %></ARTIST_MATCHING>
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