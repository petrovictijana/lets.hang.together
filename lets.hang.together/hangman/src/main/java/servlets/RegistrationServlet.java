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

@WebServlet(name = "registration", value = "/registration")
public class RegistrationServlet extends HttpServlet {
    private UserModelAPIs apIs = new DbConnectionJPA();
    public RegistrationServlet(){
        super();
    }

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String surname = req.getParameter("surname");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        boolean isUsernameTaken = apIs.isUsernameTaken(username);
        HttpSession session = req.getSession(true);

        if(isUsernameTaken == true){
            session.setAttribute("taken", true);
            resp.sendRedirect("/registration_form");
        }
        else{
            UserModel user = new UserModel();

            user.setName(name);
            user.setSurname(surname);
            user.setUsername(username);
            user.setPassword(password);
            user.setLevel(1);
            user.setScore(0);
            user.setRole_id(2);
            user.setBlocked(false);

            boolean newUser = apIs.createUser(user);

            if(!newUser){
                session.setAttribute("500", true);
                resp.sendRedirect("/registration_form");
            }
            else{
                session.setAttribute("user", user);
                resp.sendRedirect("/lobby");
            }

        }

    }
}
