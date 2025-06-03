package controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.video;

@WebServlet(name = "servletListadoVid", urlPatterns = {"/servletListadoVid"})
public class servletListadoVid extends HttpServlet {

    private static final String URL = "jdbc:derby://localhost:1527/pr2";
    private static final String USUARIO = "pr2";
    private static final String PASSWORD = "pr2";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        ArrayList<video> videos = new ArrayList<>();
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection con = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            Statement st = con.createStatement();
            String query = "SELECT id, titulo, autor, fecha_creacion, duracion, reproducciones, descripcion, ruta_archivo FROM videos";
            ResultSet rs = st.executeQuery(query);

            while (rs.next()) {
                int id = rs.getInt("id");
                String titulo = rs.getString("titulo");
                String autor = rs.getString("autor");
                String fecha = rs.getString("fecha_creacion");
                Time tiempoDuracion = rs.getTime("duracion");
                int duracion = tiempoDuracion.toLocalTime().toSecondOfDay(); // <-- conversión correcta
                int reproducciones = rs.getInt("reproducciones");
                String descripcion = rs.getString("descripcion");
                String rutaArchivo = rs.getString("ruta_archivo");

                video v = new video(id, titulo, autor, fecha, duracion, reproducciones, descripcion, rutaArchivo);
                videos.add(v);
            }

            rs.close();
            st.close();
            con.close();

            request.setAttribute("videos", videos);
            request.getRequestDispatcher("listadoVid.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error en servletListadoVid: " + e.getMessage());
        }
    }
}
