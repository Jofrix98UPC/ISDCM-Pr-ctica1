package controlador;

import modelo.XMLProtect;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet(name = "servletXML", urlPatterns = {"/protegerXML"})
public class servletXML extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String operacion = request.getParameter("op"); // "cifrar" o "descifrar"
        String basePath = getServletContext().getRealPath("/xml/");
        String input = basePath + (operacion.equals("cifrar") ? "/didlFilm1.xml" : "/cifrar_didlFilm1.xml");
        String output = basePath + "/" + operacion + "_didlFilm1.xml";

        String key = basePath + "/claveAES.key";

        try {
            if ("cifrar".equals(operacion)) {
                XMLProtect.encryptXML(input, output, key);
            } else {
                XMLProtect.decryptXML(input, output, key);
            }
            response.sendRedirect("listadoVid.jsp?msg=XML " + operacion + "ado correctamente.");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error procesando XML: " + e.getMessage());
        }
    }
}
