<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 25/01/2022
  Time: 11:08 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>

  <form method="post" action="/calculator">
    <label>Product Destription</label>
    <br>
    <input type="text" placeholder="Product Destription" name="productDestription">
    <br>
    <label>List Price</label>
    <br>
    <input type="text" placeholder="List Price" name="listPrice">
    <br>
    <label>Discount Percent</label>
    <br>
    <input type="text" placeholder="Discount Percent" name="discountPercent">
    <input type="submit" value="/calculated" id="submit">
  </form>
  $END$
  </body>
</html>
