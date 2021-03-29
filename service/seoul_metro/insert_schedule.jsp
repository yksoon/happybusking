<?xml version="1.0" encoding="utf-8"?>
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
* 공연 일정 신청(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;
Statement pstmt2 = null;
ResultSet rs = null;


//현재 날짜 구해서 팀번호 생성
SimpleDateFormat Sdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
String no1 = Sdf.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
String no2 = String.format("%04d", randNum);

String no = no1 + no2;

String tno = ParamUtil.getString(request, "tno", "");
String pno = ParamUtil.getString(request, "pno", "");
String date = ParamUtil.getString(request, "date", "");
String stime = ParamUtil.getString(request, "stime", "");
String etime = ParamUtil.getString(request, "etime", "");


int result;

conn = dbconn.dbconnect();

try{
	sql = "insert into" + "\r\n" +
			"schedule_application(no, tno, pno, organizer, date, stime, etime)" + "\r\n" +
			"values(?, ?, ?, ?, ? ,?, ?)" + "\r\n";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, no);
	pstmt.setString(2, tno);
	pstmt.setString(3, pno);
	pstmt.setString(4, "서울메트로");		//추후 다른 주관사 생기는 경우 파라미터 받아야함		
	pstmt.setString(5, date);
	pstmt.setString(6, stime);
	pstmt.setString(7, etime);
	
	result = pstmt.executeUpdate();
	//System.out.println(result);
	
	if(result > 0) {
		pstmt.close();
		//메트로 공연 신청 성공하면 공연일정에 바로 등록
		String sql2 = "select t.main_genre, t.code_genre, t.team_intro, t.tintro_img, pp.name, pp.address, pp.detail_address, pp.latlng, pp.area" + "\r\n" +
						"from team t" + "\r\n" +
						"join perform_place pp on pp.no = '"+pno+"'" + "\r\n" +
						"where t.team_no = '"+tno+"'" + "\r\n";
		//System.out.println(sql2);
		
		pstmt2 = conn.createStatement();
		rs = pstmt2.executeQuery(sql2);
		
		if(rs.next()){
			String codegenre = ConvertUtil.toStr(rs.getString("code_genre"));
			String maingenre = ConvertUtil.toStr(rs.getString("main_genre"));
			String intro = ConvertUtil.toStr(rs.getString("team_intro"));
			String image = ConvertUtil.toStr(rs.getString("tintro_img"));
			String pname = ConvertUtil.toStr(rs.getString("name"));
			String paddr = ConvertUtil.toStr(rs.getString("address"));
			String paddrdetail = ConvertUtil.toStr(rs.getString("detail_address"));
			String platlng = ConvertUtil.toStr(rs.getString("latlng"));
			String area = ConvertUtil.toStr(rs.getString("area"));
			
			String x = platlng.split(",")[0];
			String y = platlng.split(",")[1];
			
			date = date.substring(0,4) + "-" + date.substring(4,6) + "-" + date.substring(6,8);
			
			sql = "insert into" + "\r\n" +
					"perform(pf_no, team_no, pf_img, pf_intro, pf_intro_img, pf_date, pf_time, pf_etime, code_genre, main_genre, code_area, pf_place, pf_latlng, pf_place_type, pf_detail_content, pf_addr, pf_traffic, pf_edate)" + "\r\n" +
					"values(?, ?, ?, ? ,?, ? ,? ,? ,? ,? ,?, ? ,? ,? ,? ,? ,?, ?)" + "\r\n";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, no);
			pstmt.setString(2, tno);
			pstmt.setString(3, image);
			pstmt.setString(4, pname+" 공연");
			pstmt.setString(5, image);
			pstmt.setString(6, date);
			pstmt.setString(7, stime);
			pstmt.setString(8, etime);
			pstmt.setString(9, codegenre);
			pstmt.setString(10, maingenre);
			pstmt.setString(11, area);
			pstmt.setString(12, pname);
			pstmt.setString(13, y+","+x);
			pstmt.setString(14, paddrdetail);
			pstmt.setString(15, intro);
			pstmt.setString(16, paddr);
			pstmt.setString(17, "-");
			pstmt.setString(18, date);
			
			result = pstmt.executeUpdate();
			
			//System.out.println(result);
		}
	}
	
	%>
	<ROOT>
		<DATA>
			<RES><%=result %></RES>
		</DATA>
	</ROOT>
	<%
	
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