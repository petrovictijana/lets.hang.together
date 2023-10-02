package servlets;

import apis.UserModelAPIs;
import data.DbConnectionJPA;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.UserModel;

import java.io.IOException;

@WebServlet(name = "login", value="/login")
public class LoginServlet extends HttpServlet {
    private UserModelAPIs apIs = new DbConnectionJPA();
    public LoginServlet(){
        super();
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        UserModel user = apIs.checkUserForLogin(username, password);
        HttpSession session = req.getSession(true);
        if(user == null) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.sendRedirect("/sign_in");
            session.setAttribute("unauthorized", true);
        }
        else{
            session.setAttribute("user", user);
            if(session.getAttribute("unauthorized") != null){
                session.removeAttribute("unauthorized");
            }

            if(user.getRole_id() == 1)
                resp.sendRedirect("/administrator");
            else
                resp.sendRedirect("/lobby");
        }
    }
}
