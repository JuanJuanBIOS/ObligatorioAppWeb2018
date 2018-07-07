<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ABMTerminales.aspx.cs" Inherits="ObligatorioAppWeb.ABMTerminales" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PaginaPrincipal" runat="server">



    <h2 align="center">
        <asp:Label ID="LbSubt" runat="server" Text="Mantenimiento de Terminales"></asp:Label>
    </h2>
<p>
    Código:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TBCodigo" runat="server" MaxLength="3"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="BtnBuscar" runat="server" Text="Buscar" 
       />
</p>
    <p>
        <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
</p>
    <table style="width: 100%">
        <tr>
            <td style="width: 94px">
                Ciudad:
            </td>
            <td colspan="11">
                <asp:TextBox ID="TBCiudad" runat="server" Width="324px" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 94px">
                País:
            </td>
            <td colspan="11">
                <asp:TextBox ID="TBPais" runat="server" Width="324px" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
                <td style="width: 94px">
                    Facilidades:</td>
                <td class="style10" colspan="2">
        <asp:TextBox ID="TBFacilidades" runat="server" Width="233px" MaxLength="50"></asp:TextBox>
                </td>
                <td colspan="3">
                    &nbsp;</td>
                <td class="style9" colspan="1">
        <asp:Button ID="BtnAgregar" runat="server"  
            Text="Agregar"  />
                </td>
                <td class="style9" colspan="2">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style7" style="width: 94px">
                    &nbsp;</td>
                <td class="style10" colspan="2">
        <asp:ListBox ID="LBFacilidades" runat="server" Height="112px" Width="178px">
        </asp:ListBox>
                </td>
                <td class="style9" colspan="2">
                    &nbsp;</td>
                <td class="style9" colspan="2">
        <asp:Button ID="BtnQuitar" runat="server" 
            Text="Quitar" />
                </td>
                <td class="style9" colspan="3">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        <tr>
            <td style="width: 94px">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
            <td colspan="3">
                &nbsp;</td>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" style="width: 94px" >
                &nbsp;</td>
            <td align="center" >
                <asp:Button ID="BtnAlta" runat="server" Text="Alta" 
                    />
            </td>
            <td align="center" style="width: 90px" >
                <asp:Button ID="BtnModificar" runat="server" Text="Modificar" 
                    />
            </td>
            <td align="center" style="width: 22px" >
                &nbsp;</td>
            <td align="center" colspan="5" >
                <asp:Button ID="BtnConfirmarModificacion" runat="server" 
                    Text="Confirmar Modificación"  />
            </td>
            <td align="center" style="width: 34px" >
                &nbsp;</td>
            <td align="center" >
                <asp:Button ID="BtnEliminar" runat="server" Text="Eliminar" 
                     />
            </td>
            <td align="center" style="width: 543px" >
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

