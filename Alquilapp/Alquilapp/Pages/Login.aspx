<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AlquilApp.Pages.Usuarios.WebForm1" %>

<asp:Content ID="login" ContentPlaceHolderID="HeadContent" runat="server">
     <%: Styles.Render("~/Content/login") %>
</asp:Content>

<asp:Content ID="LoginPage" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-page">
        <div class="login-box">
            <h2>Iniciar sesión</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-error" Visible="false"></asp:Label>

            <div class="form-group">
                <asp:Label Text="Email:" runat="server" AssociatedControlID="txtEmail" />
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="usuario@ejemplo.com"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Contraseña:" runat="server" AssociatedControlID="txtPassword" />
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="••••••••"></asp:TextBox>
            </div>

            <div class="button-container">
                <asp:Button ID="btnLogin" runat="server" onClick="btnLogin_Click" Text="Iniciar sesión" CssClass="btn btn-primary" />
            </div>

            <div class="extra-links">
                <a href="Registro.aspx">¿No tenés cuenta? Registrate</a>
            </div>
        </div>
    </div>



</asp:Content>
