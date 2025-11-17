<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AlquilApp._Default" %>
<asp:Content ID="default" ContentPlaceHolderID="HeadContent" runat="server">
     
   
<link rel="stylesheet" href='<%= ResolveUrl("~/Styles/default.css") %>' />

</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">       
    <main class="default-page">

        <div class="container-bienvenida">
            <asp:Label Text="" ID="lblNombreUsuario" runat="server" />
            <p> Encontrá tu próxima estadía</p>
        </div>

    <div class="search-container">
        <table class="search-table">
            <tr>
                <td>
                    <asp:Label Text="Ciudad:" runat="server" /><br />
                    <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" placeholder="Ej: Bariloche, Salta..." Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Fecha de Check-in:" runat="server" /><br />
                    <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="form-control" Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Fecha de Check-out:" runat="server" /><br />
                    <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="form-control" Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Huéspedes:" runat="server" /><br />
                    <asp:DropDownList ID="ddlHuespedes" runat="server" CssClass="form-control" Width="95%">
                        <asp:ListItem Text="1" Value="1" />
                        <asp:ListItem Text="2" Value="2" />
                        <asp:ListItem Text="3" Value="3" />
                        <asp:ListItem Text="4" Value="4" />
                        <asp:ListItem Text="5" Value="5" />
                        <asp:ListItem Text="6" Value="6" />
                        <asp:ListItem Text="7" Value="7" />
                        <asp:ListItem Text="8" Value="8" />
                        <asp:ListItem Text="9" Value="9" />
                        <asp:ListItem Text="10" Value="10" />
                        <asp:ListItem Text="11" Value="11" />
                        <asp:ListItem Text="12" Value="12" />
                        <asp:ListItem Text="13" Value="13" />
                        <asp:ListItem Text="14" Value="14" />
                        <asp:ListItem Text="15" Value="15" />
                    </asp:DropDownList>
                </td>
            </tr>
        </table>

        <div class="search-button">
            <asp:Button ID="btnBuscar" runat="server" onClick="btnBuscar_Click" Text="🔍 Buscar propiedades" CssClass="btn btn-primary" />
        </div>
                  <asp:Label Text="" runat="server" ID="lblMensaje" CssClass="mensaje-error" Visible="false"/>             

    </div>

    <div class="results-container">
        <h3>Resultados</h3>
        <asp:GridView ID="gvResultados" runat="server" OnRowDataBound="gvResultados_RowDataBound" OnRowCommand="gvResultados_RowCommand"
            AutoGenerateColumns="false" CssClass="table table-striped">
         <Columns>
        <asp:BoundField DataField="Titulo" HeaderText="Título" />
        <asp:BoundField DataField="TipoPropiedad" HeaderText="Tipo" />
        <asp:BoundField DataField="Ciudad.Nombre" HeaderText="Ciudad" />
        <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
        <asp:BoundField DataField="Capacidad" HeaderText="Capacidad Personas" />
        <asp:BoundField DataField="PrecioNoche" HeaderText="Precio por noche" DataFormatString="{0:C}" />
        <asp:BoundField DataField="CalificacionPromedio" HeaderText="Calificación Promedio" DataFormatString="{0:0.##}" />
             <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="btnVerMas" runat="server"
                                Text="Ver más"
                                CssClass="btn btn-primary btn-sm"
                                CommandName="VerMas"
                                CommandArgument='<%# Eval("IdPropiedad") %>' />
                </ItemTemplate>
            </asp:TemplateField>
    </Columns>
        </asp:GridView>

    </div>
    </main>

</asp:Content>
