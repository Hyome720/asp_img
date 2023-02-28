<% 
response.codepage = 949
response.charset = "EUC-KR"
%>
<% 
id = request("id")
pwd = request("pwd")

if id = "admin" and pwd = "1234" then
    session("id") = "admin"
else
    response.write("<script>alert('관리자 로그인에 실패했습니다');history.back();</script>")
end if
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 로그인</title>
</head>
<body>
    <p>로그인 성공!</p>
    <p>관리자는 글들의 비밀번호를 볼 수 잇어용</p>
    <p><a href="list.asp">게시판으로</a></p>
</body>
</html>