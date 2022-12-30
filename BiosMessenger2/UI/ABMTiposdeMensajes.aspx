<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ABMTiposdeMensajes.aspx.cs" Inherits="ABMTiposdeMensajes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        body{
            background-color: whitesmoke;
        }
        .styleUsuario{
            height: 34px;
            width: 374px;
            font-size: 33px;
            color: #1C5E55;
            text-shadow: 1px 1px #000000;
            text-align: center;
            text-decoration: underline;
        }
        .auto-style13 {
        width: 428px;
    }
    .auto-style14 {
        width: 428px;
        height: 24px;
    }
    .auto-style15 {
        width: 617px;
    }
    .auto-style16 {
        text-align: right;
        width: 617px;
    }
    .auto-style17 {
        height: 24px;
        width: 617px;
    }
    .auto-style18 {
        width: 428px;
        text-align: right;
    }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr>
            <td colspan="3" class="styleUsuario">ABM Tipos de Mensaje</td>
        </tr>
        <tr>
            <td colspan="3" class="styleUsuario"></td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style16"><strong>Código:</strong> </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtCodigo" runat="server" MaxLength="3"></asp:TextBox>
            &nbsp;&nbsp;
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-dark" OnClick="btnBuscar_Click" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style18">&nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style16"><strong>Nombre:</strong> </td>
            <td class="auto-style13">
                <asp:TextBox ID="txtNombre" runat="server" MaxLength="20"></asp:TextBox>
                <strong>&nbsp;&nbsp;
                <asp:Button ID="btnLimpiar" runat="server" BackColor="White" BorderColor="Black" BorderWidth="1px" CssClass="btn btn-light" ForeColor="Black" Text="Limpiar" OnClick="btnLimpiar_Click" />
                </strong>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style17"></td>
            <td class="auto-style14"></td>
            <td class="auto-style12"></td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style13">
                <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-primary" Text="Agregar" OnClick="btnAgregar_Click" />
                <asp:Button ID="btnModificar" runat="server" CssClass="btn btn-secondary" Text="Modificar" OnClick="btnModificar_Click" />
                <asp:Button ID="btnEliminar" runat="server" CssClass="btn btn-danger" Text="Eliminar" OnClick="btnEliminar_Click" />
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style13">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td class="auto-style13">
                &nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style15">&nbsp;</td>
            <td colspan="2">
                <asp:Label ID="lblMensaje" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>

