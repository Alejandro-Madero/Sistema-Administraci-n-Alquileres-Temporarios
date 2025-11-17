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
                    string fechaInicioString = Request.QueryString["fechaInicio"];
                    string fechaFinString = Request.QueryString["fechaFin"];
                    txtFechaInicio.Text = fechaInicioString;
                    txtFechaFin.Text = fechaFinString;                

                    
                    this.CargarPropiedad(idPropiedad);

                }
            }
        }

        private Propiedad CargarPropiedad(int idPropiedad)
        {
            PropiedadNegocio negocio = new PropiedadNegocio();
            Propiedad propiedad = negocio.ObtenerDetallePropiedad(idPropiedad);
            List<FotoPropiedad> fotosPropiedad = negocio.ObtenerFotosPropiedad(idPropiedad);
            propiedad.Fotos = fotosPropiedad;

            DateTime fechaInicio = DateTime.Parse(Request.QueryString["fechaInicio"]);
            DateTime fechaFin = DateTime.Parse(Request.QueryString["fechaFin"]);
            TimeSpan diffFechas = fechaFin - fechaInicio;
            int cantidadHuespedes = int.Parse(Request.QueryString["huespedes"]);

            decimal montoTotal = diffFechas.Days * propiedad.PrecioNoche;

            Session["propiedadSeleccionada"] = propiedad;
            Session["cantidadNoches"] = diffFechas;

            rptFotos.DataSource = propiedad.Fotos;
            rptFotos.DataBind();
            lblTitulo.Text = propiedad.Titulo;
            lblCiudad.Text = propiedad.Ciudad.Nombre;
            lblDescripcion.Text = propiedad.Descripcion;
            lblPrecioNoche.Text = propiedad.PrecioNoche.ToString("0.00");
            lblCapacidad.Text = propiedad.Capacidad.ToString();
            lblAnfitrion.Text = propiedad.Anfitrion.Nombre + " " + propiedad.Anfitrion.Apellido;
            lblNoches.Text = diffFechas.Days.ToString();
            lblMontoTotal.Text = montoTotal.ToString("0.00");
            lblCantidadHuespedes.Text = cantidadHuespedes.ToString();

            return propiedad;
        }
       
        protected void btnReservar_Click(object sender, EventArgs e)
        {

            PropiedadNegocio negocio  = new PropiedadNegocio();

            if (Session["usuario"] == null)
            {
                string returnUrl = Request.RawUrl;
                Response.Redirect("~/Pages/Login.aspx?return_url=" + HttpUtility.UrlEncode(returnUrl));                
            }

            try
            {
                Propiedad propiedad;

                if (Session["propiedadSeleccionada"] == null)
                {
                    propiedad = this.CargarPropiedad(int.Parse(Request.QueryString["idPropiedad"]));
                }
                else
                {
                    propiedad = (Propiedad)Session["propiedadSeleccionada"];
                }
                   
                
                if(Request.QueryString["fechaInicio"] == null || Request.QueryString["fechaFin"] == null)
                {
                    throw new Exception("Debes seleccionar las fechas a reservar"); 
                }

                DateTime fechaInicio = DateTime.Parse(Request.QueryString["fechaInicio"]);
                DateTime fechaFin = DateTime.Parse(Request.QueryString["fechaFin"]);
                TimeSpan diffFechas;
            
                if (Session["cantidadNoches"] != null)
                {
                diffFechas = (TimeSpan)Session["cantidadNoches"];

                }
                else
                {
                    diffFechas = fechaFin - fechaInicio;
                }

                Usuario usuario = (Usuario)Session["usuario"];

                decimal montoTotal = diffFechas.Days * propiedad.PrecioNoche;
                int idPropiedad = int.Parse(Request.QueryString["idPropiedad"]);
                int huespedes = int.Parse(lblCantidadHuespedes.Text);
                negocio.ReservarPropiedad(idPropiedad, huespedes, fechaInicio, fechaFin, usuario);
                lblMensaje.Text = "La propiedad fue reservada exitosamente";
                lblMensaje.CssClass = "mensaje-exito";
                lblMensaje.Visible = true;


                

            }
            catch (Exception ex)
            {

                lblMensaje.Text = "La reserva no pudo ser realizada" + ex.Message;
                lblMensaje.Visible = true;
                lblMensaje.CssClass = "mensaje-error";
                
            }




        }
    }
}