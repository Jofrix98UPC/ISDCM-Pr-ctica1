package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "servletListadoVid", urlPatterns = {"/servletListadoVid"})
public class servletListadoVid extends HttpServlet {

    private static final String URL = "jdbc:derby://localhost:1527/pr2";
    private static final String USUARIO = "pr2";
    private static final String PASSWORD = "pr2";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String[]> videos = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement("SELECT ID, TITULO, AUTOR, FECHA_CREACION, DURACION, REPRODUCCIONES, DESCRIPCION, FORMATO, URL FROM VIDEOS");
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String id = rs.getString("ID");
                String titulo = rs.getString("TITULO");
                String autor = rs.getString("AUTOR");
                String fecha = rs.getString("FECHA_CREACION");
                String duracion = rs.getString("DURACION");
                String reproducciones = rs.getString("REPRODUCCIONES");
                String descripcion = rs.getString("DESCRIPCION");
                String formato = rs.getString("FORMATO");
                String url = rs.getString("URL");

                videos.add(new String[]{id, titulo, autor, fecha, duracion, reproducciones, descripcion, formato, url});
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        request.setAttribute("videos", videos);
        request.getRequestDispatcher("listadoVid.jsp").forward(request, response);
    }
}