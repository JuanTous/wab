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
public class compras {

    private int idCompra;
    private int idUsuario;
    private String FechaCompra;
    private String HoraCompra;
    private int Monto;
    private String productos;

    public compras() {
    }

    public compras(int idCompra, int idUsuario, String FechaCompra, String HoraCompra, int Monto, String productos) {
        this.idCompra = idCompra;
        this.idUsuario = idUsuario;
        this.FechaCompra = FechaCompra;
        this.HoraCompra = HoraCompra;
        this.Monto = Monto;
        this.productos = productos;
    }

    public int getIdCompra() {
        return idCompra;
    }

    public void setIdCompra(int idCompra) {
        this.idCompra = idCompra;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getFechaCompra() {
        return FechaCompra;
    }

    public void setFechaCompra(String FechaCompra) {
        this.FechaCompra = FechaCompra;
    }

    public String getHoraCompra() {
        return HoraCompra;
    }

    public void setHoraCompra(String HoraCompra) {
        this.HoraCompra = HoraCompra;
    }

    public int getMonto() {
        return Monto;
    }

    public void setMonto(int Monto) {
        this.Monto = Monto;
    }

    public String getProductos() {
        return productos;
    }

    public void setProductos(String productos) {
        this.productos = productos;
    }
}
