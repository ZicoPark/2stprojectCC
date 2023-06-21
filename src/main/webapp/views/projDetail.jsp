<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
.comment {
  display: flex;
  align-items: center;
}

.comment video {
  width: 200px;
  height: auto;
  margin-right: 10px;
}

#videoPlayer {
  width: 400px;
  height: 300px;
  overflow: hidden;
}

#videoPlayer video {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>
</head>
<body>
	<form action="projWrite.do" method="POST" enctype="multipart/form-data">
		<button type="button" id="addComment">추가</button>
		<div class="contents" id="commentContent"></div>
	</form>
	<div id="videoPlayer"></div>
	<script>
		var y = 1; // 초기 값 설정

		$(document).on('click', '#addComment', function(){
			var html = '<div class="comment">'
				+ '<select name="comment_status' + y + '">'
				+ '<option value="기획">기획</option>'
				+ '<option value="촬영">촬영</option>'
				+ '<option value="편집">편집</option>'
				+ '<option value="검토">검토</option>'
				+ '<option value="배포">배포</option>'
				+ '</select>'
				+ '<select name="comment_step' + y + '">'
				+ '<option value="준비중">준비중</option>'
				+ '<option value="진행중">진행중</option>'
				+ '<option value="완료">완료</option>'
				+ '</select>'
				+ y + ' <input type="text" name="comment_content' + y + '">'
				+ '<input type="file" name="video' + y + '" accept="video/*">'
				+ '<div class="videoPlayer"></div>'
				+ '</div>';

			$('#commentContent').prepend(html);
			y++;
		});

		$(document).on('change', 'input[type="file"]', function(e) {
			var file = e.target.files[0];
			var videoPlayer = $(this).siblings('.videoPlayer')[0];

			var reader = new FileReader();
			reader.onload = function(event) {
				var videoSrc = event.target.result;
				videoPlayer.innerHTML = '<video controls><source src="' + videoSrc + '" type="video/mp4"></video>';
			};
			reader.readAsDataURL(file);
		});
	</script>
</body>
</html>
