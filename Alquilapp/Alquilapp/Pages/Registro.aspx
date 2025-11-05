<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="AlquilApp.Pages.Usuarios.WebForm2" %>
<asp:Content ID="registro" ContentPlaceHolderID="HeadContent" runat="server">
            <%: Styles.Render("~/Content/registro") %>

</asp:Content>

<asp:Content ID="RegistroPage" ContentPlaceHolderID="MainContent" runat="server">


    <div class="registro-page">
        <div class="registro-box">
            <h2>Crear cuenta</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false"></asp:Label>

            <div class="form-group">
                <asp:Label Text="Nombre:" runat="server" AssociatedControlID="txtNombre" />
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Tu nombre"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Apellido:" runat="server" AssociatedControlID="txtApellido" />
                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Tu apellido"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Email:" runat="server" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="usuario@ejemplo.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Teléfono:" runat="server" AssociatedControlID="txtTelefono" />
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="+54 9 11..."></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Contraseña:" runat="server" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Confirmar contraseña:" runat="server" AssociatedControlID="txtConfirmar" />
                <asp:TextBox ID="txtConfirmar" runat="server" TextMode="Password" CssClass="form-control" placeholder="Repetir contraseña"></asp:TextBox>
            </div>

            <div class="button-container">
                <asp:Button ID="btnRegistrar" runat="server" Text="Registrarme" CssClass="btn btn-primary" />
            </div>

            <div class="extra-links">
                <a href="Login.aspx">¿Ya tenés cuenta? Iniciá sesión</a>
            </div>
        </div>
    </div>

</asp:Content>
