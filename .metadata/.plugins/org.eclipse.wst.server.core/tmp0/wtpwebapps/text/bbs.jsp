<%@page import="bbs.Bbs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1" />
<link rel="stylesheet" href="css/bootstrap.css">
<style type = "text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>

<title>만반잘먹</title>
</head>
<body>
	<%
		String userID = null;
		// 로그인이 되어있으면 세션에 값이 있을 것이다.
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="main.jsp" class="navbar-brand">만반잘먹</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">먹자랑</a></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class = "table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thread>
					<tr>
						<th style ="background-color: #eeeeee; text-align: center;">번호</th>
						<th style ="background-color: #eeeeee; text-align: center;">제목</th>
						<th style ="background-color: #eeeeee; text-align: center;">작성자</th>	
						<th style ="background-color: #eeeeee; text-align: center;">작성일</th>	
					</tr>
				</thread>
				<tbody>
					<%
					BbsDAO bbsDAO = new BbsDAO();
					ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
					for(int i = 0; i < list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td>
							<a href = "view.jsp?bbsID=<%=list.get(i).getBbsID() %>">
							<%=list.get(i).getBbsTitle() %></a>
						</td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) +
						list.get(i).getBbsDate().substring(11, 13) + "시" +
						list.get(i).getBbsDate().substring(14, 16) + "분"%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
			//1페이지가 아니라면(이전페이지가 존재)
			if(pageNumber != 1){
			%>
			<a href = "bbs.jsp?pageNumber=<%=pageNumber-1 %>" class = "btn btn-success btn-arrow-left">이전</a>
			<%
			//다음페이지가 존재한다면
			} if(bbsDAO.nextPage(pageNumber+1)){
			%>
			<a href = "bbs.jsp?pageNumber=<%=pageNumber+1 %>" class = "btn btn-success btn-arrow-right">다음</a>
			<%
			}
			%>
			<a href = "write.jsp" class ="btn btn-primary pull-right">글쓰기</a>	
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>