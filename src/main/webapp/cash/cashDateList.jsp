<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	// controller : session 검증
	// 로그인 세션 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
	
	// 날짜별 내용(상세 내용 다나오면 되겠지?)수정, 삭제, 추가
	request.setCharacterEncoding("utf-8");
	// 값없을때 list로 돌아가는거 작성필요!!!
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("day"));
	System.out.println("date : " + date);
	System.out.println("month : " + month);
	System.out.println("year ; " + year);

	
	// Model : 일별 cash목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(loginMember.getMemberId(), year, month, date);
	
	// Model : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>달력</title>
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
		                        <h2><%=year%>년 <%=month%> 월 <%=date %>일</h2>
		                    </div>
		                    
			                <div class="table-responsive">
			                    <table class="table">
			                        <thead>
			                            <tr>
			                                <th scope="col">날짜</th>
			                                <th scope="col">종류</th>
			                                <th scope="col">가격</th>
			                                <th scope="col">메모</th>
			                                <th scope="col"><i class="icon-settings"></i></th>
			                            </tr>
			                        </thead>
			                        <tbody>
			                        	<%
										//날짜별 수입지출
										for(HashMap<String, Object> m : dateList){
											String cashDate = (String)m.get("cashDate");
											System.out.println((String)m.get("cashDate"));
						
											if(Integer.parseInt(cashDate.substring(8)) == date) {
											int cashNo = (Integer)m.get("cashNo");
										%>
										<tr>
											<td><%=(String)m.get("cashDate")%></td>
											<td>[<%=(String)m.get("categoryKind")%>] <%=(String)m.get("categoryName")%></td>
											<td><%=(Integer)m.get("cashPrice")%>원</td>
											<td><%=(String)m.get("cashMemo")%></td>
											<td>
												<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year %>&month=<%=month %>&day=<%=date %>"><i class="icon-eraser"></i></a>
												&nbsp;&nbsp;
												<a href="<%=request.getContextPath()%>/cash/deleteCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year %>&month=<%=month %>&day=<%=date %>"><i class="icon-trash"></i></a>
											</td>
										</tr>
										<%
											}
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
        
       	<!-- ##### 입력 ##### -->
	    <section class="contact-area section-padding-100">
	        <div class="container">
	            <div class="row">
	                <div class="col-12">
	                    <!-- Contact Form Area -->
	                    <div class="contact-form-area">
	                        <form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
	                            <input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
	                            <div class="row">
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="300ms">
		                                    <select name="catagoryNo">
												<%
													// 카테고리 넘버
													for(Category c : categoryList) {
														%>
															<option value="<%=c.getCategoryNo()%>">
																[<%=c.getCategoryKind()%>] <%=c.getCategoryName()%>
															</option>
														<%
													}
												%>
											</select>
	                                    </div>
	                                </div>
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="200ms">
	                                        <input type="text" class="form-control" name="cashPrice" placeholder="price">
	                                    </div>
	                                </div>
	                                <div class="col-12">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="400ms">
	                                        <textarea class="form-control" name="cashMemo" cols="30" rows="10" placeholder="Message"></textarea>
	                                    </div>
	                                </div>
	                                <div class="col-12 text-center wow fadeInUp" data-wow-delay="500ms">
	                                    <button class="btn oneMusic-btn mt-30" type="submit">Send <i class="fa fa-angle-double-right"></i></button>
	                                </div>
	                            </div>
	                        </form>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>
	    <!-- ##### 입력 End ##### -->

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