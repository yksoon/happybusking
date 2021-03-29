<?xml version="1.0" encoding="utf-8"?>
<%@page import="com.daou.auth.bank.DaouBankAPI"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="utf-8" %>
<%@ page import="java.sql.*,java.io.*,java.util.*,java.net.*" %>
<%@ page import="com.daou.auth.common.*, com.daou.util.*, com.daou.util.File.*" %>

<%@ page language="java"%>
<%@ page import="java.text.*"%>
<%@ page import="file.*"%>
<%@ page import="src.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="file.log.VLog"%>
<%@ page import="db.*"%>
<%@ page import="java.sql.*"%>

<%@ page import="src.util.*"%>

<%@include file="/service_include.jsp" %>
    
<%
	String PubS_BANKIP = "123.140.121.205";	
	int PubI_BANKPORT = 46001;

	String PubS_LOGDIR = "C:\\logs\\";
	String PubS_KEY = "b7802330"; //암호화키 8자리
%>

<%
	PayStruct struct = new PayStruct();
	DaouBankAPI payBank = new DaouBankAPI(PubS_BANKIP,PubI_BANKPORT); 
	
	 String CPID        = CommonUtil.checkNull(request.getParameter("CPID"));        
	 String DAOUTRX  	= CommonUtil.checkNull(request.getParameter("DAOUTRX"));                                           
	 String AMOUNT   	= CommonUtil.checkNull(request.getParameter("AMOUNT")); 
	 String CANCELIP    = CommonUtil.checkNull(request.getParameter("CANCELIP")); 
	 String CANCELMEMO  = CommonUtil.checkNull(request.getParameter("CANCELMEMO")); 
	 
	struct.PubSet_Key		 = PubS_KEY; 
	struct.PubSet_CPID		 = CPID;
	struct.PubSet_DaouTrx	 = DAOUTRX;
	struct.PubSet_Amount	 = AMOUNT;	
	struct.PubSet_IPAddress	 = CANCELIP;	
	struct.PubSet_CancelMemo = CANCELMEMO;
	
	struct = payBank.BankCancel(struct, PubS_LOGDIR+"/"+CPID);	

	if (struct.PubGet_ResultCode.equals("0000")){
		
	//현재 날짜
	Date nowdate = new Date();
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String now = sdf2.format(nowdate);
	
	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	int res;
	
	try{
		conn = dbconn.dbconnect();
		
		sql = "UPDATE KIWOOMPAY_RESULT" + "\r\n" +
				"SET CANCEL = 'Y'" + "\r\n" +
				"WHERE DAOUTRX = ?";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, DAOUTRX);
		
		res = pstmt.executeUpdate();
		
		pstmt.close();
		
		sql = "UPDATE QR_REQUEST" + "\r\n" +
				"SET QR_REQUEST_STATE = 'C', QR_PAYMENT_CANCEL_MSG = ?, QR_PAYMENT_CANCEL_DATE = ?" + "\r\n" +
				"WHERE QR_PAYMENT_TID = ?";
		
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, CANCELMEMO);
		pstmt.setString(2, now);
		pstmt.setString(3, DAOUTRX);
		
		res = pstmt.executeUpdate();
	} catch(Exception e){
		System.out.println(e.getMessage());
		%>
			<script language="javascript">
				alert("취소되지 않았습니다.\n해당 메시지가 계속 발생하면 해피버스킹에 문의해주세요.");
				history.go(-1);
			</script>
		<%
	}
	
	
	try{
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	} catch (Exception e){
		System.out.println(e.getMessage());
	}
%>
		<script language="javascript">
			alert("취소되었습니다.");
			history.go(-1);
		</script>
<%
	}else{
%>
		<script language="javascript">
			alert("취소되지 않았습니다.\n해당 메시지가 계속 발생하면 해피버스킹에 문의해주세요.");
			history.go(-1);
		</script>
<% 	
	}
%>