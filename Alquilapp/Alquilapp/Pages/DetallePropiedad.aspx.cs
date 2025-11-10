using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace AlquilApp.Pages
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["idPropiedad"] != null)
                {

                    int idPropiedad = int.Parse(Request.QueryString["idPropiedad"]);                  
                    this.CargarPropiedad(idPropiedad);

                }
            }
        }

        private void CargarPropiedad(int idPropiedad)
        {
            PropiedadNegocio negocio = new PropiedadNegocio();
            Propiedad propiedad = negocio.ObtenerDetallePropiedad(idPropiedad);
            List<FotoPropiedad> fotosPropiedad = negocio.ObtenerFotosPropiedad(idPropiedad);
            propiedad.Fotos = fotosPropiedad;

            rptFotos.DataSource = propiedad.Fotos;
            rptFotos.DataBind();
            lblTitulo.Text = propiedad.Titulo;
            lblCiudad.Text = propiedad.Ciudad.Nombre;
            lblDescripcion.Text = propiedad.Descripcion;
            lblPrecioNoche.Text = propiedad.PrecioNoche.ToString("0.00");
            lblCapacidad.Text = propiedad.Capacidad.ToString();
            lblAnfitrion.Text = propiedad.Anfitrion.Nombre + " " + propiedad.Anfitrion.Apellido;
        }
    }
}