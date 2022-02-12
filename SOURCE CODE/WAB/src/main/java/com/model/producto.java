/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import java.io.InputStream;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class producto {

    private int id;
    private int idTienda;
    private String nombre;
    private String nombreTienda;
    private InputStream foto;
    private String descripcion;
    private int precio;
    private int existencias;
    private String descuento;
    private String tipo;

    public producto() {
    }

    public producto(int id, int idTienda, String nombre, String nombreTienda, InputStream foto, String descripcion, int precio, int existencias, String descuento, String tipo) {
        this.id = id;
        this.idTienda = idTienda;
        this.nombre = nombre;
        this.nombreTienda = nombreTienda;
        this.foto = foto;
        this.descripcion = descripcion;
        this.precio = precio;
        this.existencias = existencias;
        this.descuento = descuento;
        this.tipo = tipo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdTienda() {
        return idTienda;
    }

    public void setIdTienda(int idTienda) {
        this.idTienda = idTienda;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getNombreTienda() {
        return nombreTienda;
    }

    public void setNombreTienda(String nombreTienda) {
        this.nombreTienda = nombreTienda;
    }

    public InputStream getFoto() {
        return foto;
    }

    public void setFoto(InputStream foto) {
        this.foto = foto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getPrecio() {
        return precio;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public int getExistencias() {
        return existencias;
    }

    public void setExistencias(int existencias) {
        this.existencias = existencias;
    }

    public String getDescuento() {
        return descuento;
    }

    public void setDescuento(String descuento) {
        this.descuento = descuento;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

}
