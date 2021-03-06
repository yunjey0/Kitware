<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <jsp:include page="../container/header.jsp" flush="true"></jsp:include> --%>
<%@ include file="../container/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<form id="formwrite">
<c:set var="doc" value="${requestScope.docvo_list}" />
<c:set var="doc_conf" value="${requestScope.doc_detail_list}"/>
<c:set var="session" value="${sessionScope.loginInfo}"></c:set>	
<c:set var="exp" value="${param.exp}"/>
	<div class="center-block">
		<div class="title" align="center">
			<h2>${doc.doc_kindvo.doc_name}</h2>
		</div>
		<div class="table">
			<table class="table table-bordered">
				<tr>
					<th>문서번호</th>
					<td colspan="3">${doc.doc_num}</td>
					<th rowspan="2">결재</th>
					<c:forEach var="cn" items="${doc_conf}" >
					<td rowspan="2">
						<div>${cn.members.name}</div>
						<c:choose>
					 	<c:when test="${cn.acs_yn eq '0'}">
						<div>${cn.acs_yn} 대기</div> 
						</c:when>
					 	<c:when test="${cn.acs_yn eq '1'}">
						<span style="font-weight:bold;color:red">${cn.acs_yn}결재</span>
						</c:when>
						<c:when test="${cn.acs_yn eq '3'}">
						<div>${cn.acs_yn} 반려</div></c:when>
						</c:choose>
					</td>
						</c:forEach>
						</tr>
				<tr>
					<th>문서종류</th>
					<td colspan="3">${doc.doc_kindvo.doc_name}</td>
				</tr>
				<tr>
					<th>기안일</th>
					<td colspan="3">${doc.start_date}</td>
					<th>문서 상태</th>
					<c:choose>
					<c:when test="${doc.doc_state eq '1'}">
					<td>진행</td>
					</c:when>
					<c:when test="${doc.doc_state eq '2'}">
					<td>완료</td>
					</c:when>
					<c:when test="${doc.doc_state eq '3'}">
					<td>취소</td>
					</c:when>
					<c:otherwise>
					<td>상신</td>
					</c:otherwise>
					</c:choose>
					
					<th>수신부서</th>
					<td colspan="3">${doc.rcv_dept}</td>
				</tr>
				<tr>
					<th>기안자</th>
					<td colspan="3">${doc.members.name}(${doc.gradeinfo.position_name})</td>
					<th>참조자</th>	
					<td>${doc.refer}</td>
					<th>부서</th>
					<td>${doc.deptinfo.dept_name}</td>
				</tr>
				
				<tr>
					<th>제목</th>
					<td colspan="8">${doc.doc_title}</td>
				</tr>
				<tr>
				<td colspan = "12" height ="200">${doc.doc_content}</td>
			</tr>
				<tr>
					<td colspan="8" align="center">
				<c:set var="sname" value="${session.name}" />
				<c:set var="dname" value="${doc.members.name}" />
				<c:choose>
					<c:when test="${doc.doc_state ne '2'&& doc.doc_state ne '3'}">
						<c:if test="${sname eq dname}">
						<input type="button" value="수정" id="edit" onclick = "editdocnum('${doc.doc_num}')"> 
					    <input type="button" value="삭제" id="del" onclick = "deldocnum('${doc.doc_num}')">
						</c:if>
						</c:when>
					</c:choose>
					<c:set var="snum" value="${session.emp_num}" />
					<c:if test="${exp eq null}">
					<c:forEach items="${doc_conf}" var="item" varStatus="status">
					  <c:if test="${item.conf_num eq snum}">
					  <c:if test="${item.acs_yn eq '0'}">
						<input type="button" value="승인" id="ok" onclick = "gjdocnum(${doc_conf[0].acs_yn}${doc_conf[1].acs_yn}${doc_conf[2].acs_yn},'${doc.doc_num}','${doc.doc_state}','${fn:length(doc_conf)} ')">
						<input type="button" value="반려" id="down" onclick = "downdocnum(${doc_conf[0].acs_yn}${doc_conf[1].acs_yn}${doc_conf[2].acs_yn},'${doc.doc_num}')">
					 </c:if>
					  </c:if>
					  </c:forEach>
					  </c:if>
						<input type="button" value="뒤로가기" id="back">
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
<script type="text/javascript">
	

	function editdocnum(data) {
		location.href= "doceditgian.do?doc_num="+data+"&mode=read"
		console.log(data);
	}

	function deldocnum(data) {
		location.href= "docdelcj.do?doc_num="+data;
		console.log(data);
		alert("삭제완료");
	}
	function gjdocnum(data, data2, data3, data4) {
		console.log(data);
		console.log(data2);
		location.href= "docgjupdate.do?doc_num="+data2+"&mode="+data+"&kind=up"+"&smode="+data3+"&count="+data4;
		console.log(data);
		alert("승인완료");
	}
	function downdocnum(data, data2) {
		console.log(data);
		console.log(data2);
		location.href= "docgjupdate.do?doc_num="+data2+"&mode="+data+"&kind=down";
		console.log(data);
		alert("반려완료");
	}
	
	$(function() {
		$("#testDatepicker").datepicker({
			showOn : "both",
			/* buttonImage: "button.png", 
			buttonImageOnly: true  */
			dateFormat : "yy-mm-dd"
		});

		$("#testDatepicker2").datepicker({
			showOn : "both",
			/* buttonImage: "button.png", 
			buttonImageOnly: true  */
			dateFormat : "yy-mm-dd"
		});
		
		/* $("#edit").click(function() {
			location.href= "doceditcj.do?mode=read"
		return false;
		}); */
		$("#back").click(function() {
			history.back();
		return false;
		});
		/* $("#del").click(function() {
			console.log('aaaaaaa');
			location.href= "docdelcj.do"
		return false;
		}); */
		var className = 'authorization';
		$('div#menutab li.' + className).addClass('active');
		console.log($('div#menutab li.' + className));
		$('ul#side-menu').find('li.' + className).show();
	});
</script>
<%@ include file="../container/footer.jsp" %>
<%-- <jsp:include page="../container/footer.jsp" flush="true"></jsp:include> --%>