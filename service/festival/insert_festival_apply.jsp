<?xml version="1.0" encoding="utf-8"?>
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
* 공연 신청서 접수
*******************************************/
String sql = "";
Connection conn = null;
PreparedStatement pstmt = null;

boolean result = false;
String msg = "";

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();
String tno1 = tnoSdf.format(nowdate);

//랜덤함수
int randNum = ((int)(Math.random()*9999)+1);
String tno2 = String.format("%04d", randNum);

String kid = tno1 + tno2;

//현재 날짜
SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String now = sdf2.format(nowdate);


String area = ParamUtil.getString(request, "area", "");
String name = ParamUtil.getString(request, "name", "");
String birth = ParamUtil.getString(request, "birth", "");
String postcode = ParamUtil.getString(request, "postcode", "");
String address = ParamUtil.getString(request, "address", "");
String detailaddr = ParamUtil.getString(request, "detailaddr", "");
String email = ParamUtil.getString(request, "email", "");
String tel = ParamUtil.getString(request, "tel", "");
String tno = ParamUtil.getString(request, "tno", "");
String tname = ParamUtil.getString(request, "tname", "");
String tgenre = ParamUtil.getString(request, "tgenre", "");
String ttype = ParamUtil.getString(request, "ttype", "");
String tinfo = ParamUtil.getString(request, "tinfo", "");
String turl = ParamUtil.getString(request, "turl", "");
String countmin = ParamUtil.getString(request, "countmin", "0");
String countmax = ParamUtil.getString(request, "countmax", "0");

%>


<%
	try{
		conn = dbconn.dbconnect();
		
		sql = "INSERT INTO" + "\r\n" +  
				"FESTIVAL_APPLY(KID, KUSERCHK, KNAME, KBIRTH, KPOSTCODE, KADDR, KDETAILADDR, KEMAIL, KTEL, KTEAM, KGENRE, KTYPE, KINFO, KURL, KDATE, KGUBUN, KCOUNTMIN, KCOUNTMAX, KTEAMNO)" + "\r\n" + 
				"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)" + "\r\n";  
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, kid);
		pstmt.setString(2, "O");
		pstmt.setString(3, name);
		pstmt.setString(4, birth);
		pstmt.setString(5, postcode);
		pstmt.setString(6, address);
		pstmt.setString(7, detailaddr);
		pstmt.setString(8, email);
		pstmt.setString(9, tel);
		pstmt.setString(10, tname);
		pstmt.setString(11, tgenre);
		pstmt.setString(12, ttype);
		pstmt.setString(13, tinfo);
		pstmt.setString(14, turl);
		pstmt.setString(15, now);
		pstmt.setString(16, area);
		pstmt.setInt(17, Integer.parseInt(countmin));
		pstmt.setInt(18, Integer.parseInt(countmax));
		pstmt.setString(19, tno);
		
		int res = pstmt.executeUpdate();
		
		if(res > 0){
			result = true;
		} else {
			result = false;
		}
		
	}catch(Exception e){
		result = false;
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
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