<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>;
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <h1>Simple calculator</h1>
  <form action="/calculator" method="get">
    <fieldset>
      <legend>tinh toan</legend>
      <table>
        <tr>
          <td>fist operand</td>
          <td><input type="text" name="fistOperand"></td>
        </tr>

        <tr>
          <td>operator</td>
          <td>
            <select name="operator">
              <option value="+">Addition</option>
              <option value="-">Subtraction</option>
              <option value="*">Multiplication</option>
              <option value="/">Division</option>
            </select>
          </td>
        </tr>


        <tr>
          <td>sencond operand</td>
          <td><input type="text" name="sencondOperand"></td>
        </tr>

        <tr>
          <td>

          </td>

          <td>
            <input type="submit" value="Calculate">
          </td>
        </tr>
      </table>


    </fieldset>
  </form>


  <h3 style="background: aqua"> <c:out value="${fistOperand}"/>  <c:out value="${operator}"/>   <c:out value="${sencondOperand}"/> = <c:out value="${reust}"/> </h3>
  </body>
</html>
