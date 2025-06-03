package isdcm.webapp2.resources;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import jakarta.json.Json;
import jakarta.json.JsonObject;
import java.util.Date;

@Path("login")
public class LoginService {

    private static final String SECRET_KEY = "clavesecretaisdcm2025";

    @POST
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(@FormParam("username") String username, @FormParam("password") String password) {
        if ("admin".equals(username) && "admin".equals(password)) {
            String jwt = Jwts.builder()
                    .setSubject(username)
                    .setIssuedAt(new Date())
                    .setExpiration(new Date(System.currentTimeMillis() + 3600_000)) // 1h
                    .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                    .compact();

            JsonObject json = Json.createObjectBuilder()
                    .add("token", jwt)
                    .build();

            return Response.ok(json.toString(), MediaType.APPLICATION_JSON).build();
        } else {
            return Response.status(Response.Status.UNAUTHORIZED)
                    .entity("Credenciales inválidas").build();
        }
    }
}
