<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Listado.aspx.cs" Inherits="AlquilApp.Pages.WebForm5" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%: Styles.Render("~/Content/listado") %>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="listado-page">

        <div class="listado-header">
            <h2>Propiedades disponibles</h2>
            <div class="filtros">
                <label for="ddlOrden">Ordenar por:</label>
                <asp:DropDownList ID="ddlOrden" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Precio (menor a mayor)" Value="precioAsc" />
                    <asp:ListItem Text="Precio (mayor a menor)" Value="precioDesc" />
                    <asp:ListItem Text="Capacidad" Value="capacidad" />
                </asp:DropDownList>
                <asp:Button ID="btnOrdenar" runat="server" Text="Aplicar" CssClass="btn btn-primary" />
            </div>
        </div>

        <asp:Repeater ID="rptPropiedades" runat="server">
            <ItemTemplate>
                <div class="card">
                    <img src='<%# Eval("FotoPrincipal") %>' alt='<%# Eval("Titulo") %>' class="card-img" />
                    <div class="card-body">
                        <h3><%# Eval("Titulo") %></h3>
                        <p class="ciudad"><%# Eval("Ciudad") %></p>
                        <p class="precio">USD <%# Eval("PrecioNoche") %> / noche</p>
                        <a href='DetallePropiedad.aspx?id=<%# Eval("idPropiedad") %>' class="btn btn-detalle">Ver detalle</a>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

    </div>
</asp:Content>
