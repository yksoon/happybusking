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
<%@ page import="java.util.Date"%>
<%@include file="/service_include.jsp" %> 

<%
/*******************************************
* qr_scan 서비스
*******************************************/
String sql = "";
String sql2 = "";
String sql3 = "";
String sql4 = "";

Connection conn = null;
Statement pstmt = null;
ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;



boolean result = false;
String msg = "";

int t_chk = 0;
int t_chk2 = 0;
int see_chk = 0;

String TNO  = "";

String team_no = ParamUtil.getString(request, "team_no", "");

//System.out.println("team_no:" + team_no);

//qr코드 스캔 하려고 했다가 스캔안하고 뒤로 갔을 때
/* if(team_no.equals("undefined") && pf_no.equals("undefined")){
	msg = "스캔 실패";
	result = false;		
} */


%>


<%
	conn = dbconn.dbconnect();
	pstmt = conn.createStatement();
	
	//qr코드 스캔 하려고 했다가 스캔안하고 뒤로 갔을 때
	if(team_no.equals("undefined")){
		msg = "스캔 실패";
		result = false;		
	}else{
		
		//해당되는 아티스트 팀과 공연이 있는지 여부 검사
		sql = 	"SELECT COUNT(*) AS CNT FROM TEAM" + "\r\n" +
				 "WHERE TEAM_NO = '{TEAM_NO}'" + "\r\n";

			 	
				sql = sql.replace("{TEAM_NO}", team_no);
	
				rs = pstmt.executeQuery(sql);
				
				//System.out.println("sql" + sql);
				
				
				if(rs.next()) {
					//팀 존재 여부
					t_chk = rs.getInt("CNT");

					
					
					//팀  존재
					if(t_chk == 1){
						
	
						//암호화 키 값과 함수
						String key_value = "abcdefghijklmnop";

						AES128Util aes128 = new AES128Util(key_value);
						
						SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd HH:mm", Locale.KOREA);
						Date currentTime = new Date ();
						String mTime = mSimpleDateFormat.format ( currentTime );
						//System.out.println ("날짜 : " + mTime);
						
						//로그인 안한 상태에서 스캔했을 때(쿠키값으로 남기기)
						if(USER_NO == null || USER_NO == "null" || USER_NO == ""){

							Cookie c0 = null;
							/////////////////// 내가 봤던 공연을 위한 공연번호 쿠키 생성
							//쿠키 암호화
							team_no = aes128.encrypt(team_no);
							
							if(see_team == ""){
								c0 = new Cookie("see_teamNo", team_no + "@" + mTime);
							}else{
								see_team = see_team + "," + team_no + "@" + mTime;
								//쿠키생성
								c0 = new Cookie("see_teamNo", see_team);
							}
	
	
	
							
							//쿠키 유효기간 (60일)
							c0.setMaxAge(60*24*60*60); 
	
							
							//쿠키 path 지정
							c0.setPath("/");
	
							
							response.addCookie(c0);
							/////////////////////
							
							msg = "성공";
							result = true;
							
							TNO = aes128.decrypt(team_no);
						}else{//로그인 한 상태에서 스캔했을 때 바로 체크해서 값 등록
							//시간으로 해당 공연있는지 체크
					 		sql2 = "SELECT PF_NO, COUNT(*) AS CNT FROM PERFORM" + "\r\n" +
					 				"WHERE TEAM_NO = '" + team_no + "'" + "\r\n" +
					 				  "AND DATE_FORMAT('" + mTime + "', '%Y-%m-%d %H:%i')"  + "\r\n" + 
					 			  "BETWEEN DATE_FORMAT(CONCAT(PF_DATE, ' ' , PF_TIME), '%Y-%m-%d %H:%i')" + "\r\n" +
					 				  "AND DATE_FORMAT(CONCAT(PF_EDATE, ' ' , PF_ETIME), '%Y-%m-%d %H:%i')" + "\r\n" +
					 				  "AND PF_CANCLE = 0" + "\r\n";
					 		
					 		System.out.print(sql2);

					 		rs2 = pstmt.executeQuery(sql2);
					 		
					 		if (rs2.next()) {
					 			see_chk = rs2.getInt("CNT");
					 			//해당 공연 있을 때
					 			if(see_chk == 1){
					 				int pfNumber = rs2.getInt("PF_NO");
					 				
					 				//내가 본 공연쪽에 등록되어있는지 체크
					 				sql3 = "SELECT COUNT(*) AS UPR_CHK FROM USER_PERFORM_RECORD" + "\r\n" +
							 				"WHERE USER_NO ='" + USER_NO + "'" + "\r\n" + 
							 				   "AND PF_NO =" + pfNumber + "\r\n";
					 				
							 		System.out.print(sql3);

							 		rs3 = pstmt.executeQuery(sql3);
							 		
							 		if (rs3.next()) {
							 			int uPerformRecordChk = rs3.getInt("UPR_CHK");
							 			//내가 본 공연쪽에 없을 때
							 			if(uPerformRecordChk == 0){
							 				
							 				//내가 본 공연 테이블에 등록
							 				sql4 = "INSERT INTO" + "\r\n" +  
							 						"USER_PERFORM_RECORD(USER_NO, PF_NO)" +
							 						"VALUES('{userNo}'," + pfNumber +" )" + "\r\n"; 
							 				
							 				sql4 = sql4.replace("{userNo}", USER_NO);
											
							 				System.out.print(sql4);
							 				
											pstmt.executeUpdate(sql4);
							 			}
							 		}
					 			}
					 			
					 			
					 		}
							msg = "성공";
							result = true;
							
							TNO = team_no;
						}
					}else if(t_chk == 0){
						
						msg = "해당 아티스트 정보 없음";
						result = false;
					}
					
				
				}
	}
%>
	<ROOT>
		<DATA>
			<TNO><%=TNO%></TNO>
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