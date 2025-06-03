package controlador;

import modelo.FileEncryptor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet(name = "servletCifrado", urlPatterns = {"/cifrar"})
public class servletCifrado extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreArchivo = request.getParameter("archivo");
        String operacion = request.getParameter("op"); // "cifrar" o "descifrar"
        String basePath = getServletContext().getRealPath("/data/");

        File original = new File(basePath, nombreArchivo);
        File destino = new File(basePath, operacion + "_" + nombreArchivo);

        try {
            System.out.println("Ruta base: " + basePath);
            System.out.println("Archivo original: " + original.getAbsolutePath());
            System.out.println("Archivo destino: " + destino.getAbsolutePath());

            if (!original.exists()) {
                System.out.println("❌ El archivo original no existe.");
                response.getWriter().write("Error: El archivo original no existe.");
                return;
            }

            if (operacion.equals("cifrar")) {
                FileEncryptor.encryptFile(original, destino);
                System.out.println("✅ Archivo cifrado con éxito.");
            } else {
                FileEncryptor.decryptFile(original, destino);
                System.out.println("✅ Archivo descifrado con éxito.");
            }

            String mensaje = "Vídeo " + operacion + "do correctamente.";
            response.sendRedirect("servletListadoVid?msg=" + java.net.URLEncoder.encode(mensaje, "UTF-8"));


        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("Error en cifrado: " + e.getMessage());
        }

    }
}
