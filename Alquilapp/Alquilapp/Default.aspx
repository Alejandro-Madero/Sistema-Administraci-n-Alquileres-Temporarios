<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AlquilApp._Default" %>
<asp:Content ID="default" ContentPlaceHolderID="HeadContent" runat="server">
     
        <%: Styles.Render("~/Content/default") %>

</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">       
    <main class="default-page">  

    <h2>Encontrá tu próxima estadía</h2>

    <div class="search-container">
        <table class="search-table">
            <tr>
                <td>
                    <asp:Label Text="Ciudad:" runat="server" /><br />
                    <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control" placeholder="Ej: Bariloche, Salta..." Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Fecha de inicio:" runat="server" /><br />
                    <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="form-control" Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Fecha de fin:" runat="server" /><br />
                    <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="form-control" Width="95%"></asp:TextBox>
                </td>

                <td>
                    <asp:Label Text="Huéspedes:" runat="server" /><br />
                    <asp:DropDownList ID="ddlHuespedes" runat="server" CssClass="form-control" Width="95%">
                        <asp:ListItem Text="1" Value="1" />
                        <asp:ListItem Text="2" Value="2" />
                        <asp:ListItem Text="3" Value="3" />
                        <asp:ListItem Text="4" Value="4" />
                        <asp:ListItem Text="5 o más" Value="5" />
                    </asp:DropDownList>
                </td>
            </tr>
        </table>

        <div class="search-button">
            <asp:Button ID="btnBuscar" runat="server" Text="🔍 Buscar propiedades" CssClass="btn btn-primary" />
        </div>
    </div>

    <div class="results-container">
        <h3>Resultados</h3>
        <asp:GridView ID="gvResultados" runat="server" AutoGenerateColumns="false" CssClass="grid">
            <Columns>
                <asp:BoundField DataField="Titulo" HeaderText="Propiedad" />
                <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" />
                <asp:BoundField DataField="PrecioNoche" HeaderText="Precio por noche" DataFormatString="{0:C}" />
                <asp:BoundField DataField="Capacidad" HeaderText="Capacidad" />
                <asp:TemplateField HeaderText="Acción">
                    <ItemTemplate>
                        <asp:Button ID="btnVerDetalle" runat="server" Text="Ver detalle" CommandName="VerDetalle" CommandArgument='<%# Eval("idPropiedad") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    </main>

</asp:Content>
