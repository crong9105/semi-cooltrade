<%@page import="com.cooltrade.product.model.vo.Review"%>
<%@page import="com.cooltrade.product.model.vo.ReviewType"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewCount = (int)request.getAttribute("reviewCount");
	ArrayList<ReviewType> rtList = (ArrayList<ReviewType>)request.getAttribute("reviewTypeCount");
	ArrayList<ReviewType> rtdList = (ArrayList<ReviewType>)request.getAttribute("reviewTypeDetail");
	ArrayList<Review> rList = (ArrayList<Review>)request.getAttribute("reviewList");
	Review avg = (Review)request.getAttribute("avg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<style>
    @font-face {
        font-family: 'GmarketSansMedium';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'GmarketSansMedium';
        color: #444444;
    }

    .flex-class {
        display: flex;
    }

    div {
        /* border: 1px solid red; */
    }

    #mypage-wrap {
        width: 1000px;
        margin: auto;
        display: flex;
        margin-top: 200px;
        padding-top: 20px;
    }

    /* 왼쪽 컨텐츠 CSS */
    #left-content {
        width: 20%;
    }

    #tit {
        font-weight: 800;
        letter-spacing: -1.5px;
        height: 60px;
    }

    li {
        list-style: none;
    }

    a {
        text-decoration: none;
        color: #444444;
    }

    a:hover {
        color: rgb(4, 180, 252);
    }

    .sub-title-list {
        padding: 3px 0px;
        font-size: 15px;
    }

    .sub-title-h3 {
        font-size: 18px;
        font-weight: 600;
    }

    .sub-title-li {
        padding-bottom: 20px;
    }

    /* 오른쪽 컨텐츠 css */
    #right-content {
        width: 80%;
    }

    #right-content-wrap>div {
        /* padding: 10px 0px; */
    }

    #right-content-title {
        font-size: 18px;
        font-weight: 700;
        width: 100%;
        padding: 10px 0px;
    }

    #trade-review-count {
        font-size: 16px;
        /* border-bottom: 1px solid #e6e6e6; */
        width: 100%;
        padding: 10px 0px;
    }

    #trade-review-count>span {
        color: rgb(4, 180, 252);
    }

    #trade-review-total {
        display: flex;
        justify-content: space-evenly;
        border: 1px solid #e6e6e6;
        border-radius: 5px;
        padding: 10px 0px;
    }

    #trade-review-total>div {
        display: flex;
        align-items: center;
        flex-direction: column;
    }

    #review-select-section-top>div, #review-select-section-bottom>div {
        align-items: center;
        background-color: #f0f0f0;
        margin: 10px 0px;
        padding: 0px 15px;
        height: 35px;
        border-radius: 5px;
        display: flex;
        justify-content: space-between;
    }

    #review-select-section-bottom {
        display: none;
    }

    #arrow-img {
        display: flex;
        justify-content: space-around;
        cursor: pointer;        
        padding-bottom: 20px;
        border-bottom: 1px solid #e6e6e6;
    }

    #review-list-area {
        border-bottom: 1px solid #e6e6e6;
        height: auto;
    }

    #review-list-area>div {
        padding: 10px 20px;
    }

    #buyer-profile-img {
        width: 10%;
    }

    #review-content {
        width: 90%;
        font-size: 14px;
        display: flex;
        justify-content: space-between;
    }

    #review-content>div {
        height: 100%;
        align-items: center;
    }

    #review-content-buyer-name {
        justify-content: space-between;
    }

    #moreBtn-area {
        display: flex;
        justify-content: space-around;
        align-items: center;
        height: 70px;
    }

    #moreBtn>div {
        padding: 0px 5px;
    }

    #product-title-btn {
        border: 1px solid #e6e6e6;
        height: 30px;
        width: auto;
        padding: 5px 10px;
        background-color: transparent;
    }

    #product-title-btn>img {
        margin-left: 5px;
    }

    #review-report-btn {
        border: none;
        background-color: transparent;
    }
    
    #reviewImg {
    	width: 130px;
	    height: 130px;
	    margin-top: 30px;
    }
    
    #reviewImgDiv {
    	display: flex;
	    justify-content: flex-end;
	    height: 5px;
    }
    
	#starScore>span {
	    appearance: none;
	    -webkit-appearance: none; /* Safari 및 Chrome 지원 */
	    -moz-appearance: none; /* Firefox 지원 */
	}

	.rating {
	   position: relative;
	   width: 180px;
	   background: transparent;
	   display: flex;
	   justify-content: center;
	   align-items: center;
	   gap: .3em;
	   padding: 5px;
	   overflow: hidden;
	   border-radius: 20px;
	   box-shadow: 0 0 2px #b3acac;
	}
	
	.rating__result {
	   position: absolute;
	   top: 0;
	   left: 0;
	   transform: translateY(-10px) translateX(-5px);
	   z-index: -9;
	   font: 3em Arial, Helvetica, sans-serif;
	   color: #ebebeb8e;
	   pointer-events: none;
	}
	
	.rating__star {
	   font-size: 1.3em;
	   color: #dabd18b2;
	   transition: filter linear .3s;
	}

    #review-content-left>div {
        padding: 5px 0px;
    }

    #review-content-right {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
    }

    #review-detail-div {
        width: 400px;
        height: 60px;
        border: 1px solid #e6e6e6;
    }

    #review-detail-div>div {
        padding: 0px 5px;
    }
    
    #review-load-btn {
    	cursor: pointer;
    }
    
    .load-div {
    	display: none;
    }
    
    .load-div.active {
    	display: block;
    }
    
    .load-div.after {
    	display: none;
    }

    .review-type-detail-div {
        background-color: #5678e6;
        /* border: 1px solid #e6e6e6; */
        color: #ffffff;
        margin-right: 5px;
        border-radius: 5px;
        font-size: 12px;
        padding: 3px 5px;
    }
    
    .review-type-content {
    	display: grid;
	    grid-template-columns: repeat(2, 1fr);
	    gap: 5px;
    }
	
</style>
</head>
<body>

	<%@ include file = "../common/header.jsp" %>
	
	<% int userNo = loginUser.getUserNo(); %>

    <div id="mypage-wrap">
        <div id="left-content">
            <div id="mypage-tit">
                <h2 id="tit">
                	<a href="<%= contextPath %>/mypage.me?uno=<%= userNo %>">마이페이지</a>
                </h2>
            </div>
            <div>
               <div>
                    <ul>
                        <li class="sub-title-li">
                            <h3 class="sub-title-h3">내정보</h3>
                            <ul>
                                <li class="sub-title-list">
                                    <a href="<%= contextPath %>/infoedit.me">회원정보 수정</a>
                                </li>
                                <li class="sub-title-list">
                                    <a href="<%= contextPath %>/review.me?uno=<%= userNo %>">거래 후기</a>
                                </li>
                            </ul>
                        </li>
                        
                        <li class="sub-title-li">
                            <h3 class="sub-title-h3">마이 쇼핑</h3>
                            <ul>
                                <li class="sub-title-list">
                                    <a href="<%= contextPath %>/likelist.me?uno=<%= userNo %>&cpage=1">찜한 상품</a>
                                </li>
                                <li class="sub-title-list">
                                    <a href="<%= contextPath %>/buylist.me?uno=<%= userNo %>&cpage=1">구매 내역</a>
                                </li>
                                <li class="sub-title-list">
                                    <a href="<%= contextPath %>/selllist.me?uno=<%= userNo %>&cpage=1">판매 내역</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
               </div>
            </div>
        </div>
        <div id="right-content">
            <div id="right-content-wrap">
                <div id="right-content-title">
                    거래 후기
                </div>

                <div id="trade-review-count">
                    받은 후기
                    <span><%= reviewCount %></span>
                </div>

                <div id="trade-review-total">                                               
                    <div>
                        <div><%= avg.getScore() %></div>
                        <div id="avgStar"></div>
                    </div>
                    <div>
                        <div><%= avg.getAvgScore() %>%</div>
                        <div><small>만족후기</small></div>
                    </div>
                </div>
                
                <script>
					//const starClassActive = "rating__star fas fa-star"; // 텅빈별
	              	//const starClassInactive = "rating__star far fa-star"; // 색칠한별
	              	var avgStar = document.getElementById("avgStar").innerHTML;
	              	console.log("avgStar" + avgStar);
	              	var avgScore = <%= avg.getScore() %>;
	              	console.log("avgScore : " + avgScore)

	              	var starscore = '';

	              	for (var i = 1; i <= 5; i++) {
	              	    if (i <= avgScore) {
	              	        starscore += '<span class="rating__star fas fa-star"></span>';
	              	    } else {
	              	        starscore += '<span class="rating__star far fa-star"></span>';
	              	    }
	              	}

	              	document.getElementById("avgStar").innerHTML = starscore;
	              	
				</script>

                <div style="padding: 10px 0px;">
                    <div id="review-select-section-top">
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/heart.png" width="20px" height="20px">
                                </div>
                                <div>친절하고 배려가 넘쳐요.</div>
                            </div>
                            <div>
                            	<%= rtList.get(0).getCount() %>
                            </div>
                        </div>
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/giftbox.png" width="20px" height="20px">
                                </div>
                                <div>포장이 깔끔해요.</div>
                            </div>
                            <div><%= rtList.get(1).getCount() %></div>
                        </div>
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/speech.png" width="20px" height="20px">
                                </div>
                                <div>채팅 답변이 빨라요.</div>
                            </div>
                            <div><%= rtList.get(2).getCount() %></div>
                        </div>
                    </div>
                    <div id="review-select-section-bottom">
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/checkmark.png" width="20px" height="20px">
                                </div>
                                <div>상품 설명과 실제 상품이 동일해요.</div>
                            </div>
                            <div><%= rtList.get(3).getCount() %></div>
                        </div>
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/document.png" width="20px" height="20px">
                                </div>
                                <div>상품 정보가 자세히 적혀있어요.</div>
                            </div>
                            <div><%= rtList.get(4).getCount() %></div>
                        </div>
                        <div class="flex-class">
                            <div class="flex-class">
                                <div>
                                	<img src="resources/images/shipping-truck.png" width="20px" height="20px">
                                </div>
                                <div>배송이 빨라요.</div>
                            </div>
                            <div><%= rtList.get(5).getCount() %></div>
                        </div>
                    </div>
                </div>

                <div>
                    <div id="arrow-img">
                        <img src="resources/images/downArrow.png" alt="화살표 이미지" width="20" height="20" onclick="reviewOpen(this);">
                    </div>
                </div>

                <script>
                    // 누르면 펼치고 누르면 닫힘
                    let newImg = "resources/images/upArrow.png";
                    let currentImg = "resources/images/downArrow.png";

                    function reviewOpen(btn){

                        const reviewBtn = btn;
                        
                        if($("#review-select-section-bottom").css('display') == 'none'){
                            $("#review-select-section-bottom").css('display', 'block');
                            $(reviewBtn).attr('src', newImg);
                        } else {
                            $("#review-select-section-bottom").css('display', 'none');
                            $(reviewBtn).attr('src', currentImg);
                        }
                    }
                    
                </script>
                <div id="review-list-area-wrap-wrap">
	                <div id="review-list-area-wrap">
					<% for(Review r : rList) { %>
						<div class="load-div">
			                <div id="review-list-area" class="flex-class">
			                    <div id="buyer-profile-img">
			                    <% if(r.getTitleImg() == null) { %>
			                        <img src="resources/images/user-icon.png" width="50" height="50">
			                    <% } else { %>
			                    	<img src="<%= contextPath %>/<%= r.getTitleImg() %>" width="50" height="50">
			                    <% } %>
			                    </div>
			                    <div id="review-content">
			                        <div id="review-content-left">
			                            <div class="flex-class" id="review-content-buyer-name">
			                                <div><%= r.getNickName() %></div>
			                            </div>
			                            <div class="flex-class">
			                                <div class="starScoreClass">
			                                    <input type="hidden" class="starInput" value="<%= r.getScore() %>">
			                                    <img src="resources/images/greater than.png" alt="" width="7" height="10">
			                                </div>
			                            </div>
			                            <div class="flex-class">
			                                <div>
			                                    <button type="button" id="product-title-btn">
			                                        <%= r.getProductName() %>&nbsp;&gt;
			                                    </button>
			                                </div>
			                            </div>
			                            <div class="flex-class" id="review-detail-div">
			                                <div><%= r.getReviewDetail() %></div>
			                            </div>
			                            <div class="flex-class review-type-content">
			                            	<% for(ReviewType rt : rtdList) { %>
			                            		<% if(r.getReviewNo() == rt.getReviewNo()) { %>
			                                    	<div class="review-type-detail-div"><%= rt.getReviewTypeDetail() %></div>
		                                    	<% } %>
			                                <% } %>
			                            </div>                         
			                        </div>
			                        <div id="review-content-right">
			                            <div><%= r.getTimeDiff() %></div>
			                            <div class="flex-class" id="reviewImgDiv" style="height:5px;">
			                                <div>
                                                <% if(r.getTitleImg() != null) { %>
			                                        <img src="<%= contextPath %>/<%= r.getTitleImg() %>" id="reviewImg">
                                                <% } else { %>
			                                        <img src="resources/images/no_img.png" id="reviewImg">
                                                <% } %>
			                                </div>    
			                            </div>
			                        </div>
			                    </div>
			                </div>
			        	</div>      
					<% } %>
					</div>
				</div>
                <div id="moreBtn-area">
                    <div id="moreBtn" class="flex-class">
                        <div>
                            <img src="resources/images/moreBtn.png" alt="더보기 아이콘" width="20" height="20" style="opacity: 0.3;">
                        </div>
                        <div id="review-load-btn">받은 후기 더보기</div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    
    	<script>
				$(function(){
					//const starClassActive = "rating__star fas fa-star"; // 텅빈별
	              	//const starClassInactive = "rating__star far fa-star"; // 색칠한별
	              	var starScoreList = document.querySelectorAll(".starScoreClass");
	              	console.log(starScoreList)
					starScoreList.forEach(function(starScoreElement) {
					    console.log($(starScoreElement).children().eq(0).val()); // 내가 저장한 점수
					    var stars = $(starScoreElement).children().eq(0).val();
					    var star = '';
					
					    for (var i = 1; i <= 5; i++) {
					        if (i <= parseInt(stars)) {
					            star += '<span class="rating__star fas fa-star"></span>';
					        } else {
					            star += '<span class="rating__star far fa-star"></span>';
					        }
					    }	
						
					   $(starScoreElement).html(star);
					    
					});
				})
				
				// 페이지를 로드하면 리뷰리스트어리어를 1개만 로드
				$(window).on('load', function () {
					console.log("여기들어오냐?");
					load('#review-list-area-wrap', '2');
					//$($reviewListArea).css("display", "flex");
					
					$("#review-load-btn").on("click", function () {
						load('#review-list-area-wrap', '2', '#review-load-btn');
						
						//$("#review-list-area").css("display", "flex");
						console.log("여기들어온다고?");
					}) 
				});
				
				function load(id, cnt, btn) {
					var reviewList = id + " .load-div:not(.active)";
					var reviewLength = $(reviewList).length;
					var reviewTotalCnt;
					if (cnt < reviewLength) {
						reviewTotalCnt = cnt;
					} else {
						reviewTotalCnt = reviewLength;
						//$(btn).hide();
					}
					$(reviewList + ":lt(" + reviewTotalCnt + ")").addClass("active");
				}
	            
		</script>


	<%@ include file = "../common/footer.jsp" %>

</body>
</html>