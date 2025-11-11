using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AlquilApp
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["usuario"] != null)
            {
                Usuario usuario = (Usuario)Session["usuario"];
                lblUsuario.Text = "👤 " + usuario.Email;
                lblUsuario.Visible = true;

                lnkLogin.Visible = false;
                lnkLogout.Visible = true;
                btnDesactivar.Visible = true;
            }
            else
            {
                lblUsuario.Visible = false;
                lnkLogin.Visible = true;
                lnkLogout.Visible = false;
            }

        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();            
            Response.Redirect("~/Pages/Login.aspx");
        }

        protected void btnConfirmarDesactivarCuenta_Click(object sender, EventArgs e)
        {

            if (Session["usuario"] == null)
            {
                return;
            }

            try
            {
                Usuario usuario = (Usuario)Session["usuario"];
                int idUsuario = usuario.IdUsuario;

                UsuarioNegocio negocio = new UsuarioNegocio();
                negocio.DesactivarCuenta(idUsuario);
                Session.Clear();
                Session.Abandon();
                Response.Redirect("~/Pages/Login.aspx");


            }
            catch (Exception ex)
            {

                throw;
            }

        }
    }
}