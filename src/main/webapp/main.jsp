<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	//session 유효성 검증 코드
	request.setCharacterEncoding("utf-8");
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		System.out.println("로그인중");
		return;
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeByPage(beginRow, rowPerPage);
	
	int count = noticeDao.selectNoticeCount();
	int lastPage = (int)Math.ceil((double)count / (double)rowPerPage); // 구하기
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	    <meta charset="UTF-8">
	    <meta name="description" content="">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	
	    <!-- Title -->
	    <title>가계부</title>
	
	    <!-- Stylesheet -->
	    <link rel="stylesheet" href="resources/onemusic/style.css">
	
	</head>
	
	<body>
	    <!-- ##### 메인 ##### -->
	    <section>
		    <div class="hero-slides owl-carousel">
	             <div class="single-hero-slide d-flex align-items-center justify-content-center">
		   			<div class="container">
	                    <div class="row">
	                     	<div class="col-12">
	                     		<div class="hero-slides-content text-center" data-wow-delay="100ms">
	                             	<div>
	                             		<img src="resources/onemusic/img/300x300.jpg">
	                             	</div>
	                             	<h2 data-animation="fadeInUp" data-delay="100ms">CASH BOOK</h2>
	                             	<h6 data-animation="fadeInUp" data-delay="300ms">기능? 설명? 차트사진 같은거</h6>
	                             	<a data-animation="fadeInUp" data-delay="400ms" href="<%=request.getContextPath()%>/loginForm.jsp" class="btn oneMusic-btn mt-50">START <i class="fa fa-angle-double-right"></i></a>
	                         	</div>
	                         </div>
	                     </div>
					</div>
				</div>	
		                
	            <div class="single-hero-slide d-flex align-items-center justify-content-center">
	            	<div class="container">
	            		<div class="row">
	            			<div class="col-12">
	                     		<div class="hero-slides-content text-center" data-wow-delay="100ms">
	                             	<div>
	                             		<img src="resources/onemusic/img/300x300.jpg">
	                             	</div>
	                             	<h2 data-animation="fadeInUp" data-delay="100ms">CASH BOOK</h2>
	                             	<h6 data-animation="fadeInUp" data-delay="300ms">11</h6>
	                             	<a data-animation="fadeInUp" data-delay="400ms" href="<%=request.getContextPath()%>/loginForm.jsp" class="btn oneMusic-btn mt-50">시작하기 <i class="fa fa-angle-double-right"></i></a>
	                         	</div>
	                       	</div>
	                  	</div>
	               	</div>
	           	</div>
	       	</div>
	   	</section>
	    
	    <div class="blog-area section-padding-100">
	        <div class="container">
	            <div class="row">
	                <div class="col-12">
	                    <!-- 공지 Start -->
							<%
								for(Notice n : list){
							%>
								<!-- Single Post Start -->
			                    <div class="single-blog-post mb-100 wow fadeInUp" data-wow-delay="100ms">
			                        <!-- Post Thumb -->
			                        <div class="blog-post-thumb mt-30">
			                            <a href="#"><img src="" alt=""></a>
			                            <!-- Post Date -->
			                            <div class="post-date">
			                                <span><%=n.getCreatedate().substring(8, 10)%></span>
				                            <span><%=n.getCreatedate().substring(5, 7) + " ‘" + n.getCreatedate().substring(2, 4)%></span>
			                            </div>
			                        </div>
			
			                        <!-- Blog Content -->
			                        <div class="blog-content">	
			                            <!-- Post Title -->
			                            <a class="post-title mt-15"><%=n.getNoticeMemo()%></a>
			                        </div>
			                    </div>
							<%
								}
							%>
	                    <!-- Pagination -->
	                    <div class="oneMusic-pagination-area wow fadeInUp" data-wow-delay="300ms">
	                        <nav>
	                            <ul class="pagination">
	                                <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/main.jsp?currentPage=1">처음</a></li>
	                                <%
										if(currentPage > 1){
									%>
	                                		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/main.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
	                                <%
										}
										if(currentPage < lastPage){
									%>
	                                		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/main.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
	                                <%
										}
									%>
	                                <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/main.jsp?currentPage=<%=lastPage%>">END</a></li>
	                            </ul>
	                        </nav>
	                    </div>
	                </div>
	             </div>
	         </div>
	     </div>
	    <!-- ##### Blog Area End ##### -->
	    
	    <!-- ##### Contact Area Start ##### -->
	    <section class="contact-area section-padding-100">
	        <div class="container">
	            <div class="row">
	                <div class="col-12">
	                    <div class="section-heading white wow fadeInUp" data-wow-delay="100ms">
	                        <p>See what’s new</p>
	                        <h2>Get In Touch</h2>
	                    </div>
	                </div>
	            </div>
	
	            <div class="row">
	                <div class="col-12">
	                    <!-- Contact Form Area -->
	                    <div class="contact-form-area">
	                        <form action="#" method="post">
	                            <div class="row">
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="100ms">
	                                        <input type="text" class="form-control" id="name" placeholder="Name">
	                                    </div>
	                                </div>
	                                <div class="col-md-6 col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="200ms">
	                                        <input type="email" class="form-control" id="email" placeholder="E-mail">
	                                    </div>
	                                </div>
	                                <div class="col-lg-4">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="300ms">
	                                        <input type="text" class="form-control" id="subject" placeholder="Subject">
	                                    </div>
	                                </div>
	                                <div class="col-12">
	                                    <div class="form-group wow fadeInUp" data-wow-delay="400ms">
	                                        <textarea name="message" class="form-control" id="message" cols="30" rows="10" placeholder="Message"></textarea>
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
	    <!-- ##### Contact Area End ##### -->
	
	    <!-- ##### Footer Area Start ##### -->
	    <footer class="footer-area">
	        <div class="container">
	            <div class="row d-flex flex-wrap align-items-center">
	                <div class="col-12 col-md-6">
	                    <a href="#"><img src="resources/onemusic/img/core-img/logo.png" alt=""></a>
	                    <p class="copywrite-text"><a href="#"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
	Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
	<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
	                </div>
	
	                <div class="col-12 col-md-6">
	                    <div class="footer-nav">
	                        <ul>
	                            <li><a href="#">Home</a></li>
	                            <li><a href="#">Albums</a></li>
	                            <li><a href="#">Events</a></li>
	                            <li><a href="#">News</a></li>
	                            <li><a href="#">Contact</a></li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </footer>
	    <!-- ##### Footer Area Start ##### -->
	
	    <!-- ##### All Javascript Script ##### -->
	    <!-- jQuery-2.2.4 js -->
	    <script src="resources/onemusic/js/jquery/jquery-2.2.4.min.js"></script>
	    <!-- Popper js -->
	    <script src="resources/onemusic/js/bootstrap/popper.min.js"></script>
	    <!-- Bootstrap js -->
	    <script src="resources/onemusic/js/bootstrap/bootstrap.min.js"></script>
	    <!-- All Plugins js -->
	    <script src="resources/onemusic/js/plugins/plugins.js"></script>
	    <!-- Active js -->
	    <script src="resources/onemusic/js/active.js"></script>
	</body>
</html>