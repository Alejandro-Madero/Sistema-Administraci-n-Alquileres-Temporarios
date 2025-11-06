<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditarPropiedad.aspx.cs" Inherits="AlquilApp.Pages.WebForm7" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
     <%: Styles.Render("~/Content/editarpropiedad") %>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="editar-page">
        <div class="editar-container">
            <h2>Editar propiedad</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" Visible="false"></asp:Label>

            <div class="campo">
                <label for="txtTitulo">Título:</label>
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
            </div>

            <div class="campo">
                <label for="ddlCiudad">Ciudad:</label>
                <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="campo">
                <label for="txtDireccion">Dirección:</label>
                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" MaxLength="100"></asp:TextBox>
            </div>

            <div class="campo">
                <label for="txtPrecio">Precio por noche (USD):</label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number" step="0.5"></asp:TextBox>
            </div>

            <div class="campo">
                <label for="txtCapacidad">Capacidad:</label>
                <asp:TextBox ID="txtCapacidad" runat="server" CssClass="form-control" TextMode="Number" step="1"></asp:TextBox>
            </div>

            <div class="campo">
                <label for="ddlTipoPropiedad">Tipo de propiedad:</label>
                <asp:DropDownList ID="ddlTipoPropiedad" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Casa" Value="Casa" />
                    <asp:ListItem Text="Departamento" Value="Departamento" />
                    <asp:ListItem Text="Cabaña" Value="Cabaña" />
                    <asp:ListItem Text="Hostel" Value="Hostel" />
                </asp:DropDownList>
            </div>

            <div class="campo">
                <label for="txtDescripcion">Descripción:</label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control descripcion" TextMode="MultiLine"></asp:TextBox>
            </div>

            <div class="campo">
                <label>Estado:</label><br />
                <asp:CheckBox ID="chkActiva" runat="server" Text="Propiedad activa" />
            </div>

            <div class="acciones">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar cambios" CssClass="btn btn-primary" />
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="btn btn-secundario" PostBackUrl="~/Pages/MisPropiedades.aspx" />
            </div>
        </div>
    </div>

</asp:Content>
