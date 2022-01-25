import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DiscountCalculatorServlet" , urlPatterns = "/calculator")
public class DiscountCalculatorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        float value = Float.parseFloat(request.getParameter("listPrice"));

        float discountPercent = Float.parseFloat(request.getParameter("discountPercent"));

        double discountAmount = value * discountPercent * 0.01;
        double discountPrice = value - discountAmount;

        PrintWriter printWriter = response.getWriter();

        printWriter.println("<html>");
        printWriter.println("<h1>list price: " + value + "</h1>");
        printWriter.println("<h1>discountPercent: " + discountPercent + "</h1>");
        printWriter.println("<h1>discountAmount: " + discountAmount + "</h1>");
        printWriter.println("<h1>discountPrice : " + discountPrice  + "</h1>");
        printWriter.println("</html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
