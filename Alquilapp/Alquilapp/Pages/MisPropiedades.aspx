<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisPropiedades.aspx.cs" Inherits="AlquilApp.Pages.WebForm4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">

   <%: Styles.Render("~/Content/mispropiedades") %>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="propiedades-page">
        <div class="propiedades-container">
            <h2>Mis propiedades publicadas</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" Visible="false"></asp:Label>

            <asp:GridView ID="gvPropiedades" runat="server" AutoGenerateColumns="false" CssClass="propiedades-grid">
                <Columns>
                    <asp:BoundField DataField="Titulo" HeaderText="Título" />
                    <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" />
                    <asp:BoundField DataField="PrecioNoche" HeaderText="Precio (USD)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="Capacidad" HeaderText="Capacidad" />
                    <asp:BoundField DataField="Activa" HeaderText="Activa" />

                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CommandName="Editar" CommandArgument='<%# Eval("idPropiedad") %>' CssClass="btn-editar" />
                            <asp:Button ID="btnDesactivar" runat="server" Text="Desactivar" CommandName="Desactivar" CommandArgument='<%# Eval("idPropiedad") %>' CssClass="btn-desactivar" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Eval("idPropiedad") %>' CssClass="btn-eliminar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <div class="boton-publicar">
                <asp:Button ID="btnNuevaPropiedad" runat="server" Text="➕ Publicar nueva propiedad" CssClass="btn btn-primary" PostBackUrl="~/PublicarPropiedad.aspx" />
            </div>
        </div>
    </div>


</asp:Content>
