<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	if(loginMember.getMemberLevel() > 0) {
		String redirectUrl= "/admin/adminMain.jsp?";
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
	}
	
	// 모델 호출
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashList(loginMember.getMemberId());
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인</title>
		<link  href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Montserrat:100,300,400,500,700"/>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/NewFile.css">
	
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
	    <meta content="" name="keywords">
	    <meta content="" name="description">
	
	    <!-- Google Web Fonts -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
	    
	    <!-- Icon Font Stylesheet -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	
	    <!-- Libraries Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	    <link href="<%=request.getContextPath()%>/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
	
	    <!-- Customized Bootstrap Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Template Stylesheet -->
	    <link href="<%=request.getContextPath()%>/resources/css/style.css" rel="stylesheet">
		
		<meta name="description" content="">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	    <!-- Stylesheet -->
	    <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/onemusic/style.css">
	    
		<script type="text/javascript">
			<%
			if(request.getParameter("msg") != null) {         
				%>   
				alert("<%=request.getParameter("msg")%>");
				<%   
			}
			%>
		</script>
	</head>
	<body>
		<%
			if(loginMember.getMemberLevel() > 0) {
		%>
					<div>
						<!-- Sidebar -->
						<jsp:include page="/inc/adminSideMenu.jsp"></jsp:include>
					</div>
		<%
			} else {
		%>
				<div>
					<!-- nav -->
					<jsp:include page="/inc/memberMenu.jsp"></jsp:include>
				</div>
		<%
			}
		%>
		
		<section class="elements-area mt-30 section-padding-100-0">
			<div class="container">
	            <div class="row">
	            	<!-- #### 리스트 #### -->
					<div class="col-12">
			            <div class="h-100 p-4">
			            
				            <div class="elements-title">
		                        <h2>통계</h2>
		                        <a href="<%=request.getContextPath()%>/cash/cashStats.jsp">상세보기</a>
		                    </div>
		                    
			                <div class="table-responsive">
			                    <table class="table">
			                        <thead>
			                            <tr>
			                                <th scope="col">년도</th>
			                                <th scope="col">수입</th>
			                                <th scope="col">합계</th>
			                                <th scope="col">평균</th>
			                                <th scope="col">지출</th>
			                                <th scope="col">합계</th>
			                                <th scope="col">평균</th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                        	<%
											for(HashMap<String, Object> m : list) {
										%>
												<tr>
													<td><%=m.get("year") %></td>
													<td><%=m.get("importCnt")%></td>
													<td><%=m.get("importSum")%></td>
													<td><%=m.get("importAvg")%></td>
													<td><%=m.get("exportCnt")%></td>
													<td><%=m.get("exportSum")%></td>
													<td><%=m.get("exportAvg")%></td>
												</tr>
										<%
											}
										%>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
			        </div>
		        </div>
	        </div>
        </section>
		
		<!-- ##### All Javascript Script ##### -->
	    <!-- jQuery-2.2.4 js -->
	    <script src="<%=request.getContextPath()%>/resources/js/jquery/jquery-2.2.4.min.js"></script>
	    <!-- Popper js -->
	    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/popper.min.js"></script>
	    <!-- Bootstrap js -->
	    <script src="<%=request.getContextPath()%>/resources/js/bootstrap/bootstrap.min.js"></script>
	    <!-- All Plugins js -->
	    <script src="<%=request.getContextPath()%>/resources/js/plugins/plugins.js"></script>
	    <!-- Active js -->
	    <script src="<%=request.getContextPath()%>/resources/js/active.js"></script>
	    
	</body>
</html>