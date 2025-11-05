<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MisReservas.aspx.cs" Inherits="AlquilApp.Pages.WebForm3" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
            <%: Styles.Render("~/Content/misreservas") %>

</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="reservas-page">
        <div class="reservas-container">
            <h2>Mis reservas</h2>

            <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" Visible="false"></asp:Label>

            <asp:GridView ID="gvReservas" runat="server" AutoGenerateColumns="false" CssClass="reservas-grid">
                <Columns>
                    <asp:BoundField DataField="TituloPropiedad" HeaderText="Propiedad" />
                    <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" />
                    <asp:BoundField DataField="FechaInicio" HeaderText="Desde" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="FechaFin" HeaderText="Hasta" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Monto" HeaderText="Monto (USD)" DataFormatString="{0:N2}" />
                    <asp:BoundField DataField="EstadoReserva" HeaderText="Estado" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CommandName="Cancelar" CommandArgument='<%# Eval("idReserva") %>' CssClass="btn-cancelar" />
                            <asp:Button ID="btnCalificar" runat="server" Text="Calificar" CommandName="Calificar" CommandArgument='<%# Eval("idReserva") %>' CssClass="btn-calificar" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
