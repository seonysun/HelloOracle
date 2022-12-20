<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.util.*,com.sist.dao.*"%>
    <% 
    //1. ����� ���� ������ �ޱ� 
    String strPage=request.getParameter("page");
    				//request, response : ���尴ü
    				//�������� ��ĳ�� ����� �� �����Ƿ� ���ð� ���������� ����
    if(strPage==null) //ù��° ���࿡�� �ʿ��� default�� ����
		strPage="1";
	int curpage=Integer.parseInt(strPage);
    //2. ����Ŭ ����(DAO)
    FoodDAO dao=new FoodDAO();
    //3. SQL ������ �ޱ� 
    ArrayList<FoodVO> list=dao.foodListData(curpage);
    //4. HTML�� ���
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container{ /*����*/
   margin-top: 50px; /*��ܿ��� 50px ���*/
   border: 1px black solid;
   height: 700px;
   width: 1200px;
}
.row{ /*�۹ڽ�*/
   margin: 0px auto; /*�������*/
   width: 960px;
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
			      <a href="#">
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
		<div style="height: 20px"></div> <!--����-->
		<div class="row">
			<div class="text-center">
				<ul class="pagination">
				 <li><a href="list.jsp?page=1">1</a></li>
				 <li class="active"><a href="list.jsp?page=2">2</a></li>
				 <li><a href="list.jsp?page=3">3</a></li>
				 <li><a href="list.jsp?page=4">4</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>