<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BandejadeEntrada.aspx.cs" Inherits="BandejadeEntrada" %>

<%@ Register src="UserControl/MensajesCompletos.ascx" tagname="MensajesCompletos" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        body{
            background-color: whitesmoke;
        }
        .styleUsuario{
            height: 34px;
            width: 374px;
            font-size: 33px;
            color: #000000;
            text-shadow: 1px 1px #000000;
            text-align: center;
            text-decoration: underline;
        }
        .auto-style13 {
            height: 34px;
            font-size: 33px;
            color: #1C5E55;
            text-shadow: 1px 1px #000000;
            text-align: left;
            text-decoration: underline;
        }
        .auto-style22 {
            color: #1C5E55;
            text-decoration: underline;
            font-size: x-large;
        }
        .auto-style14 {
        height: 24px;
        text-align: center;
            width: 580px;
        }
        .auto-style23 {
            text-align: center;
            width: 580px;
        }
        .auto-style24 {
            width: 580px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td colspan="3" class="auto-style17">
                <asp:Panel ID="Panel1" runat="server" BorderColor="Black" BorderWidth="2px" BackColor="White" Height="105px">
                    <div class="text-center">
                        <strong><span><span class="auto-style22">Filtro de los mensajes por tipo, fecha o ambos</span></span><span class="auto-style21"><br /> </span>
                        <br />
                        </strong>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Tipo de mensaje: </strong><asp:DropDownList ID="ddlTiposMensaje" runat="server" CssClass="btn btn-dark" AppendDataBoundItems="true">
                            <asp:ListItem Value="0">&lt;Seleccione un Item&gt;</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>Fecha de recibido: </strong><asp:TextBox ID="txtFecha" runat="server" TextMode="DateTime" Placeholder="dd/mm/aaaa"></asp:TextBox>
                        <asp:Button ID="btnFecha" runat="server" CssClass="btn btn-success" Text="Filtrar" OnClick="btnFecha_Click" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnLimpiar" runat="server" BorderColor="Black" BorderStyle="Groove" BorderWidth="2px" CssClass="btn btn-info" OnClick="btnLimpiar_Click" Text="Limpiar Filtros" Enabled="False" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td colspan="3" class="auto-style13"></td>
        </tr>
        <tr>
            <td colspan="3" class="auto-style13">Bandeja de Entrada</td>
        </tr>
        <tr>
            <td class="auto-style14">
                <asp:GridView ID="grvRecibidos" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grvRecibidos_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="FechaHora" HeaderText="Fecha" />
                        <asp:BoundField DataField="Asunto" HeaderText="Asunto" />
                        <asp:BoundField DataField="Usuario.UsuarioLogueo" HeaderText="Remitente" />
                        <asp:CommandField ShowSelectButton="True" />
                    </Columns>
                    <EditRowStyle BackColor="#7C6F57" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>
            </td>
            <td class="auto-style12" colspan="2">
                <uc1:MensajesCompletos ID="MensajesCompletos1" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="auto-style23">
                &nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="auto-style24">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        </table>
</asp:Content>

