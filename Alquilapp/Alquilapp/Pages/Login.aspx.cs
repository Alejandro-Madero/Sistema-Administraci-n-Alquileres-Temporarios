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
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            Usuario usuario = negocioUsuario.Login(email, password);

            if(usuario != null)
            {
                Session.Add("usuario", usuario);
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                txtEmail.Text = "Error";
                txtPassword.Text = "Error";
            }
        }
    }
}