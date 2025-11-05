<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CalificarReserva.aspx.cs" Inherits="AlquilApp.Pages.WebForm6" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
        <%: Styles.Render("~/Content/calificarreserva") %>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
     <div class="calificar-page">

        <div class="calificar-container">
            <h2>Calificar tu estadía</h2>

            <asp:Label ID="lblPropiedad" runat="server" CssClass="propiedad-nombre"></asp:Label>

            <div class="campo">
                <label for="ddlPuntuacion">Puntuación:</label><br />
                <asp:DropDownList ID="ddlPuntuacion" runat="server" CssClass="form-control">
                    <asp:ListItem Text="1 - Muy mala" Value="1" />
                    <asp:ListItem Text="2 - Mala" Value="2" />
                    <asp:ListItem Text="3 - Regular" Value="3" />
                    <asp:ListItem Text="4 - Buena" Value="4" />
                    <asp:ListItem Text="5 - Excelente" Value="5" />
                </asp:DropDownList>
            </div>

            <div class="campo">
                <label for="txtComentario">Comentario:</label><br />
                <asp:TextBox ID="txtComentario" runat="server" TextMode="MultiLine" CssClass="form-control comentario" placeholder="Contanos tu experiencia..."></asp:TextBox>
            </div>

            <div class="acciones">
                <asp:Button ID="btnEnviar" runat="server" Text="Enviar calificación" CssClass="btn btn-primary" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secundario" PostBackUrl="~/Pages/MisReservas.aspx" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" Visible="false"></asp:Label>
        </div>
    </div>

</asp:Content>
