using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
    }
}