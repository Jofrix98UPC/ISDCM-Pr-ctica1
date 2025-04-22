package isdcm.webapp2.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import isdcm.webapp2.Video;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Path("/videos")
public class VideoService {

    private static final String URL = "jdbc:derby://localhost:1527/pr2";
    private static final String USUARIO = "pr2";
    private static final String PASSWORD = "pr2";

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Video> getVideos() {
        List<Video> lista = new ArrayList<>();

        // Usamos try-with-resources para gestionar la conexión y recursos
        try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM VIDEOS");
             ResultSet rs = ps.executeQuery()) {

            // Iterar sobre los resultados
            while (rs.next()) {
                Video v = new Video();
                v.setId(rs.getInt("ID"));
                v.setTitulo(rs.getString("TITULO"));
                v.setFechaCreacion(rs.getDate("FECHA_CREACION"));
                v.setAutor(rs.getString("AUTOR"));
                v.setReproducciones(rs.getInt("REPRODUCCIONES"));
                
                // Manejo del campo DURACION (TIME)
                Time duracionTime = rs.getTime("DURACION");
                if (duracionTime != null) {
                    // Convertir el valor TIME a segundos
                    int duracionSegundos = duracionTime.getHours() * 3600 + duracionTime.getMinutes() * 60 + duracionTime.getSeconds();
                    v.setDuracion(duracionSegundos);  // Guardar duración en segundos
                } else {
                    v.setDuracion(0);  // En caso de que DURACION sea nulo
                }

                v.setDescripcion(rs.getString("DESCRIPCION"));
                v.setFormato(rs.getString("FORMATO"));
                v.setUrl(rs.getString("URL"));

                lista.add(v);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
}
