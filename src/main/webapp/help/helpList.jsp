<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
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
	
	// Model : 문의 목록
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(loginMember);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>고객센터</title>
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
		<!-- #### 리스트 #### -->
		<section class="elements-area mt-30 section-padding-100-0">
			<div class="container">
				<div class="row">
					<div class="col-12">
						<div class="h-100 p-4">
				            <div class="elements-title">
		                        <h2>고객센터</h2>
		                    </div>
			                <div class="table-responsive">
			                    <table class="table">
			                        <thead>
			                            <tr>
			                                <th scope="col">문의내용</th>
			                                <th scope="col">작성일</th>
			                                <th scope="col">답변</th>
			                                <th scope="col">답변 작성일</th>
			                                <th scope="col"><i class="icon-settings"></i></th>
			                            </tr>
			                        </thead>
			                        <tbody>
										<%
											for(HashMap<String, Object> m : list){
										%>
												<tr>
													<td><%=m.get("helpMemo")%></td>
													<td><%=m.get("helpCreatedate")%></td>
														<%
														if(m.get("commentMemo") != null) {
															%>
																<td><%=m.get("commentMemo")%></td>
																<td><%=m.get("commentCreatedate")%></td>
															<%
														} else {
															%>
																<td>미답변</td>
																<td>미답변</td>
																<td>
																	<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>
																	<a href="<%=request.getContextPath()%>/help/deleteHelp.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>
																</td>
															<%
														}
													%>
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
		
		<!-- #### 문의 입력 #### -->					
		<section class="contact-area section-padding-100">
			<div class="container">
            	<div class="row">
                	<div class="col-12">
                    	<div class="contact-form-area">
							<form id="helpForm" action="<%=request.getContextPath()%>/help/insertHelpAction.jsp">
								<div class="col-12">
                                    <div class="form-group wow fadeInUp" data-wow-delay="400ms">
											<textarea class="form-control" id="helpMemo" name="helpMemo" cols="30" rows="10" placeholder="Message"></textarea>
                                    </div>
                                </div>
							</form>
                            <div class="col-12 text-center wow fadeInUp" data-wow-delay="500ms">
                            	<button id="helpBtn" class="btn oneMusic-btn mt-30" type="button">Send <i class="fa fa-angle-double-right"></i></button>
                             </div>
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<script>
			let helpBtn = document.querySelector('#helpBtn');
			helpBtn.addEventListener('click',function(){
				//디버깅
				console.log('click helpBtn');
				
				// 폼 유효성 검사
				let helpMemo = document.querySelector('#helpMemo');
				console.log(helpMemo.value);
				if(helpMemo.value == ''){
					alert('문의 내용을 입력해주세요');
					helpMemo.focus();
					return;
				}
				
				let helpForm = document.querySelector('#helpForm');
				helpForm.submit();
			});
		</script>
	</body>
</html>