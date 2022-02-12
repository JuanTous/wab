/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.modelDAO;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.model.tienda;
import com.model.usuario;
import com.model.ventas;
import com.setting.conexion;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class tiendaDAO {

    Connection con;
    conexion cn = new conexion();
    PreparedStatement ps;
    ResultSet rs;

    public void crearTienda(tienda t) {
        String sql = "insert into tiendas(idUsuario,NIT,nombreTienda,Logo,Ubicacion,Vigencia)values(?,?,?,?,?,?)";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, t.getIdUsuario());
            ps.setString(2, t.getNit());
            ps.setString(3, t.getNombre());
            ps.setBlob(4, t.getLogo());
            ps.setString(5, t.getUbicacion());
            ps.setString(6, t.getVigencia());
            ps.executeUpdate();

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error= " + e.getMessage());
        }
    }

    public tienda retornarTienda(int id) {
        tienda tienda = new tienda();
        String sql = "select * from tiendas where idUsuario=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                tienda.setIdTienda(rs.getInt(1));
                tienda.setIdUsuario(rs.getInt(2));
                tienda.setNit(rs.getString(3));
                tienda.setNombre(rs.getString(4));
                tienda.setLogo(rs.getBinaryStream(5));
                tienda.setUbicacion(rs.getString(6));
                tienda.setVigencia(rs.getString(7));
            }

        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }

        return tienda;
    }

    public List<ventas> misVentas(int id) {
        List<ventas> misVentas = new ArrayList<>();
        String sql = "select idVenta, idUsuario, NombreProducto from ventas where idTienda=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                usuario u = new usuario();
                ventas v = new ventas();
                int idV = rs.getInt(1);
                int idUsu = rs.getInt(2);
                String nombrePro = rs.getString(3);

                sql = "select idUsuario, Nombres, Apellidos from usuario where idUsuario=" + idUsu;

                Connection con2 = cn.getConexion();
                PreparedStatement ps2 = con2.prepareStatement(sql);
                ResultSet rs2 = ps2.executeQuery();

                while (rs2.next()) {
                    u.setIdUsuario(rs2.getInt(1));
                    u.setNombres(rs2.getString(2));
                    u.setApellidos(rs2.getString(3));
                }

                sql = "select idCompra, Cantidad, Monto, Fecha, Hora from ventas where idTienda=" + id + " and idVenta =" + idV;

                con2 = cn.getConexion();
                ps2 = con2.prepareStatement(sql);
                rs2 = ps2.executeQuery();

                while (rs2.next()) {
                    v.setIdVenta(idV);
                    v.setUsuario(u);
                    v.setProducto(nombrePro);
                    v.setIdTienda(id);
                    v.setIdCompra(rs2.getInt(1));
                    v.setCantidad(rs2.getInt(2));
                    v.setMonto(rs2.getInt(3));
                    v.setFecha(rs2.getString(4));
                    v.setHora(rs2.getString(5));
                    misVentas.add(v);
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return misVentas;
    }

    public int ganancias(int id) {
        int ganancias = 0;
        String sql = "select Monto from ventas where idTienda=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ganancias = ganancias + rs.getInt(1);
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }

        return ganancias;
    }

    public void listarLogoTienda(int id, HttpServletResponse response) {
        String sql = "select * from tiendas where idUsuario=" + id;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        BufferedInputStream bufferedInputStream = null;
        BufferedOutputStream bufferedOutputStream = null;

        try {
            outputStream = response.getOutputStream();
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                inputStream = rs.getBinaryStream("Logo");
            }
            bufferedInputStream = new BufferedInputStream(inputStream);
            bufferedOutputStream = new BufferedOutputStream(outputStream);
            int i = 0;
            while ((i = bufferedInputStream.read()) != -1) {
                bufferedOutputStream.write(i);
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
    }

}
