/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.modelDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.model.carrito;
import com.model.compras;
import com.model.producto;
import com.setting.conexion;
import com.setting.fecha_y_hora;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class comprasDAO {

    Connection con;
    conexion cn = new conexion();
    PreparedStatement ps;
    ResultSet rs;

    public void comprar(List<carrito> carrito, int idUsu) {
        int idCompra = 0;
        int totalPago = 0;
        int validar;
        String fecha = fecha_y_hora.fecha();
        String hora = fecha_y_hora.hora();
        String sql = "SELECT AUTO_INCREMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'bdwab' AND TABLE_NAME = 'compras'";

        for (int i = 0; i < carrito.size(); i++) {
            totalPago = totalPago + carrito.get(i).getSubTotal();
        }

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                idCompra = rs.getInt(1);
            }

            sql = "INSERT INTO `compras` (`idUsuario`, `FechaCompra`, `HoraCompra`, `Monto`, `Productos`) VALUES (?, ?, ?, ?, ?)";

            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idUsu);
            ps.setString(2, fecha);
            ps.setString(3, hora);
            ps.setInt(4, totalPago);
            ps.setString(5, productosJson(carrito));
            validar = ps.executeUpdate();
            if (validar == 1) {
                for (carrito car : carrito) {
                    descontarInventario(idUsu, idCompra, car.getIdProducto(), car.getCantidad(), fecha, hora);
                }
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al guardar los datos de la compra. -->" + e.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
    }

    public String productosJson(List<carrito> carrito) {
        JsonArray jsonArray = new JsonArray();

        for (carrito car : carrito) {
            JsonObject json = new JsonObject();
            json.addProperty("item", car.getItem());
            json.addProperty("idProducto", car.getIdProducto());
            json.addProperty("nombre", car.getNombre());
            json.addProperty("idTienda", car.getIdTienda());
            json.addProperty("nombreTienda", car.getNombreTienda());
            json.addProperty("descripcion", car.getDescripcion());
            json.addProperty("precioCompra", car.getPrecioCompra());
            json.addProperty("cantidad", car.getCantidad());
            json.addProperty("existencias", car.getExistencias());
            json.addProperty("subtotal", car.getSubTotal());
            json.addProperty("descuento", car.getDescuento());
            json.addProperty("tipo", car.getTipo());
            jsonArray.add(json);
        }

        return jsonArray.toString();
    }

    public void descontarInventario(int idu, int idc, int idp, int cant, String fecha, String hora) {
        productoDAO pdao = new productoDAO();
        producto pro;
        int cantidad;
        int idt = 0;
        pro = pdao.listarId(idp);
        cantidad = pro.getExistencias() - cant;
        int monto = pro.getPrecio() * cant;
        if (!"No".equals(pro.getDescuento())) {
            monto = aplicarDescuento(Integer.parseInt(pro.getDescuento()), pro.getPrecio());
            monto = monto * cant;
        }

        try {
            String sql = "update producto set Inventario = " + cantidad + " where idProducto =" + idp;
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();

            sql = "select idTienda from producto where idProducto =" + idp;
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                idt = rs.getInt(1);
            }

            sql = "insert into ventas(idUsuario, idProducto, idCompra, idTienda, NombreProducto, Cantidad, Monto, Fecha, Hora) values(?,?,?,?,?,?,?,?,?)";
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idu);
            ps.setInt(2, idp);
            ps.setInt(3, idc);
            ps.setInt(4, idt);
            ps.setString(5, pro.getNombre());
            ps.setInt(6, cant);
            ps.setInt(7, monto);
            ps.setString(8, fecha);
            ps.setString(9, hora);
            ps.executeUpdate();

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al modificar inventario. -->" + e.getMessage());
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
    }

    public int aplicarDescuento(int descuento, int precio) {
        int total;
        total = descuento;
        total = precio - ((precio * total) / 100);

        return total;
    }

    public List<compras> misCompras(int id) {
        List<compras> misCompras = new ArrayList<>();
        String sql = "select * from compras where idUsuario=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                compras compra = new compras();
                compra.setIdCompra(rs.getInt(1));
                compra.setIdUsuario(rs.getInt(1));
                compra.setFechaCompra(rs.getString(3));
                compra.setHoraCompra(rs.getString(4));
                compra.setMonto(rs.getInt(5));
                compra.setProductos(rs.getString(6));
                misCompras.add(compra);
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return misCompras;
    }
}
