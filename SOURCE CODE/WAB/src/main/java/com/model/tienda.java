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
public class tienda {

    private int idTienda;
    private int idUsuario;
    private String nit;
    private String nombre;
    private InputStream logo;
    private String ubicacion;
    private String vigencia;

    public tienda() {
    }

    public tienda(int idTienda, int idUsuario, String nit, String nombre, InputStream logo, String ubicacion, String vigencia) {
        this.idTienda = idTienda;
        this.idUsuario = idUsuario;
        this.nit = nit;
        this.nombre = nombre;
        this.logo = logo;
        this.ubicacion = ubicacion;
        this.vigencia = vigencia;
    }

    public int getIdTienda() {
        return idTienda;
    }

    public void setIdTienda(int idTienda) {
        this.idTienda = idTienda;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public InputStream getLogo() {
        return logo;
    }

    public void setLogo(InputStream logo) {
        this.logo = logo;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public String getVigencia() {
        return vigencia;
    }

    public void setVigencia(String vigencia) {
        this.vigencia = vigencia;
    }

}
