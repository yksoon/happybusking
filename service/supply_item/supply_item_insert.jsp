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
* 지원물품 등록(insert)
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;

boolean result = false;
String msg = "";

//지원물품 등록  Parameter 
String team_no =  ParamUtil.getString(request, "team_no", "");
//System.out.println(team_no);
String addr = ParamUtil.getString(request, "addr", "");
//System.out.println(addr);
String zip_code = ParamUtil.getString(request, "zip_code", "");
//System.out.println(zip_code);
String detail_addr = ParamUtil.getString(request, "detail_addr", "");
//System.out.println(detail_addr);
String[] item_value = request.getParameterValues("SelectItemArray");
//System.out.println(Arrays.toString(item_value));

%>

<ROOT>
<%
	try{
		conn = dbconn.dbconnect();
		pstmt = conn.createStatement();
		
	
 			sql = "SELECT IFNULL(MAX(ITEM_REQUEST_GRP_NO), 0) AS GRP_NO" + "\r\n" +  
					"FROM ITEM_REQUEST" + "\r\n" + 
				   "WHERE USER_NO = '" + USER_NO + "'\r\n";


			//sql = sql.replace("{category_name}", category_name); 
					
			//System.out.println(sql);
			
			rs = pstmt.executeQuery(sql);
			
			int grpNo = 0;
			if(rs.next()){
				grpNo = rs.getInt("GRP_NO");
				if(grpNo == 0){
					grpNo = grpNo + 1;
				}else{
					grpNo = grpNo + 1;
				}

			}
			//System.out.println("grpNo : " + grpNo);
			
			//int arraySize = item_value.length;
			
			String[] array_item_no = item_value[0].split(",");
			
			for(int i=0; i<array_item_no.length; i++){
				String[] itemArray = array_item_no[i].split("@");
				
				int item_no = Integer.parseInt(itemArray[0]);
				int item_count = Integer.parseInt(itemArray[1]);
				//System.out.println("item_no : " + item_no);
				//System.out.println("item_count : " + item_count);
				
				sql2 = "INSERT INTO" + "\r\n" +  
						"ITEM_REQUEST(ITEM_REQUEST_GRP_NO, ITEM_NO, TEAM_NO, USER_NO, POSTCODE, ADDR, DATAIL_ADDR, ITEM_REQUEST_COUNT, ITEM_REQUEST_DATE)" + "\r\n" +
						"VALUES( " + grpNo + "," + item_no + "," + team_no + "," + "'{user_no}'," + "'{postcode}'," + "'{addr}'," + "'{detail_addr}'," +  "\r\n" 
						+ item_count + ", NOW())" + "\r\n";  
				

				
				sql2 = sql2.replace("{user_no}", USER_NO);
				sql2 = sql2.replace("{postcode}", zip_code);
				sql2 = sql2.replace("{addr}", addr);
				sql2 = sql2.replace("{detail_addr}", detail_addr);
						
				//System.out.println(sql2);
				
				pstmt.executeUpdate(sql2);	
				
				
				sql3 = "UPDATE ITEM" + "\r\n" +  
						  "SET ITEM_COUNT = ITEM_COUNT - " + item_count + "\r\n" +
						"WHERE ITEM_NO = " + item_no + "\r\n";


				//System.out.println(sql3);
				
				pstmt.executeUpdate(sql3);	
				
				result = true;
				msg = "지원물품 신청 성공";
				
			}
			
			

				 	

	}catch(Exception e){
		result = false;
		msg = "지원물품 신청 실패";
		e.printStackTrace();
	}
%>	
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