package modelo;

public class video {
    private int id;
    private String titulo;
    private String autor;
    private String fecha;
    private int duracion;
    private int reproducciones;
    private String descripcion;
    private String rutaArchivo;

    public video(int id, String titulo, String autor, String fecha, int duracion, int reproducciones, String descripcion, String rutaArchivo) {
        this.id = id;
        this.titulo = titulo;
        this.autor = autor;
        this.fecha = fecha;
        this.duracion = duracion;
        this.reproducciones = reproducciones;
        this.descripcion = descripcion;
        this.rutaArchivo = rutaArchivo;
    }

    public int getId() { return id; }
    public String getTitulo() { return titulo; }
    public String getAutor() { return autor; }
    public String getFecha() { return fecha; }
    public int getDuracion() { return duracion; }
    public int getReproducciones() { return reproducciones; }
    public String getDescripcion() { return descripcion; }
    public String getRutaArchivo() { return rutaArchivo; }

    public void setId(int id) { this.id = id; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public void setAutor(String autor) { this.autor = autor; }
    public void setFecha(String fecha) { this.fecha = fecha; }
    public void setDuracion(int duracion) { this.duracion = duracion; }
    public void setReproducciones(int reproducciones) { this.reproducciones = reproducciones; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public void setRutaArchivo(String rutaArchivo) { this.rutaArchivo = rutaArchivo; }
}
