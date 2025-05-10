package isdcm.webapp2.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.QueryParam;
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
    
    // Método para obtener videos por título
    @GET
    @Path("/buscar/titulo")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Video> buscarPorTitulo(@QueryParam("titulo") String titulo) {
        return buscarVideos("TITULO", titulo);
    }

    // Método para obtener videos por autor
    @GET
    @Path("/buscar/autor")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Video> buscarPorAutor(@QueryParam("autor") String autor) {
        return buscarVideos("AUTOR", autor);
    }

    // Método para obtener videos por fecha de creación
    @GET
    @Path("/buscar/fecha")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Video> buscarPorFecha(@QueryParam("fecha") String fecha) {
        return buscarVideos("FECHA_CREACION", fecha);
    }

    // Método auxiliar para buscar videos
    private List<Video> buscarVideos(String campo, String valor) {
        List<Video> lista = new ArrayList<>();
        String query = "";
        if(campo.equals("FECHA_CREACION")) {
            query = "SELECT * FROM VIDEOS WHERE " + campo + " = ?";  // Utilizar un parámetro con "?"

            try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
                 PreparedStatement ps = conn.prepareStatement(query)) {

                // Asegúrate de que el valor de "valor" esté en formato 'yyyy-MM-dd'
                // Convertir el String a un objeto java.sql.Date
                Date fecha = Date.valueOf(valor);  // Convierte la fecha en String a java.sql.Date
                ps.setDate(1, fecha);  // Establece el parámetro como un Date

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    // Procesar los resultados
                    Video v = new Video();
                    v.setId(rs.getInt("ID"));
                    v.setTitulo(rs.getString("TITULO"));
                    v.setFechaCreacion(rs.getDate("FECHA_CREACION"));
                    v.setAutor(rs.getString("AUTOR"));
                    v.setReproducciones(rs.getInt("REPRODUCCIONES"));
                    v.setDescripcion(rs.getString("DESCRIPCION"));
                    v.setUrl(rs.getString("URL"));
                    lista.add(v);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            // Para otros campos que no sean de tipo fecha, usar LIKE
            query = "SELECT * FROM VIDEOS WHERE " + campo + " LIKE ?";
            
        }
        

        try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, "%" + valor + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Video v = new Video();
                v.setId(rs.getInt("ID"));
                v.setTitulo(rs.getString("TITULO"));
                v.setAutor(rs.getString("AUTOR"));
                v.setFechaCreacion(rs.getDate("FECHA_CREACION"));
                v.setReproducciones(rs.getInt("REPRODUCCIONES"));
                v.setDescripcion(rs.getString("DESCRIPCION"));
                v.setUrl(rs.getString("URL"));
                lista.add(v);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
    
    @PUT
    @Path("/{id}/reproduccion")
    @Consumes(MediaType.APPLICATION_JSON)
    public void incrementarReproducciones(@PathParam("id") int id) {
        
        try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE VIDEOS SET REPRODUCCIONES = REPRODUCCIONES + 1 WHERE ID = ?")) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private String convertirSegundosATiempo(int segundos) {
        int horas = segundos / 3600;
        int minutos = (segundos % 3600) / 60;
        int segundosRestantes = segundos % 60;
        return String.format("%02d:%02d:%02d", horas, minutos, segundosRestantes);
    }
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public String registrarVideo(Video video) {
        String resultado = "Registro fallido";

        try (Connection conn = DriverManager.getConnection(URL, USUARIO, PASSWORD)) {
            // Obtener el nuevo ID
            int nuevoId = 1;
            try (PreparedStatement stmt = conn.prepareStatement("SELECT MAX(ID) FROM VIDEOS");
                 ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    nuevoId = rs.getInt(1) + 1;
                }
            }

            // Formatear duración a TIME si lo necesitas, o a String "HH:MM:SS"
            String duracionFormato = convertirSegundosATiempo(video.getDuracion());

            String sql = "INSERT INTO VIDEOS (ID, TITULO, AUTOR, FECHA_CREACION, DURACION, REPRODUCCIONES, DESCRIPCION, FORMATO, URL) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, nuevoId);
                ps.setString(2, video.getTitulo());
                ps.setString(3, video.getAutor());
                ps.setDate(4, video.getFechaCreacion());
                ps.setString(5, duracionFormato); // Si tu columna es de tipo VARCHAR
                ps.setInt(6, 0); // Reproducciones iniciales
                ps.setString(7, video.getDescripcion());
                ps.setString(8, video.getFormato());
                ps.setString(9, video.getUrl());

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    resultado = "Video registrado con éxito";
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            resultado = "Error en la base de datos: " + e.getMessage();
        }

        return resultado;
    }
    
    
}
