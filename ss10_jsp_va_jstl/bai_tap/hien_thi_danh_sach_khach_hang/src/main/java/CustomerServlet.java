import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CustomerServlet" , urlPatterns = {"/cus"})
public class CustomerServlet extends HttpServlet {




    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customerList = new ArrayList<>();
        customerList.add(new Customer("Mai Văn Hoàn", "1983-08-20", "Hà Nội","https://i.pinimg.com/550x/44/c8/36/44c8362f2015dc8d005f2253a699f76f.jpg"));
        customerList.add(new Customer("Nguyễn Văn Nam", "1983-08-21", " Bắc Giang","https://i.pinimg.com/550x/44/c8/36/44c8362f2015dc8d005f2253a699f76f.jpg"));
        customerList.add(new Customer("Nguyễn Thái Hòa", "1983-08-22", "Nam Định","https://i.pinimg.com/550x/44/c8/36/44c8362f2015dc8d005f2253a699f76f.jpg"));
        customerList.add(new Customer("Trần Đăng Khoa", " 1983-08-17", "На Тау","https://i.pinimg.com/550x/44/c8/36/44c8362f2015dc8d005f2253a699f76f.jpg"));

        request.setAttribute("customerList",customerList);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }
}
