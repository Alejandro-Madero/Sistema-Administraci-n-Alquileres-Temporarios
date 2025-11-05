<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PublicarPropiedad.aspx.cs" Inherits="AlquilApp.Pages.WebForm2" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
        <%: Styles.Render("~/Content/publicarpropiedad") %>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="publicar-page">
        <div class="publicar-box">

            <h2>Publicar nueva propiedad</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" Visible="false"></asp:Label>

            <div class="form-group">
                <asp:Label Text="Título:" runat="server" AssociatedControlID="txtTitulo" />
                <asp:TextBox ID="txtTitulo" runat="server" CssClass="form-control" placeholder="Ej: Cabaña frente al lago"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Descripción:" runat="server" AssociatedControlID="txtDescripcion" />
                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Describe tu propiedad..."></asp:TextBox>
            </div>

            <div class="form-row">
                <div class="form-group half">
                    <asp:Label Text="Ciudad:" runat="server" AssociatedControlID="ddlCiudad" />
                    <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Seleccionar..." Value="" />
                    </asp:DropDownList>
                </div>

                <div class="form-group half">
                    <asp:Label Text="Precio por noche (USD):" runat="server" AssociatedControlID="txtPrecio" />
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" placeholder="Ej: 120"></asp:TextBox>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group half">
                    <asp:Label Text="Capacidad:" runat="server" AssociatedControlID="txtCapacidad" />
                    <asp:TextBox ID="txtCapacidad" runat="server" CssClass="form-control" placeholder="Ej: 4"></asp:TextBox>
                </div>

                <div class="form-group half">
                    <asp:Label Text="Tipo de propiedad:" runat="server" AssociatedControlID="txtTipo" />
                    <asp:TextBox ID="txtTipo" runat="server" CssClass="form-control" placeholder="Ej: Departamento, Cabaña..."></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <asp:Label Text="Dirección:" runat="server" AssociatedControlID="txtDireccion" />
                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" placeholder="Ej: Av. Bustillo 12345"></asp:TextBox>
            </div>

            <div class="form-group">
                <asp:Label Text="Fotos:" runat="server" />
                <asp:FileUpload ID="fuFotos" runat="server" CssClass="form-control-file" AllowMultiple="true" />
            </div>

            <div class="button-container">
                <asp:Button ID="btnPublicar" runat="server" Text="Publicar propiedad" CssClass="btn btn-success" />
            </div>

        </div>
    </div>

</asp:Content>
