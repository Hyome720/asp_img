<%
response.codepage = 949
response.charset = "EUC-KR"
%>

<%
if request("page") = "" then
    page = 1
else
    page = request("page")
end if
' 넘어온 값 변수에 할당 / 속도 향상
search = request("search")
searchString = request("searchString")

set db = Server.CreateObject("ADODB.Connection")
db.Open("DSN=localsqldb;UID=sa;PWD=1234;")

sql = "SELECT * FROM MyBoard WHERE " & search & " LIKE '%" & searchString & "%' ORDER BY num DESC"
'sql = "SELECT * from MyBoard ORDER BY num DESC"

set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, db, 1
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=searchString%>의 검색결과</title>
</head>
<body>
    <% if rs.BOF or rs.EOF then %>
    <p>
        <%=searchString%>에 대한 검색 결과가 없습니다.
    </p>
    <% else
    ' 총 레코드의 숫자
    rs.MoveLast
    ' 총 레코드의 수를 변수에 저장
    recordCnt = rs.RecordCount
    ' 다시 레코드를 원위치
    rs.MoveFirst
    %>
    <div>
        <p>
            <%=searchString%>로 검색한 결과 <%=recordCnt%>개의 데이터를 검색했습니다.
        </p>
        <table class="list-table">
            <tr>
                <td class="list-td-01">
                    번호
                </td>
                <td class="list-td-02">
                    글쓴이
                </td>
                <td class="list-td-02">
                    날짜
                </td>
                <td class="list-td-04">
                    제목
                </td>
                <td class="list-td-01">
                    조회수
                </td>
            </tr>
            <% i = 1
            Do Until rs.EOF %>
            <tr>
                <td class="list-td-01" style="color: black !important; background-color: #fff !important;">
                    <%=rs("num")%></td>
                <td class="list-td-02" style="color: black !important; background-color: #fff !important;">
                    <a href="mailto:<%=rs("email")%>">
                        <%=rs("name")%>
                    </a>
                </td>
                <td class="list-td-02" style="color: black !important; background-color: #fff !important;"><%=rs("writeday")%></td>
                <td class="list-td-04" style="color: black !important; background-color: #fff !important;">
                    <a href="content.asp?idx=<%=rs("board_idx")%>">
                        <%=rs("title")%>
                    </a>
                </td>
                <td class="list-td-01" style="color: black !important; background-color: #fff !important;"><%=rs("readnum")%></td>
            </tr>
            <%
            ' 다음 레코드로 이동
            rs.MoveNext 
            ' 레코드 끝까지 Loop 돌기
            loop 
            %>
            <% end if %>
        </table>
        <hr>
    </div>  
</body>
</html>