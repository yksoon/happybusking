<%@page import="db.dbconn"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@include file="/importhaed.jsp" %>
<div data-role="page" id="account_change" style="height: 100%;">
<!-- header 부분 -->
	<%@include file="/app_root/jsp/header/header.jsp"%>
	<%@include file="/app_root/jsp/panel/panel.jsp" %>
		<!-- content 부분 -->		
		<div id = "account_change_sec" data-role="content" style="text-align:center; padding: 0; height: auto !important;">
			<div id="account_change_header">
				<a id="account_chage_team_name"></a>의 지급 전용계좌
			</div>
			<div class="account_change_body">
				<div class="ui-grid-a" id="account_change_name">
					<div class="ui-block-a" style="width: 100%;" id="account_change_body_title">예금주</div>
					<div class="ui-block-b" style="width: 100%;">
						<input type="text" id="account_name" placeholder="이름을 입력해주세요">
					</div>
				</div>
			</div>
			<div class="account_change_body">
				<div class="ui-grid-a" id="account_change_bank">
					<div class="ui-block-a" style="width: 100%;" id="account_change_body_title">은행명</div>
					<div class="ui-block-b" style="width: 100%;">
						<select name="account_bank" id="account_bank">
							<option>국민</option>
							<option>신한</option>
							<option>우리</option>
							<option>하나</option>
							<option>카카오</option>
							<option>광주</option>
							<option>전북</option>
							<option>제주</option>
						</select>
					</div>
				</div>
			</div>
			<div class="account_change_body">
				<div class="ui-grid-a" id="account_change_acc">
					<div class="ui-block-a" style="width: 100%;" id="account_change_body_title">계좌번호</div>
					<div class="ui-block-b" style="width: 100%;">
						<input type="text" id="account_acc" placeholder="계좌번호를 입력해주세요 (-포함)">
					</div>
				</div>
			</div>
			<div id="account_change_btn">
				등록완료
			</div>
  		</div>
</div>