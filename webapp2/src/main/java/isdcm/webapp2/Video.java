/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package isdcm.webapp2;

/**
 *
 * @author alumne
 */
import java.sql.Date;

public class Video {
    private int id;
    private String titulo;
    private Date fechaCreacion;
    private String autor;
    private int reproducciones;
    private int duracion;
    private String descripcion;
    private String formato;
    private String url;

    // Getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public Date getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(Date fechaCreacion) { this.fechaCreacion = fechaCreacion; }

    public String getAutor() { return autor; }
    public void setAutor(String autor) { this.autor = autor; }

    public int getReproducciones() { return reproducciones; }
    public void setReproducciones(int reproducciones) { this.reproducciones = reproducciones; }

    public int getDuracion() { return duracion; }
    public void setDuracion(int duracion) { this.duracion = duracion; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getFormato() { return formato; }
    public void setFormato(String formato) { this.formato = formato; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
}
