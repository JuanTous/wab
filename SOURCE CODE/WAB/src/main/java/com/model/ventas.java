/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class ventas {

    private int idVenta;
    private usuario usuario;
    private String producto;
    private int idCompra;
    private int idTienda;
    private int cantidad;
    private int monto;
    private String fecha;
    private String hora;

    public ventas() {
    }

    public ventas(int idVenta, usuario usuario, String producto, int idCompra, int idTienda, int cantidad, int monto, String fecha, String hora) {
        this.idVenta = idVenta;
        this.usuario = usuario;
        this.producto = producto;
        this.idCompra = idCompra;
        this.idTienda = idTienda;
        this.cantidad = cantidad;
        this.monto = monto;
        this.fecha = fecha;
        this.hora = hora;
    }

    public int getIdVenta() {
        return idVenta;
    }

    public void setIdVenta(int idVenta) {
        this.idVenta = idVenta;
    }

    public usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(usuario usuario) {
        this.usuario = usuario;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getIdTienda() {
        return idTienda;
    }

    public void setIdTienda(int idTienda) {
        this.idTienda = idTienda;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }


}
