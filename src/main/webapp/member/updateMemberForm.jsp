<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import = "java.net.URLEncoder" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		String msg = URLEncoder.encode("로그인해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
		System.out.println("로그인 필요");
		return;
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>CashBook</title>
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
	  	<!-- ##### 정보수정 ##### -->
		<section class="contact-area section-padding-100">
			<div class="container">
	            <div class="row">
					<div class="col-12">
						<div class="elements-title">
	                       	<h2>정보수정</h2>
	                    </div>
	                     <div class="contact-form-area">
							<form id="updateForm" action="<%=request.getContextPath()%>/member/updateMemberAction.jsp">
								<div class="row">
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" id="memberId" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly">
	                                    </div>
	                                </div>
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" id="memberName" name="memberName" placeholder="<%=loginMember.getMemberName()%>">
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="200ms">
	                                        <input type="password" class="form-control" id="memberPw" name="memberPw" placeholder="password">
	                                    </div>
	                                </div>
	                                <div class="col-12 text-center wow fadeInUp" data-wow-delay="500ms">
	                                    <button id="updateBtn" class="btn oneMusic-btn mt-30" type="submit">Send <i class="fa fa-angle-double-right"></i></button>
	                                </div>
	                             </div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- ##### 비밀번호 변경 ##### -->
		<section class="contact-area section-padding-100">
			<div class="container">
	            <div class="row">
					<div class="col-12">
						<div class="elements-title">
	                       	<h2>비밀번호 수정</h2>
	                    </div>
	                     <div class="contact-form-area">
							<form id="updatePw" action="<%=request.getContextPath()%>/member/updateMemberPwAction.jsp">
                                    	<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
								<div class="row">
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" id="memberId" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly">
	                                    </div>
	                                </div>
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" id="memberName" name="memberName" placeholder="<%=loginMember.getMemberName()%>">
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="200ms">
	                                        <input type="password" class="form-control" id="memberPw" name="memberPw" placeholder="현재 비밀번호">
	                                        <input type="password" class="form-control" id="memberPw1" name="memberPw1" placeholder="새비밀번호">
	                                        <input type="password" class="form-control" id="memberPw2" name="memberPw2" placeholder="새비밀번호 확인">
	                                    </div>
	                                </div>
	                                <div class="col-12 text-center wow fadeInUp" data-wow-delay="500ms">
	                                    <button id="updatePwBtn" class="btn oneMusic-btn mt-30" type="submit">Send <i class="fa fa-angle-double-right"></i></button>
	                                </div>
	                             </div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- ##### 회원탈퇴 ##### -->
		<div class="col-12 text-center wow fadeInUp" data-wow-delay="500ms">
            <button class="btn oneMusic-btn mt-30" type="button" onclick="location.href='<%=request.getContextPath()%>/member/deleteMemberForm.jsp'">탈퇴 <i class="fa fa-angle-double-right"></i></button>
        </div>
		
		<script>
			let 
		</script>
	</body>
</html>