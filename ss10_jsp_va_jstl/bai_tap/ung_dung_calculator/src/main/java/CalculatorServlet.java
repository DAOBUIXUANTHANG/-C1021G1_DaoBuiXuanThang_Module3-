import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CalculatorServlet" , urlPatterns = {"/calculator"})
public class CalculatorServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        double fistOperand = Double.parseDouble(request.getParameter("fistOperand"));
        double sencondOperand = Double.parseDouble(request.getParameter("sencondOperand"));
        char operator = request.getParameter("operator").charAt(0);

        try {
            double reust = Calculator.calculated(fistOperand, sencondOperand, operator);

            request.setAttribute("reust",reust);
            request.setAttribute("fistOperand",fistOperand);
            request.setAttribute("sencondOperand",sencondOperand);
            request.setAttribute("operator",operator);

            request.getRequestDispatcher("index.jsp").forward(request,response);
        } catch (Exception exception){
            exception.printStackTrace();
        }
    }
}
