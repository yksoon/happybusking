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
* 공공 버스킹 정보 게시글 등록(INSERT)
*******************************************/
String sql = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//현재 날짜 구해서 팀번호 생성
SimpleDateFormat tnoSdf = new SimpleDateFormat("yyMMddkkmmss");
Date nowdate = new Date();

//랜덤함수
int randNum = ((int)(Math.random()*9998)+1);
String no = tnoSdf.format(nowdate) + String.format("%04d", randNum);

String user_no = USER_NO;
String pbiThumnailImg = ParamUtil.getString(request, "pbiThumnailImg", "");
String pbiMainImg = ParamUtil.getString(request, "pbiMainImg", "");
String pbiTitle = ParamUtil.getString(request, "pbiTitle", "");
String pbiEventSdate = ParamUtil.getString(request, "pbiEventSdate", "");
String pbiEventEdate = ParamUtil.getString(request, "pbiEventEdate", "");
String pbiReceiptSdate = ParamUtil.getString(request, "pbiReceiptSdate", "");
String pbiReceiptEdate = ParamUtil.getString(request, "pbiReceiptEdate", "");
String pbiGenre = ParamUtil.getString(request, "pbiGenre", "");
String pbiGenreCode = ParamUtil.getString(request, "pbiGenreCode", "");
String pbiPersonner = ParamUtil.getString(request, "pbiPersonner", "");
String pbiPersonner_min = ParamUtil.getString(request, "pbiPersonner_min", "");
String pbiPay = ParamUtil.getString(request, "pbiPay", "");
String pbiPayMax = ParamUtil.getString(request, "pbiPayMax", "");
String pbiAddress = ParamUtil.getString(request, "pbiAddress", "");
String pbiDetailaddress = ParamUtil.getString(request, "pbiDetailaddress", "");
String pbiLatlng = ParamUtil.getString(request, "pbiLatlng", "");
String pbiContent = ParamUtil.getString(request, "pbiContent", "");
String pbiManager = ParamUtil.getString(request, "pbiManager", "");
String pbiTel = ParamUtil.getString(request, "pbiTel", "");
String pbiEmail = ParamUtil.getString(request, "pbiEmail", "");
String pbiNoPay = ParamUtil.getString(request, "pbiNoPay", "");
String pbiTransportation = ParamUtil.getString(request, "pbiTransportation", "");
String hallImg = ParamUtil.getString(request, "hallImg", "");
String productImg = ParamUtil.getString(request, "productImg", "");

%>


<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
		//System.out.println(user_no);
		/* System.out.println(pbiPersonner);
		System.out.println(pbiPersonner_min); */
		
		
		sql = "INSERT INTO" + "\r\n" +
				"PUBLIC_BUSKING_INFO(PBI_NO, PBI_USER_NO, PBI_THUMNAIL_IMG, PBI_MAIN_IMG, PBI_TITLE, PBI_EVENT_SDATE," + "\r\n" + 
						"PBI_EVENT_EDATE, PBI_RECEIPT_SDATE, PBI_RECEIPT_EDATE, PBI_GENRE, PBI_PAY, PBI_PAY_MAX, PBI_PERSONNEL, PBI_PERSONNEL_MIN, PBI_ADDRESS, PBI_DETAILADDRESS, PBI_LATLNG, PBI_CONTENT ,PBI_SITE, PBI_MANAGER, PBI_TEL, PBI_EMAIL, PBI_FILE, PBI_NO_PAY, PBI_TRANSPORTATION, PBI_PLACE_IMG, PBI_PRODUCT_IMG, PBI_GENRE_CODE)" + "\r\n" +
				"VALUES('{no}', '{pbiUserNo}', '{pbiThumnailImg}','{pbiMainImg}','{pbiTitle}', '{pbiEventSdate}'," + "\r\n" + 
						"'{pbiEventEdate}', '{pbiReceiptSdate}', '{pbiReceiptEdate}', '{pbiGenre}', '{pbiPay}', '{pbiPayMax}', '{pbiPersonner}', '{pbiPersonner_min}', '{pbiAddress}', '{pbiDetailaddress}', '{pbiLatlng}', '{pbiContent}', '{pbiSite}' , '{pbiManager}' , '{pbiTel}' , '{pbiEmail}' , '{pbiFile}' , '{pbiNoPay}' , '{pbiTransportation}' , '{hallImg}' , '{productImg}', '{pbiGenreCode}')";
		
		sql = sql.replace("{no}", no);
		sql = sql.replace("{pbiUserNo}", USER_NO);
		sql = sql.replace("{pbiThumnailImg}", pbiThumnailImg);
		sql = sql.replace("{pbiMainImg}", pbiMainImg);
		sql = sql.replace("{pbiTitle}", pbiTitle);
		sql = sql.replace("{pbiEventSdate}", pbiEventSdate);
		sql = sql.replace("{pbiEventEdate}", pbiEventEdate);
		sql = sql.replace("{pbiReceiptSdate}", pbiReceiptSdate);
		sql = sql.replace("{pbiReceiptEdate}", pbiReceiptEdate);
		sql = sql.replace("{pbiGenre}", pbiGenre);
		sql = sql.replace("{pbiPay}", pbiPay);
		sql = sql.replace("{pbiPayMax}", pbiPayMax);
		sql = sql.replace("{pbiPersonner}", pbiPersonner);
		sql = sql.replace("{pbiPersonner_min}", pbiPersonner_min);
		sql = sql.replace("{pbiAddress}", pbiAddress);
		sql = sql.replace("{pbiDetailaddress}", pbiDetailaddress);
		sql = sql.replace("{pbiLatlng}", pbiLatlng);
		sql = sql.replace("{pbiContent}", pbiContent);
		sql = sql.replace("{pbiSite}", "");
		sql = sql.replace("{pbiManager}", pbiManager);
		sql = sql.replace("{pbiTel}", pbiTel);
		sql = sql.replace("{pbiEmail}", pbiEmail);
		sql = sql.replace("{pbiFile}", "");
		sql = sql.replace("{pbiNoPay}", pbiNoPay);
		sql = sql.replace("{pbiTransportation}", pbiTransportation);
		sql = sql.replace("{hallImg}", hallImg);
		sql = sql.replace("{productImg}", productImg);
		sql = sql.replace("{pbiGenreCode}", pbiGenreCode);
		
		//System.out.println(sql);
		
		pstmt.executeUpdate(sql);
		
		result = true;
		msg = "등록되었습니다.";
		
		/* if(result){
			pbiGenre = pbiGenre.replaceAll(",", "|");
			String pbiArea = pbiAddress.replaceAll(" ", "|");
			String token="", aname="";
			String body="";
			
			if(pbiPersonner.equals("제한없음")) pbiPersonner = "0";
			if(pbiPersonner_min.equals("제한없음")) pbiPersonner_min = "0";
			
			sql = "select u.fcm_token, a.artist_name" + "\r\n" +
					"from busking_condition" + "\r\n" +
					"join user u on u.user_no = uno" + "\r\n" +
					"join artist a on a.user_no = uno" + "\r\n" +
					"where (genre='전체' or genre regexp('"+pbiGenre+"'))" + "\r\n" +
					"and (area='' or area regexp('"+pbiArea+"'))" + "\r\n" +
					"and (pay=0 or pay <= "+pbiPay+")" + "\r\n" +
					"and (personnel_max='' or personnel_max <= "+pbiPersonner+")" + "\r\n" +
					"and (personnel_min='' or personnel_min >= "+pbiPersonner_min+")" + "\r\n" +
					"and (apply_sdate = '' or" + "\r\n" +
					"(apply_sdate between date_format('"+pbiReceiptSdate+"', '%Y-%m-%d') and date_format('"+pbiReceiptEdate+"', '%Y-%m-%d'))" + "\r\n" +
					"or (apply_edate between date_format('"+pbiReceiptSdate+"', '%Y-%m-%d') and date_format('"+pbiReceiptEdate+"', '%Y-%m-%d')))" + "\r\n" +
					"and (perform_sdate = '' or" + "\r\n" +
					"(perform_sdate between date_format('"+pbiEventSdate+"', '%Y-%m-%d') and date_format('"+pbiEventSdate+"', '%Y-%m-%d'))" + "\r\n" +
					"or (perform_edate between date_format('"+pbiEventSdate+"', '%Y-%m-%d') and date_format('"+pbiEventSdate+"', '%Y-%m-%d'))" + "\r\n" +
					")" + "\r\n";
			
			//System.out.println(sql);
			
			rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				token = ConvertUtil.toStr(rs.getString("fcm_token"));
				aname = ConvertUtil.toStr(rs.getString("artist_name"));
				body = aname + "님이 설정하신 조건에 맞는 버스커 모집 공고가 등록되었습니다.";
				FirebaseMessagingService.pushFCMNotification(token, 
						"[맞춤 버스커 모집 공고 등록 알림]", body, "pbiapply", body, true);
			}
		} */

	}catch(Exception e){
		result = false;
		msg = "다시 시도해주세요.";
		e.printStackTrace();
	}
%>
 	<ROOT>
		<DATA>
			<RESULT><%=String.valueOf(result)%></RESULT>
			<MESSAGE><%=msg%></MESSAGE>
		</DATA>
	</ROOT> 
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