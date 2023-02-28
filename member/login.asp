<%
NewMember = request("NewMember")
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div>
        <div>
            <p>로그인</p>
        </div>
        <div>
            <form method="post" action="login_ok.asp">
                <div>
                    <table>
                        <tr>
                            <td>
                                <span>ID :</span>
                                <input type="text" name="mem_id" value="<%=NewMember%>">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>비밀번호 :</span>
                                <input type="password" name="mem_pwd">
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <input type="submit" value="로그인">
                </div>
            </form>
            <p>
                <span>아직 아이디가 없으신가요?</span>
                <a href=register.html>회원가입 하러가기</a>
            </p>
        </div>
    </div>
</body>
</html>