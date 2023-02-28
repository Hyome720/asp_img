<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h2>나의 사이트</h2>
    <ul>
        <li>사이트 소개</li>
        <li><a href="board/board.asp">게시판</a></li>
        <li>자료실</li>

        <% if session("id") = "" then %>
        <li><a href="member/login.asp">로그인하기</a></li>
        <% else %>
        <li><a href="member/mem_edit.asp">개인정보수정</a></li>
        <li><a href="member/mem_del.asp">회원탈퇴</a></li>
        <% end if %>
    </ul>
</body>
</html>