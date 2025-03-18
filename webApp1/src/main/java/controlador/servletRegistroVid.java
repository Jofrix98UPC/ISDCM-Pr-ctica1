package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.sql.Date; // Importar java.sql.Date para la compatibilidad con la base de datos
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "servletRegistroVid", urlPatterns = {"/servletRegistroVid"})
public class servletRegistroVid extends HttpServlet {

    private static final String URL = "jdbc:derby://localhost:1527/pr2";
    private static final String USUARIO = "pr2";
    private static final String PASSWORD = "pr2";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Recoger los datos del formulario
        String titulo = request.getParameter("titulo");
        String autor =  request.getParameter("autor");
        String fechaCreacion = LocalDate.now().toString(); // Fecha actual (YYYY-MM-DD)
        int duracion = 0; 
        int reproducciones = 0;
        String descripcion = request.getParameter("descripcion");
        String formato = "MP4"; // Y este
        String url = "http://localhost:8080/videos/" + titulo;

        // Validar que el título no esté vacío
        if (titulo == null || titulo.isEmpty()) {
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h1 style='color:red;'>Error: El título es obligatorio.</h1>");
                response.setHeader("Refresh", "3; URL=registroVid.jsp"); // Redirige después de 3 segundos
            }
            return;
        }

        try {
            // Cargar el driver de Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD)) {
                // Obtener el ID más alto actual y sumarle 1
                int nuevoId = 1; // Valor por defecto si la tabla está vacía
                String getIdQuery = "SELECT MAX(ID) FROM VIDEOS";

                try (PreparedStatement getIdStmt = conn.prepareStatement(getIdQuery);
                     ResultSet rs = getIdStmt.executeQuery()) {
                    if (rs.next()) {
                        nuevoId = rs.getInt(1) + 1;
                    }
                }

                // Convertir la duración de segundos a formato HH:MM:SS
                String duracionFormato = convertirSegundosATiempo(duracion); // "00:02:00"

                // Insertar el nuevo video con los datos proporcionados
                String insertQuery = "INSERT INTO VIDEOS (ID, TITULO, AUTOR, FECHA_CREACION, DURACION, REPRODUCCIONES, DESCRIPCION, FORMATO, URL) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, nuevoId);
                    insertStmt.setString(2, titulo); // Aquí se usa el título recibido del formulario
                    insertStmt.setString(3, autor);
                    insertStmt.setDate(4, Date.valueOf(fechaCreacion)); // Usar la fecha actual para la base de datos
                    insertStmt.setString(5, duracionFormato); // Usamos el formato de duración
                    insertStmt.setInt(6, reproducciones);
                    insertStmt.setString(7, descripcion);
                    insertStmt.setString(8, formato);
                    insertStmt.setString(9, url);

                    int filasInsertadas = insertStmt.executeUpdate();
                    if (filasInsertadas > 0) {
                        response.sendRedirect("listadoVid.jsp"); // Redirigir a listadoVid.jsp
                    } else {
                        response.setContentType("text/html");
                        try (PrintWriter out = response.getWriter()) {
                            out.println("<h1 style='color:red;'>Error en el registro del video.</h1>");
                            response.setHeader("Refresh", "3; URL=registroVid.jsp"); // Redirige después de 3 segundos
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h1 style='color:red;'>Error en la base de datos: " + e.getMessage() + "</h1>");
                response.setHeader("Refresh", "3; URL=registroVid.jsp"); // Redirige después de 3 segundos
            }
        }
    }

    // Método para convertir segundos a formato HH:MM:SS
    private String convertirSegundosATiempo(int segundos) {
        int horas = segundos / 3600;
        int minutos = (segundos % 3600) / 60;
        int segundosRestantes = segundos % 60;
        
        // Formatear como HH:MM:SS
        return String.format("%02d:%02d:%02d", horas, minutos, segundosRestantes);
    }

    @Override
    public String getServletInfo() {
        return "Servlet de registro de video";
    }
}
