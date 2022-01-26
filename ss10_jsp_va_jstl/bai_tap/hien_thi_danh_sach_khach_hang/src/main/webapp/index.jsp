<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 26/01/2022
  Time: 11:09 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>$Title$</title>
    <style>
      table{
        border-collapse: collapse;
        border: 1px solid black;
        margin: 20px auto;
        box-shadow: 5px 5px 5px 5px skyblue;
      }

      tr, td {
        padding: 5px;
        border: 1px solid black;
      }

    </style>
  </head>
  <body>
  <h1 style="text-align: center; margin: 0 auto">Danh sach khach Hang</h1>
  <table>
       <tr>
         <td>tên</td>
         <td>Ngày sinh</td>
         <td>Địa chỉ</td>
         <td>Ảnh</td>
       </tr>
    <c:forEach var="customerList" items="${customerList}">
      <tr>
        <td><c:out value="${customerList.name}"/></td>
        <td><c:out value="${customerList.birthday}"/></td>
        <td><c:out value="${customerList.address}"/></td>
        <td>
          <div>
            <img src="<c:out value="${customerList.urlPicture}"/>" alt="anh" width="50" height="50">
          </div>
        </td>
      </tr>
    </c:forEach>
  </table>
  </body>
</html>
