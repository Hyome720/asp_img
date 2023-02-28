<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
Set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

updateSql = "UPDATE Board_Re SET readnum = readnum + 1"
updateSql = updateSql & " WHERE board_idx = " & request("idx")

db.execute(updateSql)

Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM Board_Re WHERE board_idx=" & request("idx")

rs.Open sql, db, 1, 1

board_idx = rs("board_idx")
ref = rs("ref")
re_level = rs("re_level")
re_step = rs("re_step")
board_content = replace(rs("board_content"), chr(13) & chr(10), "<br>")

rs.Close

sql = "SELECT * FROM Board_Re"
sql = sql & " WHERE ref = " & ref & " ORDER BY ref DESC, re_step ASC"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db
%>

<!DOCTYPE html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=rs("title")%> ����</title>
    <link rel="stylesheet" href="./css/content.css">
</head>
<body>
    <script>
        function sendRe() {
            document.re.submit()
        }
    </script>
    <div style="margin: auto;">
        <h2><%=rs("title")%> ����</h2>
        <div>
            <div>
                <table class="content-table">
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">�۾���</p>
                        </td>
                        <td class="td-100 td-right">
                            <p><%=rs("name")%></p>
                        </td>
                        <td class="td-100 td-left">
                            <p class="td-text">��¥</p>
                        </td>
                        <td class="td-100 td-right">
                            <p><%=rs("writeday")%></p>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">�̸���</p>
                        </td>
                        <td class="td-180 td-right">
                            <a href="mailto:<%=rs("email")%>"><%=rs("email")%></a>
                        </td>
                        <td class="td-100 td-left">
                            <p class="td-text">Ȩ������</p>
                        </td>
                        <td class="td-180 td-right">
                            <a href="<%=rs("homepage")%>">
                                <%=rs("name")%>���� Ȩ������
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td class="td-100 td-left">
                            <p class="td-text">��ȸ�� : </p>
                        </td>
                        <td>
                            <p><%=rs("readnum")%></p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p>���� : </p>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p><%=rs("board_content")%></p>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <p>
            <a href="javascript:sendRe()">
                &lt;�亯�ϱ�&gt;
            </a>
        </p>
        <p>
            <a href="list.asp">
                &lt;����Ʈ�� ���ư���&gt;
            </a>
        </p>
        <p>
            <a href="edit.asp?idx=<%=rs("board_idx")%>">
                &lt;����&gt;
            </a>
        </p>
        <p>
            <a href="del.asp?idx=<%=rs("board_idx")%>">
                &lt;����&gt;
            </a>
        </p>
        <% if session("id") = "admin" then%>
        <p>������� ��й�ȣ : <%=rs("pwd")%></p>
        <% end if %>
    </div>
    <form name="re" method="post" action="./write.asp">
        <input type="hidden" name="board_idx" value="<%=board_idx%>">
        <input type="hidden" name="ref" value="<%=ref%>">
        <input type="hidden" name="re_step" value="<%=re_step%>">
        <input type="hidden" name="re_level" value="<%=re_level%>">
    </form>

    <%
    if rs.BOF or rs.EOF then
    else
    %>
    <hr>
    <div>
        <table width="100%">
            <tr>
                <td>
                    <p>�� ��</p>
                </td>
                <td>
                    <p>�۾���</p>
                </td>
                <td>
                    <p>��¥</p>
                </td>
                <td>
                    <p>��ȸ��</p>
                </td>
            </tr>
            <%
            Do Until rs.EOF

            name = rs("name")
            title = rs("title")
            wdate = left(rs("writeday"), 10)
            %>
            <tr>
                <td>
                <% 
                        if rs("re_level") > 0 then
                        wid = 5 * rs("re_level") & px
                        %>
                        <img src="../img/white.png" width="<%=wid%>" height="14px">
                        <img src="../img/answer.png">
                        <% end if %>
                    <a href="content.asp?id=<%=rs("board_idx")%>">
                        <%=title%>
                    </a>
                </td>
                <td>
                    <p><%=name%></p>
                </td>
                <td>
                    <p><%=wdate%></p>
                </td>
                <td>
                    <p><%=rs("readnum")%></p>
                </td>
            </tr>
            <%
                rs.MoveNext
                Loop
            %>
            <% end if %>
        </table>
    </div>
</body>
</html>