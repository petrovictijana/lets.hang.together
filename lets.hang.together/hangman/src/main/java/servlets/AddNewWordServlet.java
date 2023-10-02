package servlets;

import apis.WordModelAPIs;
import data.DbConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.WordModel;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/addNewWordServlet")
public class AddNewWordServlet extends HttpServlet {
    private WordModelAPIs apIs;

    public AddNewWordServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        super.init();
        apIs = DbConnection.get_dbConnection();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        WordModel wordModel = new WordModel();
        wordModel.setWord(req.getParameter("word"));
        wordModel.setLevel(Integer.parseInt(req.getParameter("level")));

        resp.setContentType("text/html");
        PrintWriter printWriter = resp.getWriter();

        boolean wordExists = apIs.isWordAlreadyExist(wordModel.getWord());
        HttpSession httpSession = req.getSession();
        if(wordExists){
            resp.sendRedirect("/administrator");
            httpSession.setAttribute("wordExists", true);
        }
        else{
            WordModel word = apIs.addNewWord(wordModel);
            if(word != null){
                resp.sendRedirect("/administrator");
                httpSession.setAttribute("wordAdded", true);
            }
            else{
                resp.sendRedirect("/administrator");
                httpSession.setAttribute("wordNotAdded", false);
            }
        }
    }
}
