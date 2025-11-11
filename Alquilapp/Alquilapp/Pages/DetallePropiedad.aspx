<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetallePropiedad.aspx.cs" Inherits="AlquilApp.Pages.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%: Styles.Render("~/Content/detallepropiedad") %>
</asp:Content>
<asp:Content ID="DetallePropiedadPage" ContentPlaceHolderID="MainContent" runat="server">
    <div class="detalle-page">
        <div class="detalle-container">

            <div class="detalle-header">
                <h2>
                    <asp:Label ID="lblTitulo" runat="server" Text="Título de la Propiedad"></asp:Label></h2>
                <p class="detalle-ubicacion">
                    <i class="bi bi-geo-alt"></i>
                    <asp:Label ID="lblCiudad" runat="server" Text="Bariloche, Argentina"></asp:Label>
                </p>
            </div>


            <div id="carouselFotos" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <asp:Repeater ID="rptFotos" runat="server">
                        <ItemTemplate>
                            <div class='carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>'>
                                <img src='<%# Eval("URL") %>' class="carousel-foto" alt='<%# Eval("Descripcion") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselFotos" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Anterior</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselFotos" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Siguiente</span>
                </button>
            </div>


            <div class="detalle-info">
                <p><strong>Descripción:</strong>
                    <asp:Label ID="lblDescripcion" runat="server" Text="Una hermosa cabaña con vista al lago."></asp:Label></p>
                <p><strong>Precio por noche:</strong> $<asp:Label ID="lblPrecioNoche" runat="server" Text="150"></asp:Label></p>
                <p><strong>Capacidad:</strong>
                    <asp:Label ID="lblCapacidad" runat="server" Text="4"></asp:Label>
                    huéspedes</p>
                <p><strong>Anfitrión:</strong>
                    <asp:Label ID="lblAnfitrion" runat="server" Text="Alejandro Madero"></asp:Label></p>

            </div>

            <div class="detalle-reserva">
                <h3>Reservar</h3>

                <div class="form-group">
                    <asp:Label Text="Fecha de Check-in:" runat="server" />
                    <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true" ></asp:TextBox>
                </div>

                <div class="form-group">
                    <asp:Label Text="Fecha de Check-out:" runat="server" />
                    <asp:TextBox ID="txtFechaFin" runat="server" TextMode="Date" CssClass="form-control" ReadOnly="true" ></asp:TextBox>
                </div>
                <p><strong>Noches:</strong>
                    <asp:Label ID="lblNoches" runat="server" /></p>
                <p><strong>Total:</strong> $<asp:Label ID="lblMontoTotal" runat="server" /></p>

                <asp:Button ID="btnReservar" runat="server" OnClick="btnReservar_Click" Text="Reservar ahora" CssClass="btn btn-success" />

                <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje-estado" Visible="false"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
