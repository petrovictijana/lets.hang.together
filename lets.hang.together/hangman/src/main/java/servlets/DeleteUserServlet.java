package servlets;

import apis.UserModelAPIs;
import data.DbConnection;
import data.DbConnectionJPA;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    private UserModelAPIs apIs = new DbConnectionJPA();
    public DeleteUserServlet(){
        super();
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        apIs.deleteUserById(id);

        resp.sendRedirect("/administrator");
    }
}
