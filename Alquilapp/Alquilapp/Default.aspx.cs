using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;  


namespace AlquilApp
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["usuario"] != null)
            {
                var usuario = (dominio.Usuario)Session["usuario"];
                lblNombreUsuario.Text = "Hola " + usuario.Nombre + "!.  ";
            }

        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            PropiedadNegocio negocio = new PropiedadNegocio();
            string ciudad = txtCiudad.Text.Trim();
            string capacidad = ddlHuespedes.SelectedValue;
            DateTime fechaInicio = DateTime.Parse(txtFechaInicio.Text.Trim());
            DateTime fechaFin = DateTime.Parse(txtFechaFin.Text.Trim()).Date;
          
            List<Propiedad> propiedadesDisponibles = negocio.ListarPropiedades(ciudad, capacidad, fechaInicio, fechaFin);
            gvResultados.DataSource = propiedadesDisponibles;
            gvResultados.DataBind();

        }

        protected void gvResultados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               
                string valor = e.Row.Cells[6].Text; 

                if (string.IsNullOrEmpty(valor) || valor == "&nbsp;")
                {
                    e.Row.Cells[6].Text = "Sin calificaciones";
                }
            }
        }

        protected void gvResultados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerMas")
            {
                string idPropiedad = e.CommandArgument.ToString();
                Response.Redirect("~/Pages/DetallePropiedad.aspx?idPropiedad=" + idPropiedad);
            }
        }
    }
}