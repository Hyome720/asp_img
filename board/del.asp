<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><=%request("title") 삭제하기></title>
</head>
<body>
    <p>
        <br>
        <form method="post" action="del_ok.asp">
            <div>
                <tr>
                    <td>
                        <p>삭제하기</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>비밀번호를 입력해주세요</p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" name="idx" value="<%=request("idx")%>">
                        <p>비밀번호 : &nbsp;
                            <input type="password" name="pwd">
                        </p>
                    </td>
                </tr>
            </div>
            <div>
                <input type="submit" value="삭제">
                &nbsp;
                &nbsp;
                <span>
                    <a href="content.asp?idx=<%=request("idx")%>">돌아가기</a>
                </span>
            </div>
        </form>
    </p>
</body>
</html>