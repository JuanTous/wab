/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.controlador;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.model.producto;
import com.model.tienda;
import com.model.usuario;
import com.model.ventas;
import com.modelDAO.productoDAO;
import com.modelDAO.tiendaDAO;
import com.modelDAO.usuarioDAO;

/**
 *
 * @author Juan Sebastian Tous Triana
 */
@MultipartConfig
public class controladorEmp extends HttpServlet {

    producto p;
    tienda tienda;
    productoDAO pdao = new productoDAO();
    tiendaDAO tdao = new tiendaDAO();
    usuarioDAO udao = new usuarioDAO();
    List<producto> productos = new ArrayList<>();
    List<ventas> misVentas = new ArrayList<>();
    int idp;
    int ganancias = 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        switch (accion) {
            case "home":
                if (usuario.class.cast(request.getSession().getAttribute("sesion")) != null) {
                    tienda = tdao.retornarTienda(usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario());
                    productos = pdao.listarMisProductos(tienda.getIdTienda());
                    misVentas = tdao.misVentas(tienda.getIdTienda());
                    ganancias = tdao.ganancias(tienda.getIdTienda());
                    // 
                    List<Integer> ids = new ArrayList<>();
                    for (producto pro : productos) {
                        ids.add(pro.getId());
                    }
                    request.setAttribute("ganancias", ganancias);
                    request.setAttribute("idProductos", ids);
                    request.setAttribute("contadorMisPro", productos.size());
                    request.getSession().setAttribute("tienda", tienda);
                    request.getSession().setAttribute("misProductos", productos);
                    request.getSession().setAttribute("misVentas", misVentas);
                    request.getSession().setAttribute("misVentasContador", misVentas.size());
                    request.getRequestDispatcher("tablero.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                }
                break;
            case "destroy":
                request.removeAttribute("contadorMisPro");
                request.getSession().removeAttribute("tienda");
                request.getSession().removeAttribute("misProductos");
                request.getSession().removeAttribute("misVentas");
                request.getRequestDispatcher("controlador?accion=destroy").forward(request, response);
                break;
            case "Montar":
                if (udao.verificarTienda(usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario())) {
                    request.getRequestDispatcher("controlador?accion=home").forward(request, response);
                } else {
                    String nombre = request.getParameter("nombre");
                    String nit = request.getParameter("nit");
                    Part part = request.getPart("logotipo");
                    InputStream inputStream = part.getInputStream();
                    String ubicacion = request.getParameter("ubicacion");
                    tienda = new tienda();
                    tienda.setIdUsuario(usuario.class.cast(request.getSession().getAttribute("sesion")).getIdUsuario());
                    tienda.setNit(nit);
                    tienda.setNombre(nombre);
                    tienda.setLogo(inputStream);
                    tienda.setUbicacion(ubicacion);
                    tienda.setVigencia("activo");
                    tdao.crearTienda(tienda);
                    request.getRequestDispatcher("controladorEmp?accion=home").forward(request, response);
                }
                break;
            case "Crear":
                p = new producto();
                String nombre = request.getParameter("nombrePro");
                Part part = request.getPart("foto");
                InputStream inputStream = part.getInputStream();
                String descripcion = request.getParameter("descripcion");
                int precio = Integer.parseInt(request.getParameter("precio"));
                int inventario = Integer.parseInt(request.getParameter("inventario"));
                String descuento = request.getParameter("descuento");
                String tipo = request.getParameter("tipo");
                p.setIdTienda(tienda.getClass().cast(request.getSession().getAttribute("tienda")).getIdTienda());
                p.setNombre(nombre);
                p.setNombreTienda(tienda.getClass().cast(request.getSession().getAttribute("tienda")).getNombre());
                p.setFoto(inputStream);
                p.setDescripcion(descripcion);
                p.setPrecio(precio);
                p.setExistencias(inventario);
                p.setDescuento(descuento);
                p.setTipo(tipo);
                pdao.agregarProducto(p);
                request.getRequestDispatcher("controladorEmp?accion=home").forward(request, response);
                break;
            case "Editar":
                p = new producto();
                idp = Integer.parseInt(request.getParameter("idProEdi"));
                String descripcionE = request.getParameter("descripcionE");
                int precioE = Integer.parseInt(request.getParameter("precioE"));
                int inventarioE = Integer.parseInt(request.getParameter("inventarioE"));
                String descuentoE = request.getParameter("descuentoE");
                p.setId(idp);
                p.setDescripcion(descripcionE);
                p.setPrecio(precioE);
                p.setExistencias(inventarioE);
                p.setDescuento(descuentoE);
                pdao.editarProducto(p);
                request.getRequestDispatcher("controladorEmp?accion=home").forward(request, response);
                break;
            case "eliminarProducto":
                idp = Integer.parseInt(request.getParameter("idp"));
                pdao.eliminarProducto(idp);
                request.getRequestDispatcher("controladorEmp?accion=home").forward(request, response);
                break;
            case "listarLogoTienda":
                int id = Integer.parseInt(request.getParameter("id"));
                //JOptionPane.showMessageDialog(null, id);
                tdao.listarLogoTienda(id, response);
                break;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
