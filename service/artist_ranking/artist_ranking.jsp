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
* 인기 아티스트 목록 가져오기
*******************************************/
String sql = "";
String sql_content = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//세션 Parameter
String code_area = ParamUtil.getString(request, "code_area", "");
String code_genre= ParamUtil.getString(request, "code_genre", "");
String team_search = ParamUtil.getString(request, "team_search", "");
String a_count = ParamUtil.getString(request, "a_count", "0");
String index_chk = ParamUtil.getString(request, "index_chk", "0");
String endCount = ParamUtil.getString(request, "endCount", "20");
String sort = ParamUtil.getString(request, "sort", "");

//System.out.println(a_count);
%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		if(endCount.equals("0")){
			endCount = "20";
		}
		
		String where = "and t.team_name like '%"+team_search+"%'" + "\r\n";
		
		if(!code_area.equals("")) where = where.concat("and t.code_area like '%"+code_area+"%'\r\n");
		if(!code_genre.equals("")) where = where.concat("and t.main_genre like '%"+code_genre+"%'\r\n");
		
		if(sort.equals("")){
			//전체(활동순), 지역, 장르
			//추후에 순위에 게시글 작성한사람 빼달라고하면 아래 주석처리된 코드로 바꾸면됨.
			/* sql = "select distinct *," + "\r\n" +
					"(select count(*) from team where team_name <> '해피버스킹') as all_cnt," + "\r\n" +
					"(select pf_date from perform where team_no = D.team_no and pf_date >= now() and pf_cancle = '"+USER_NO+"') as pf_date," + "\r\n" +
					"(select count(*) from interest where team_no = D.team_no and user_no = '"+USER_NO+"') as i_cnt" + "\r\n" +
					"from(select *" + "\r\n" + 
							"from (select t.*," + "\r\n" +
							"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
							"from team t" + "\r\n" +
							"join perform p on p.team_no = t.team_no and p.pf_cancle = '0' and p.pf_date >= date_add(now(), interval -2 month)" + "\r\n" +
							"where t.team_name <> '해피버스킹'" + "\r\n" +
							where +
							"group by p.team_no" + "\r\n" +
							"order by p.regdate desc" + "\r\n" +
							"limit 5) as A" + "\r\n" +
							"union" + "\r\n" +
							"select *" + "\r\n" +
							"from (select t.*," + "\r\n" +
							"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
							"from team t" + "\r\n" +
							"where t.team_name <> '해피버스킹'" + "\r\n" +
							where +
							"order by cnt desc limit 100000) as C) as D" + "\r\n" +
							"LIMIT "+a_count+", "+endCount + "\r\n"; */
			
			sql = "select distinct *," + "\r\n" +
					"(select count(*) from team where team_name <> '해피버스킹') as all_cnt," + "\r\n" +
					"(select pf_date from perform where team_no = D.team_no and pf_date >= now() and pf_cancle = '0' limit 1) as pf_date," + "\r\n" +
					"(select count(*) from interest where team_no = D.team_no and user_no = '"+USER_NO+"') as i_cnt" + "\r\n" +
					"from(select *" + "\r\n" + 
							"from (select t.*," + "\r\n" +
							"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
							"from team t" + "\r\n" +
							"join perform p on p.team_no = t.team_no and p.pf_cancle = '0' and p.pf_date >= date_add(now(), interval -2 month)" + "\r\n" +
							"where t.team_name <> '해피버스킹'" + "\r\n" +
							where +
							"group by p.team_no" + "\r\n" +
							"order by p.regdate desc" + "\r\n" +
							"limit 5) as A" + "\r\n" +
							"union" + "\r\n" +
							"select *" + "\r\n" +
							"from (select t.*," + "\r\n" +
							"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
							"from team t" + "\r\n" +
							"join team_member tm on tm.team_no = t.team_no and tm.leader_chk = '1'" + "\r\n" +
							"join board b on b.user_no = tm.user_no  and b.board_date >= date_add(now(), interval -2 week) and board_del = 'N'" + "\r\n" +
							"where t.team_name <> '해피버스킹'" + "\r\n" +
							where +
							"group by t.team_no" + "\r\n" +
							"order by b.board_date desc" + "\r\n" +
							"limit 5) as B" + "\r\n" +
							"union" + "\r\n" +
							"select *" + "\r\n" +
							"from (select t.*," + "\r\n" +
							"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
							"from team t" + "\r\n" +
							"where t.team_name <> '해피버스킹'" + "\r\n" +
							where +
							"order by cnt desc limit 100000) as C) as D" + "\r\n" +
							"LIMIT "+a_count+", "+endCount + "\r\n";
		} else if(sort.equals("like")){
			//좋아요순
			sql = "select t.*," + "\r\n" +
					"(select count(*) from team where team_name <> '해피버스킹') as all_cnt," + "\r\n" +
					"(select pf_date from perform where team_no = t.team_no and pf_date >= now() and pf_cancle = '0' limit 1) as pf_date," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no and user_no = '"+USER_NO+"') as i_cnt," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
					"from team t" + "\r\n" +
					"where t.team_name <> '해피버스킹'" + "\r\n" +
					"order by cnt desc" + "\r\n" +
					"LIMIT "+a_count+", "+endCount + "\r\n";
		} else if(sort.equals("old")){
			//가입순
			sql = "select t.*," + "\r\n" +
					"(select count(*) from team where team_name <> '해피버스킹') as all_cnt," + "\r\n" +
					"(select pf_date from perform where team_no = t.team_no and pf_date >= now() and pf_cancle = '0' limit 1) as pf_date," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no and user_no = '"+USER_NO+"') as i_cnt," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
					"from team t" + "\r\n" +
					"where t.team_name <> '해피버스킹'" + "\r\n" +
					"order by regdate asc, tid asc" + "\r\n" +
					"LIMIT "+a_count+", "+endCount + "\r\n";
		} else {
			//최신순
			sql = "select t.*," + "\r\n" +
					"(select count(*) from team where team_name <> '해피버스킹') as all_cnt," + "\r\n" +
					"(select pf_date from perform where team_no = t.team_no and pf_date >= now() and pf_cancle = '0' limit 1) as pf_date," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no and user_no = '"+USER_NO+"') as i_cnt," + "\r\n" +
					"(select count(*) from interest where team_no = t.team_no) as cnt" + "\r\n" +
					"from team t" + "\r\n" +
					"where t.team_name <> '해피버스킹'" + "\r\n" +
					"order by regdate desc, cnt desc" + "\r\n" +
					"LIMIT "+a_count+", "+endCount + "\r\n";
		}
		
		
		//System.out.println(sql);
		
		rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			%>
				<DATA>
					<TEAM_NO><%=ConvertUtil.toStr(rs.getString("TEAM_NO"))%></TEAM_NO>
					<TEAM_NAME><%=ConvertUtil.toString(rs.getString("TEAM_NAME"))%></TEAM_NAME>
					<CODE_GENRE><%=ConvertUtil.toString(rs.getString("CODE_GENRE"))%></CODE_GENRE>
					<I_CNT><%=ConvertUtil.toString(rs.getString("I_CNT"))%></I_CNT>
					<TINTRO_IMG><%=ConvertUtil.toString(rs.getString("TINTRO_IMG"))%></TINTRO_IMG>
					<PF_DATE><%=ConvertUtil.toString(rs.getString("PF_DATE"))%></PF_DATE>
					<BELONG><%=ConvertUtil.toString(rs.getString("BELONG"))%></BELONG>
					<ALL_CNT><%=ConvertUtil.toString(rs.getString("ALL_CNT"))%></ALL_CNT>
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