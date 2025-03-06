package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        
        // Recuperar datos del formulario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String correo = request.getParameter("correo");
        String nombreUsuario = request.getParameter("usuario");
        String contrasena = request.getParameter("contrasena");

        // Validar que los campos no estén vacíos
        if (nombre == null || apellidos == null || correo == null || nombreUsuario == null || contrasena == null ||
            nombre.isEmpty() || apellidos.isEmpty() || correo.isEmpty() || nombreUsuario.isEmpty() || contrasena.isEmpty()) {
            
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h1 style='color:red;'>Error: Todos los campos son obligatorios.</h1>");
                response.setHeader("Refresh", "3; URL=registroUsu.jsp"); // Redirige después de 3 segundos
            }
            return;
        }

        try {
            // Cargar el driver de Derby
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD)) {
                // Obtener el ID más alto actual y sumarle 1
                int nuevoId = 1; // Valor por defecto si la tabla está vacía
                String getIdQuery = "SELECT MAX(ID) FROM USUARIOS";

                try (PreparedStatement getIdStmt = conn.prepareStatement(getIdQuery);
                     ResultSet rs = getIdStmt.executeQuery()) {
                    if (rs.next()) {
                        nuevoId = rs.getInt(1) + 1;
                    }
                }

                // Insertar el nuevo usuario con el ID calculado
                String insertQuery = "INSERT INTO USUARIOS (ID, NOMBRE, APELLIDOS, CORREO, NOMBRE_USUARIO, CONTRASENA) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, nuevoId);
                    insertStmt.setString(2, nombre);
                    insertStmt.setString(3, apellidos);
                    insertStmt.setString(4, correo);
                    insertStmt.setString(5, nombreUsuario);
                    insertStmt.setString(6, contrasena);

                    int filasInsertadas = insertStmt.executeUpdate();
                    if (filasInsertadas > 0) {
                        response.sendRedirect("listadoVid.jsp"); // Redirigir a listadoVid.jsp
                    } else {
                        response.setContentType("text/html");
                        try (PrintWriter out = response.getWriter()) {
                            out.println("<h1 style='color:red;'>Error en el registro.</h1>");
                            response.setHeader("Refresh", "3; URL=registroUsu.jsp"); // Redirige después de 3 segundos
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            try (PrintWriter out = response.getWriter()) {
                out.println("<h1 style='color:red;'>Error en la base de datos: " + e.getMessage() + "</h1>");
                response.setHeader("Refresh", "3; URL=registroUsu.jsp"); // Redirige después de 3 segundos
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet de registro de usuario";
    }
}
