/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.setting;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
public class fecha_y_hora {

    public static String fecha() {
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MMM/YYYY");

        Calendar c = new GregorianCalendar();

        return formatoFecha.format(c.getTime());
    }

    public static String hora() {
        DateTimeFormatter formateador = DateTimeFormatter.ofPattern("HH:mm:ss");
        String hora = formateador.format(LocalDateTime.now());
        
        return hora;
    }

}
