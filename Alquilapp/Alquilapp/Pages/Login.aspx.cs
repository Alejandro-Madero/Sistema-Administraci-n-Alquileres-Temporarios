using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace AlquilApp.Pages.Usuarios
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuario"] != null)
            {
                Response.Redirect("~/Default.aspx");
                return;
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            UsuarioNegocio negocioUsuario = new UsuarioNegocio();

            lblMensaje.Text = "";
            lblMensaje.Visible = false;

            try
            {
                string email = txtEmail.Text;
                string password = txtPassword.Text;
                Usuario usuario = negocioUsuario.Login(email, password);

                if (usuario != null)
                {
                    Session.Add("usuario", usuario);

                    if (Request.QueryString["return_url"] == null)
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                    {
                        Response.Redirect(HttpUtility.UrlDecode(Request.QueryString["return_url"]));
                    }

                }                

            }
            catch (Exception ex)
            {

               lblMensaje.Text = ex.Message;
                lblMensaje.Visible = true;
            }
        }
    }
}