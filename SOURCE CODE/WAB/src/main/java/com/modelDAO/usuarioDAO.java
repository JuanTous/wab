/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.modelDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.google.gson.JsonObject;
import com.model.usuario;
import com.setting.conexion;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class usuarioDAO {

    Connection con;
    conexion cn = new conexion();
    PreparedStatement ps;
    ResultSet rs;

    public usuario validarSesion(String user, String pass) {
        usuario usuario = new usuario();
        String sql = "select * from usuario where Email='" + user + "' and Password='" + pass + "'";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                usuario.setIdUsuario(rs.getInt(1));
                usuario.setDni(rs.getInt(2));
                usuario.setNombres(rs.getString(3));
                usuario.setApellidos(rs.getString(4));
                usuario.setDireccion(rs.getString(5));
                usuario.setEmail(rs.getString(6));
                usuario.setPassword(rs.getString(7));
                usuario.setPerfil(rs.getString(8));
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return usuario;
    }

    public boolean registrar(String nombres, String apellidos, String email, String pass, int dni, String direccion, String perfil) {
        boolean validar = false;
        String sql = "select * from usuario where Email='" + email + "'";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                validar = false;
            } else {
                sql = "INSERT INTO `usuario` (`Dni`, `Nombres`, `Apellidos`, `Direccion`, `Email`, `Password`, `Perfil`) VALUES (?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setInt(1, dni);
                ps.setString(2, nombres);
                ps.setString(3, apellidos);
                ps.setString(4, direccion);
                ps.setString(5, email);
                ps.setString(6, pass);
                ps.setString(7, perfil);
                ps.executeUpdate();
                validar = true;
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return validar;
    }

    public JsonObject retornarJSON(usuario usu) {
        JsonObject json = new JsonObject();
        json.addProperty("id", usu.getIdUsuario());
        json.addProperty("nombres", usu.getNombres());
        json.addProperty("apellidos", usu.getApellidos());
        json.addProperty("dni", usu.getDni());
        json.addProperty("email", usu.getEmail());
        json.addProperty("perfil", usu.getPerfil());
        return json;
    }

    // Usuario tipo Emprendedor
    
    public boolean verificarTienda(int id) {
        String sql = "select idUsuario from tiendas where idUsuario='" + id + "'";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return false;
    }
}
