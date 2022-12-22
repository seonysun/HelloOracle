<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
	<% //자바 코딩하는 위치
	//1. 오라클 연동(DAO)
	FoodDAO dao=new FoodDAO();
	//2. 사용자 전송 데이터 받기 
	String strPage=request.getParameter("page");
					//request, response : 내장객체
					//웹에서는 스캐너 사용할 수 없으므로 선택값 가져오도록 설정
	if(strPage==null) //첫번째 수행에서 필요한 default값 설정
		strPage="1";
	int totalpage=dao.foodTotalPage();
	int curpage=Integer.parseInt(strPage);
	//3. SQL 데이터 받기
	ArrayList<FoodVO> list=dao.foodListData(curpage);
	//4. HTML로 출력
	request.setAttribute("list", list);
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{ /*바탕*/
   margin-top: 50px; /*상단에서 50px 띄움*/
   border: 1px black solid;
   height: 700px;
   width: 1200px;
}
.row{ /*글박스*/
   margin: 0px auto; /*가운데정렬*/
   width: 960px;
}
h1{
   text-align: center
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
		<%
		for(FoodVO vo:list){
		%>
		<div class="col-md-3">
	    <div class="thumbnail">
	      <a href="detail.jsp?fno=<%=vo.getFno()%>">
	        <img src="<%=vo.getPoster() %>" alt="Lights" style="width:100%">
	        <div class="caption">
	          <p><%=vo.getName() %>&nbsp;<span style="color:orange"><%=vo.getScore() %>></span></p>
	        </div>
	      </a>
	    </div>
	    </div>
		<%	
		}
		%>
		</div>
	<div style="height: 30px"></div> <!--공백-->
		<div class="row">
			<div class="text-center">
				<ul class="pagination">
				 <li><a href="list.jsp?page=1">1</a></li>
				 <li class="active"><a href="list.jsp?page=2">2</a></li>
				 <li><a href="list.jsp?page=3">3</a></li>
				 <li><a href="list.jsp?page=4">4</a></li>
				</ul>
			<a href="list.jsp?page=<%=curpage>1?curpage-1:curpage %>" class="btn btn-sm btn-danger">이전</a>
			<%=curpage %> page / <%=totalpage %> pages
			<a href="list.jsp?page=<%=curpage<totalpage?curpage+1:curpage %>" class="btn btn-sm btn-danger">다음</a>
			</div>
		</div>
	</div>
</body>
</html>