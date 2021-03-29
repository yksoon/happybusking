<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="db.dbconn"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/service_include.jsp"%>

<html>
<meta charset="EUC-KR">
<meta id="viewport" name="viewport" content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, height=device-height, user-scalable=no, viewport-fit=cover">
<meta name="msapplication-tap-highlight" content="no">

<%
		request.setCharacterEncoding("EUC-KR");
		//NOT NULL
		String PAYMETHOD = request.getParameter("PAYMETHOD")==null?"":request.getParameter("PAYMETHOD");									//��������
		String CPID = request.getParameter("CPID")==null?"":request.getParameter("CPID"); 													//������ID
		String DAOUTRX = request.getParameter("DAOUTRX")==null?"":request.getParameter("DAOUTRX"); 											//�ٿ�ŷ���ȣ
		String ORDERNO = request.getParameter("ORDERNO")==null?"":request.getParameter("ORDERNO"); 											//�ֹ���ȣ
		String AMOUNT = request.getParameter("AMOUNT")==null?"":request.getParameter("AMOUNT");												//�����ݾ�
		String PRODUCTNAME = request.getParameter("PRODUCTNAME")==null?"":request.getParameter("PRODUCTNAME");									//��ǰ��
		String SETTDATE	= request.getParameter("SETTDATE")==null?"":request.getParameter("SETTDATE");										//��������
		String AUTHNO	= request.getParameter("AUTHNO")==null?"":request.getParameter("AUTHNO");											//ī����ι�ȣ
		//////////
		//NULL ���
		String CARDCODE	= request.getParameter("CARDCODE")==null?"":request.getParameter("CARDCODE"); 										//ī����ڵ�
		String CARDNAME = request.getParameter("CARDNAME")==null?"":request.getParameter("CARDNAME");										//ī����
		String CARDNO = request.getParameter("CARDNO")==null?"":request.getParameter("CARDNO");												//ī���ȣ(�߰�6�ڸ�)
		String EMAIL = request.getParameter("EMAIL")==null?"":request.getParameter("EMAIL");												//�� �̸���
		String USERID = request.getParameter("USERID")==null?"":request.getParameter("USERID");												//�� ID
		String USERNAME = request.getParameter("USERNAME")==null?"":request.getParameter("USERNAME");										//�����ڸ�
		String PRODUCTCODE = request.getParameter("PRODUCTCODE")==null?"":request.getParameter("PRODUCTCODE");								//��ǰ�ڵ�
		String RESERVEDINDEX1 = request.getParameter("RESERVEDINDEX1")==null?"":request.getParameter("RESERVEDINDEX1");						//�����׸�1
		String RESERVEDINDEX2 = request.getParameter("RESERVEDINDEX2")==null?"":request.getParameter("RESERVEDINDEX2");						//�����׸�2
		String RESERVEDSTRING = request.getParameter("RESERVEDSTRING")==null?"":request.getParameter("RESERVEDSTRING");						//�����׸�3
		String MOBILENO = request.getParameter("MOBILENO")==null?"":request.getParameter("MOBILENO");										//�����׸�3
		
		String msg = "";
		int result = 0;
		
		if(!CPID.equals("")){
			String sql = "";
			Connection conn = null;
			PreparedStatement pstmt = null;
			PreparedStatement pstmt0 = null;
			Statement pstmt2 = null;
			ResultSet rs = null;
			
			conn = dbconn.dbconnect();
	
			sql = "INSERT INTO " + "\r\n" +
					"KIWOOMPAY_RESULT(PAYMETHOD, CPID, DAOUTRX, ORDERNO, AMOUNT, PRODUCTNAME, SETTDATE, AUTHNO" +
										", CARDCODE, CARDNAME, CARDNO, EMAIL, USERID, USERNAME, PRODUCTCODE, RESERVEDINDEX1, RESERVEDINDEX2, RESERVEDSTRING, USER_NO, MOBILENO)" + "\r\n" +
					"VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
			pstmt = conn.prepareStatement(sql);
	
			pstmt.setString(1, PAYMETHOD);
			pstmt.setString(2, CPID);
			pstmt.setString(3, DAOUTRX);
			pstmt.setString(4, ORDERNO);
			pstmt.setString(5, AMOUNT);
			pstmt.setString(6, PRODUCTNAME);
			pstmt.setString(7, SETTDATE);
			pstmt.setString(8, AUTHNO);
			pstmt.setString(9, CARDCODE);
			pstmt.setString(10, CARDNAME);
			pstmt.setString(11, CARDNO);
			pstmt.setString(12, EMAIL);
			pstmt.setString(13, USERID);
			pstmt.setString(14, USERNAME);
			pstmt.setString(15, PRODUCTCODE);
			pstmt.setString(16, RESERVEDINDEX1);
			pstmt.setString(17, RESERVEDINDEX2);
			pstmt.setString(18, RESERVEDSTRING);
			pstmt.setString(19, USER_NO);
			pstmt.setString(20, MOBILENO);
			
			//System.out.println(sql);
	
			result = pstmt.executeUpdate();
			
			if(result > 0){
				Character productChk = new Character(PRODUCTCODE.charAt(0));
				
				if(productChk.equals('Q')){
					//QR��û�ϰ��
					sql = "UPDATE QR_REQUEST" + "\r\n" +
							"SET QR_PAYMENT_RESULT = 'Y', QR_PAYMENT_NAME = ?, QR_PAYMENT_EMAIL = ?, QR_PAYMENT_PRICE = ?, QR_PAYMENT_TID = ?" + "\r\n" +
							"WHERE QR_PAYMENT_PRODUCTCODE = ?" + "\r\n";
					
					pstmt0 = conn.prepareStatement(sql);
					
					pstmt0.setString(1, USERNAME);
					pstmt0.setString(2, EMAIL);
					pstmt0.setString(3, AMOUNT);
					pstmt0.setString(4, DAOUTRX);
					pstmt0.setString(5, PRODUCTCODE);
					
					pstmt0.executeUpdate();
					
				} else if(productChk.equals('T')){
					
					//���ڽ��� ���
					sql = "UPDATE SUPPORT" + "\r\n" +
							"SET SUPPORT_SUCCESS = 'Y', SUPPORT_NAME = ?, SUPPORT_EMAIL = ?, SUPPORT_PRICE = ?, SUPPORT_TID = ?" + "\r\n" +
							"WHERE SUPPORT_PRODUCTCODE = ?" + "\r\n";
					
					pstmt0 = conn.prepareStatement(sql);
					
					pstmt0.setString(1, USERNAME);
					pstmt0.setString(2, EMAIL);
					pstmt0.setString(3, AMOUNT);
					pstmt0.setString(4, DAOUTRX);
					pstmt0.setString(5, PRODUCTCODE);
					
					pstmt0.executeUpdate();
					
					pstmt2 = conn.createStatement();
					
					sql = "SELECT TEAM_NO" + "\r\n" +
							"FROM SUPPORT" + "\r\n" +
							"WHERE SUPPORT_PRODUCTCODE = '" + PRODUCTCODE + "' \r\n";
					
					rs = pstmt2.executeQuery(sql);
					
					if(rs.next()){
						String team_no = ConvertUtil.toStr(rs.getString("TEAM_NO"));
						
						sql = "UPDATE TEAM" + "\r\n" +
								"SET TEAM_MONEY = TEAM_MONEY + ?" + "\r\n" +
								"WHERE TEAM_NO = ?" + "\r\n";
						
						pstmt0 = conn.prepareStatement(sql);
						
						pstmt0.setString(1, AMOUNT);
						pstmt0.setString(2, team_no);
						
						pstmt0.executeUpdate();
					}
				}
				
			}
			
			if(pstmt2 != null){
				pstmt2.close();
			}
			
			if(pstmt0 != null){
				pstmt0.close();
			}
			
			if(pstmt != null){
				pstmt.close();
			}
			
			conn.close();
		}
	%>
	
	
	<body>
		<div data-role="page" id="kiwoompay_result_page">
			<div id="kwrp_content" data-role="content">
				<%
					if(result > 0){
						//msg = "���� ���� !";
						%>
						<RESULT>SUCCESS</RESULT>
						<%
					} else {
						//msg = "���� ���� !";
						%>
						<RESULT>FAILED</RESULT>
						<%
					}
				%>
			</div>
		</div>
	</body>
</html>