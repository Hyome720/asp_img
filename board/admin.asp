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
            <p>관리자 로그인</p>
        </div>
        <div>
            <form method="post" action="admin_ok.asp">
                <div>
                    <table>
                        <tr>
                            <td>
                                <span>관리자 ID :</span>
                                <input type="text" name="id">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>비밀번호 :</span>
                                <input type="password" name="pwd">
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <input type="submit" value="로그인">
                </div>
            </form>
        </div>
    </div>
</body>
</html>