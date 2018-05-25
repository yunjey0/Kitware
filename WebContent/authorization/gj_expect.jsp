<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../container/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pb" value="${requestScope.pagebean }"/> 
<div id="div1"></div>
<div class="container">
	<div>&nbsp;</div>
	<h2>결재 예정</h2>
	<div>&nbsp;</div>
	<table class="table table-striped table-hover">
	<thead class = "thead-light">
			<tr class="table-primary">
				<td>문서번호</td>
				<td>문서제목</td>
				<td>문서상태</td>
				<td>기안일</td>
				<td>문서이름</td>
			</tr>
	</thead>
			<c:set var="list" value="${pb.list}"/>
			<c:forEach var="b" items="${list}" >
			<%-- <c:forEach begin="1" end="${b.level}">▷</c:forEach> --%>
		<tr>					
								<td>${b.doc_num}</td>
								<td>${b.doc_title}</td>
								<td>${b.doc_state}</td>
								<td>${b.start_date}</td>
							    <td>${b.doc_kindvo.doc_name}</td>
		</tr>
			</c:forEach>
	</table>
	
		
	
<div class="pagination">
 <c:set var="startPage" value="${pb.startPage}"/>
 <c:set var="endPage" value="${pb.endPage}"/>
 <c:if test="${startPage > 1}">  
  <Button>&laquo;</Button>
 </c:if>
 <div class="text-center">
 <c:forEach begin="${startPage}" end="${endPage}" var="i" >  
  <button type="button">${i}</button>	  
 </c:forEach> 
 </div>
 <c:if test="${endPage < pb.totalPage}" >  
  <Button>&laquo;</Button> 
  </c:if>
</div> 
</div>
<style>
.container {
	padding-right: 350px;
}

p {
	padding-top: 50px;
	padding-right: 30px;
	padding-bottom: 50px;
	padding-left: 80px;
}

body {
	width: 100%;
	margin: 0;
	padding: 0;
}

pd {
	padding-right: 200px;
}

button {
	background-color: #337ab7; /* Green */
	border: none;
	color: white;
	padding: 8px 10px;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
thead{
	background-color: #337ab7;
	color: white;
	font-weight: bold;
}
</style>

<script>
$(function(){
	$('.pagination button').click(function(){
		var page;
		if($(this).text() == '«'){
			page=${pb.startPage}-1;
		}else if($(this).text() == '»'){
			page=${pb.endPage}+1;
		}else{
			page = $(this).text();
			location.href="gjexpectlist.do?page="+page;
		}
		
		return false;
	});
	$('.pagination a').each(function(index, element){
		if($(element).text() == '${pb.currentPage}'){
			$(element).addClass('active');
		}
	});    

	 var className = 'authorization';
		$('div#menutab li.'+className).addClass('active');
		console.log($('div#menutab li.'+className));
		$('ul#side-menu').find('li.' + className).show();
});
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<%@include file="../container/footer.jsp"%>