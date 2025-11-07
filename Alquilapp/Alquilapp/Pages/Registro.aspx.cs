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
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {

            UsuarioNegocio negocio = new UsuarioNegocio();

            string nombre = txtNombre.Text.Trim();
            string apellido = txtApellido.Text.Trim();
            string email = txtEmail.Text.Trim();
            string telefono = txtTelefono.Text.Trim();
            string password = txtPassword.Text;
            string passwordconfirm = txtConfirmar.Text;


            if (password != passwordconfirm)
            {
                lblMensaje.Text = "Las contraseñas no coinciden.";
                lblMensaje.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(nombre) ||
        string.IsNullOrWhiteSpace(apellido) ||
        string.IsNullOrWhiteSpace(email) ||
        string.IsNullOrWhiteSpace(password) ||
        string.IsNullOrWhiteSpace(passwordconfirm))
            {
                lblMensaje.Text = "Todos los campos son obligatorios.";
                lblMensaje.Visible = true;
                return;
            }

            try
            {

                Usuario nuevoUsuario = new Usuario();

                nuevoUsuario.Nombre = nombre;
                nuevoUsuario.Apellido = apellido;
                nuevoUsuario.Email = email;
                nuevoUsuario.Telefono = telefono;
                
                negocio.Registrar(nuevoUsuario, password);

                lblMensaje.CssClass = "mensaje-exito";
                lblMensaje.Text = "Usuario registrado correctamente.";
                lblMensaje.Visible = true;
                Response.Redirect("~/Pages/Login.aspx");

            }
            catch (Exception ex)
            {
                lblMensaje.Visible = true;
                lblMensaje.Text = ex.Message;


            }


        }
    }
}