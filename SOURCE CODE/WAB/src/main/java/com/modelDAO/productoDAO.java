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
import java.util.*;

import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import com.model.producto;
import com.setting.conexion;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class productoDAO {

    Connection con;
    conexion cn = new conexion();
    PreparedStatement ps;
    ResultSet rs;

    public List<producto> listar() {
        List<producto> productos = new ArrayList<>();
        String sql = "select * from producto inner join tiendas on "
                + "producto.idTienda = tiendas.idTienda where tiendas.Vigencia = 'activo'";

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                producto p = new producto();
                p.setId(rs.getInt(1));
                p.setIdTienda(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setNombreTienda(rs.getString(4));
                p.setFoto(rs.getBinaryStream(5));
                p.setDescripcion(rs.getString(6));
                p.setPrecio(rs.getInt(7));
                p.setExistencias(rs.getInt(8));
                p.setDescuento(rs.getString(9));
                p.setTipo(rs.getString(10));
                if (p.getExistencias() > 0) {
                    productos.add(p);
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return productos;
    }

    public producto listarId(int id) {
        String sql = "select * from producto where idProducto=" + id;
        producto p = new producto();
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                p.setId(rs.getInt(1));
                p.setIdTienda(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setNombreTienda(rs.getString(4));
                p.setFoto(rs.getBinaryStream(5));
                p.setDescripcion(rs.getString(6));
                p.setPrecio(rs.getInt(7));
                p.setExistencias(rs.getInt(8));
                p.setDescuento(rs.getString(9));
                p.setTipo(rs.getString(10));
                if (p.getExistencias() == 0) {
                    p = null;
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return p;
    }

    public List<producto> buscarProductos(String tipo, String busqueda) {
        List<producto> productos = new ArrayList<>();
        String sql;
        switch (tipo) {
            case "null":
                sql = "select * from producto where Nombre like \'%" + busqueda + "%\' order by Nombre asc";
                try {
                    con = cn.getConexion();
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        producto p = new producto();
                        p.setId(rs.getInt(1));
                        p.setIdTienda(rs.getInt(2));
                        p.setNombre(rs.getString(3));
                        p.setNombreTienda(rs.getString(4));
                        p.setFoto(rs.getBinaryStream(5));
                        p.setDescripcion(rs.getString(6));
                        p.setPrecio(rs.getInt(7));
                        p.setExistencias(rs.getInt(8));
                        p.setDescuento(rs.getString(9));
                        p.setTipo(rs.getString(10));
                        if (p.getExistencias() > 0) {
                            productos.add(p);
                        }
                    }
                } catch (Exception e) {
                } finally {
                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }
                break;
            case "tienda":
                int id;
                sql = "select * from tiendas where nombreTienda = \'" + busqueda + "\'";

                try {
                    con = cn.getConexion();
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        id = rs.getInt("idTienda");

                        sql = "select * from producto where idTienda=" + id + " order by Nombre asc";
                        con = cn.getConexion();
                        ps = con.prepareStatement(sql);
                        rs = ps.executeQuery();

                        while (rs.next()) {
                            producto p = new producto();
                            p.setId(rs.getInt(1));
                            p.setIdTienda(rs.getInt(2));
                            p.setNombre(rs.getString(3));
                            p.setNombreTienda(rs.getString(4));
                            p.setFoto(rs.getBinaryStream(5));
                            p.setDescripcion(rs.getString(6));
                            p.setPrecio(rs.getInt(7));
                            p.setExistencias(rs.getInt(8));
                            p.setDescuento(rs.getString(9));
                            p.setTipo(rs.getString(10));
                            if (p.getExistencias() > 0) {
                                productos.add(p);
                            }
                        }
                    }
                } catch (Exception e) {
                } finally {
                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }
                break;
            case "categoria":
                sql = "select * from producto where Tipo like \'%" + busqueda + "%\' order by Nombre asc";
                try {
                    con = cn.getConexion();
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        producto p = new producto();
                        p.setId(rs.getInt(1));
                        p.setIdTienda(rs.getInt(2));
                        p.setNombre(rs.getString(3));
                        p.setNombreTienda(rs.getString(4));
                        p.setFoto(rs.getBinaryStream(5));
                        p.setDescripcion(rs.getString(6));
                        p.setPrecio(rs.getInt(7));
                        p.setExistencias(rs.getInt(8));
                        p.setDescuento(rs.getString(9));
                        p.setTipo(rs.getString(10));
                        if (p.getExistencias() > 0) {
                            productos.add(p);
                        }
                    }
                } catch (Exception e) {
                } finally {
                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }
                break;
            case "precio":
                int precio = Integer.parseInt(busqueda);
                int min = precio - 50000;
                int max = precio + 50000;
                if (min <= 0) {
                    min = 1;
                }
                sql = "select * from producto where Precio between " + min + " and " + max + " order by Precio asc";
                try {
                    con = cn.getConexion();
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();

                    while (rs.next()) {
                        producto p = new producto();
                        p.setId(rs.getInt(1));
                        p.setIdTienda(rs.getInt(2));
                        p.setNombre(rs.getString(3));
                        p.setNombreTienda(rs.getString(4));
                        p.setFoto(rs.getBinaryStream(5));
                        p.setDescripcion(rs.getString(6));
                        p.setPrecio(rs.getInt(7));
                        p.setExistencias(rs.getInt(8));
                        p.setDescuento(rs.getString(9));
                        p.setTipo(rs.getString(10));
                        if (p.getExistencias() > 0) {
                            productos.add(p);
                        }
                    }
                } catch (Exception e) {
                } finally {
                    try {
                        con.close();
                    } catch (Exception e) {
                    }
                }
                break;
        }
        return productos;
    }

    public List<producto> productosOfertados() {
        List<producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM `producto` where Descuento != 'No'";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                producto p = new producto();
                p.setId(rs.getInt(1));
                p.setIdTienda(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setNombreTienda(rs.getString(4));
                p.setFoto(rs.getBinaryStream(5));
                p.setDescripcion(rs.getString(6));
                p.setPrecio(rs.getInt(7));
                p.setExistencias(rs.getInt(8));
                p.setDescuento(rs.getString(9));
                p.setTipo(rs.getString(10));
                if (p.getExistencias() > 0) {
                    productos.add(p);
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return productos;
    }

    public void listarImg(int id, HttpServletResponse response) {
        String sql = "select * from producto where idProducto=" + id;
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
                inputStream = rs.getBinaryStream("foto");
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

    //Usuario tipo Emprendedor
    public List<producto> listarMisProductos(int id) {
        List<producto> productos = new ArrayList<>();
        String sql = "select * from producto where idTienda=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                producto p = new producto();
                p.setId(rs.getInt(1));
                p.setIdTienda(rs.getInt(2));
                p.setNombre(rs.getString(3));
                p.setNombreTienda(rs.getString(4));
                p.setFoto(rs.getBinaryStream(5));
                p.setDescripcion(rs.getString(6));
                p.setPrecio(rs.getInt(7));
                p.setExistencias(rs.getInt(8));
                p.setDescuento(rs.getString(9));
                p.setTipo(rs.getString(10));
                productos.add(p);
            }
        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
        return productos;
    }

    public void agregarProducto(producto p) {
        String sql = "insert into producto(idTienda,Nombre,nombreTienda,Foto,Descripcion,Precio,Inventario,Descuento,Tipo)values(?,?,?,?,?,?,?,?,?)";
        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.setInt(1, p.getIdTienda());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getNombreTienda());
            ps.setBlob(4, p.getFoto());
            ps.setString(5, p.getDescripcion());
            ps.setInt(6, p.getPrecio());
            ps.setInt(7, p.getExistencias());
            ps.setString(8, p.getDescuento());
            ps.setString(9, p.getTipo());
            ps.executeUpdate();
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error= " + e.getMessage());
        }
    }

    public void editarProducto(producto p) {
        String sql = "update producto set Descripcion ='" + p.getDescripcion() + "', Precio=" + p.getPrecio()
                + ", Inventario=" + p.getExistencias() + ", Descuento='" + p.getDescuento() + "' where idProducto=" + p.getId();

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();

        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }

    }

    public void eliminarProducto(int id) {
        String sql = "delete from producto where idProducto=" + id;

        try {
            con = cn.getConexion();
            ps = con.prepareStatement(sql);
            ps.executeUpdate();

        } catch (Exception e) {
        } finally {
            try {
                con.close();
            } catch (Exception e) {
            }
        }
    }

}
