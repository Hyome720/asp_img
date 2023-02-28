<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb; UID=sa; PWD=1234;")

sql = "SELECT * FROM Board_Re WHERE board_idx=" & request("idx")

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db
%>

<!DOCTYPE html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/link.css">
    <title>수정하기</title>
</head>
<body>
    <script>
        function sendIt() {
            // 이름
            if (document.myform.name.value == "") {
                alert("이름을 입력해주세요 제발ㄹㄹ..")
                return false
            }
            
            // 제목
            if (document.myform.title.value == "") {
                alert("제목을 입력해주세요 젭라ㄹ..")
                return false
            }
    
            // 내용
            if (document.myform.board_content.value == "") {
                alert("내용이 하나도 없네요.. 내용 좀 적어주세요..")
                return false
            }
    
            // 비밀번호
            if (document.myform.pwd.value == "") {
                alert("수정, 삭제시 비밀번호가 필요한데 없어요. 입력해주세요..")
                return false
            }

            document.myform.submit()
        }
    </script>
    <div style="align-items:left">
        <table cellpadding="0" cellspacing="0" style="border:0; width: 700;">
            <tr>
                <td>
                    <form name="myform" method="post" action="edit_ok.asp">
                        <div style="text-align: center;">
                            <table cellpadding="0" cellspacing="0" style="border: 1px dashed rgb(192, 192, 192); width: 540;">
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            <img src="https://img.freepik.com/free-vector/illustration-of-document-icon_53876-37007.jpg?w=1380&t=st=1677052922~exp=1677053522~hmac=5f8645b7a869e81c30d37d18ee7ea86d6ac8fbed6e250759cf90abe5ae812e86" width="40px">
                                        </strong>
                                    </td>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            글 수정하기
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            글쓴이
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <input type="hidden" name="board_idx" value="<%=rs("board_idx")%>">
                                        <input type="text" name="name" size="20" style="border: 1 dashed;" value="<%=rs("name")%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            이메일
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <input type="text" name="email" size="20" style="border: 1 dashed;" value="<%=rs("email")%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            홈페이지
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <strong class="write-text-strong">
                                            <input type="text" name="homepage" size="20" style="border: 1 dashed;" value="<%=rs("homepage")%>">
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            제목
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <input type="text" name="title" size="20" style="border: 1 dashed;" value="<%=rs("title")%>">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            내용
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <textarea wrap="hard" rows="10" name="board_content" cols="55" style="border: 1 dashed;"><%=rs("board_content")%>
                                        </textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="write-td-left">
                                        <strong class="write-text-strong">
                                            비밀번호
                                        </strong>
                                    </td>
                                    <td class="write-td-right">
                                        <input type="password" name="pwd" size="20" style="border: 1 dashed;">
                                        &nbsp;
                                        (수정과 삭제시 필요)
                                    </td>
                                </tr>
                            </table>
                            <p>
                                <input type="button" value="작성 완료" onclick="sendIt()">
                                &nbsp;
                                <input type="reset" value="재작성하기" name="reset">
                            </p>
                        </div>
                    </form>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>