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
	
	// request -> 년도 + 월
	int year = 0;
	int month = 0;
	// 오늘 년도구하는 알고리즘
	if(request.getParameter("year") == null || request.getParameter("month") == null) {
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -1, 12인 경우 보정
		if(month == -1) {
			month = 11;
			year--;
		}
		if(month == 12) {
			month = 0;
			year++;
		}
	}
	
	// 출력하고자 하는 년, 월과 1일 요일구하는 알고리즠
	// 일=1 월=2 화=3...
	Calendar targetDate = Calendar.getInstance();
	// 지금으로 셋
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK);
	// 마지막 날짜구하는 알고리즘
	int lastDate = targetDate.getActualMaximum(Calendar.DATE);
	// 출력테이블의 시작 공백셀 마지막 공백셀 구하는 알고리즘
	int beginBlank = firstDay -1;
	int endBlank = 0; // (beginBlank + lastDate + endBlank) -> 7로 나누어 떨어짐
	if((beginBlank + lastDate)% 7 != 0) {
		endBlank = 7 - ((beginBlank + lastDate)% 7);
	}
	// 전체 td개수 = 7로 나누어 떨어짐
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model : 일별 cash목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	// view : 달력 출력+ 일별 csah 목록
	// 날짜 클릭 수입지출 내역 확인 기능
	// 수입 지출 입력 기능
	
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
	
	<div class="breadcumb-area bg-img bg-overlay">
        <div class="bradcumbContent">
	            <h2>
	            	<%=year%>년 <%=month+1%> 월
	            </h2>
				<div class="oneMusic-buttons-area">
                   <a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class=" m-2"><i class="fa fa-angle-double-left"></i> 이전</a>
                   <a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class=" m-2">다음 <i class="fa fa-angle-double-right"></i></a>
               </div>
		</div>
    </div>
	<section class="elements-area mt-20">
		<div style="padding:50px;">
            <div class="row">
				
				<!-- 캘린더 시작 -->
				<div class="calendar">
					<div class="calendar__header">
						<div>mon</div>
						<div>tue</div>
						<div>wed</div>
						<div>thu</div>
						<div>fri</div>
						<div>sat</div>
						<div>sun</div>
					</div>
					
					<div class="calendar__week">
				      	<% 
								for(int i = 1; i <= totalTd; i++) {
								%>
									<div class="calendar__day day">
										<%
										int date = i - beginBlank;
										if(date > 0 && date <= lastDate) {
										%>
											<div OnClick="location.href ='<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&day=<%=date%>'">
													<%=date%>
											</div>
											<div >
												<%
													//날짜별 수입지출
													for(HashMap<String, Object> m : list){
														String cashDate = (String)m.get("cashDate");
														if(Integer.parseInt(cashDate.substring(8)) == date) {
												%>
															<div>
																[<%=(String)m.get("categoryKind")%>]
																<%=(String)m.get("categoryName")%>
																&nbsp;
																<%=(Integer)m.get("cashPrice")%>원
															</div>
												<%
														}
													}
												%>
											</div>
										<%
										}
										%>
									</div>
									<%
										if(i%7 == 0 && i != totalTd) { // td7개마다 tr끊어줌
									%>
										</div><div class="calendar__week">
									<%		
											}
										}
									%>
						</div>
				</div>
				<!-- 캘린더 끝 -->
		</div>
</div>
</section>
</body>
</html>