/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package isdcm.webapp2.resources;

/**
 *
 * @author alumne
 */
import jakarta.ws.rs.ApplicationPath;
import jakarta.ws.rs.core.Application;
import java.util.Set;
import java.util.HashSet;
import isdcm.webapp2.resources.LoginService;   // ← solo si es clase separada
import isdcm.webapp2.resources.VideoService;


@ApplicationPath("api")
public class RestApplication extends Application {
    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> classes = new HashSet<>();
        classes.add(LoginService.class); // AÑADIR ESTA LÍNEA
        classes.add(VideoService.class); // ya debe estar
        return classes;
    }
}

