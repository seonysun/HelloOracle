<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
<% //자바 코딩하는 위치
FoodDAO dao=new FoodDAO();
String strPage=request.getParameter("page");
				//웹에서는 스캐너 사용할 수 없으므로 선택값 가져오도록 설정
if(strPage==null)//첫번째 수행(선택 전)
	strPage="1";
int totalpage=dao.foodTotalPage();
int curpage=Integer.parseInt(strPage);
ArrayList<FoodVO> list=dao.foodListData(curpage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{
   margin-top: 50px;
}
.row{
   margin: 0px auto;
   width: 1200px;
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
          <p><%=vo.getName() %></p>
        </div>
      </a>
    </div>
  </div>
		<%	
		}
		%>
		</div>
	<div style="height: 30px"></div>
		<div class="row">
			<div class="text-center">
			<a href="list.jsp?page=<%=curpage>1?curpage-1:curpage %>" class="btn btn-sm btn-danger">이전</a>
			<%=curpage %> page / <%=totalpage %> pages
			<a href="list.jsp?page=<%=curpage<totalpage?curpage+1:curpage %>" class="btn btn-sm btn-danger">다음</a>
			</div>
		</div>
	</div>
</body>
</html>