<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ABMCompanias.aspx.cs" Inherits="ABMCompanias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PaginaPrincipal" runat="server">
    <h2 align="center">
    <asp:Label ID="LbSubt" runat="server" 
        Text="Mantenimiento de Companias FALTA CAMBIAR"></asp:Label>
</h2>
<p>
    Nombre:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TBNombre" runat="server" MaxLength="3"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="BtnBuscar" runat="server" Text="Buscar" onclick="BtnBuscar_Click" 
       />
</p>
<p dir="ltr">
    <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="BtnOk" runat="server" onclick="BtnOk_Click" Text="Ok" 
            Visible="False" />
</p>
<table style="width: 100%">
    <tr>
        <td style="width: 94px">
            Dirección:
        </td>
        <td colspan="10">
            <asp:TextBox ID="TBDireccion" runat="server" MaxLength="50" Width="324px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 94px">
            Teléfono:
        </td>
        <td colspan="10">
            <asp:TextBox ID="TBTelefono" runat="server" MaxLength="50" Width="324px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 94px">
            &nbsp;</td>
        <td class="style10" colspan="2">
            &nbsp;</td>
        <td colspan="3">
                    &nbsp;</td>
        <td class="style9" colspan="1">
            &nbsp;</td>
        <td class="style9">
                    &nbsp;</td>
        <td>
                    &nbsp;</td>
    </tr>
    <tr>
        <td class="style7" style="width: 94px">
                    &nbsp;</td>
        <td class="style10" colspan="2">
            &nbsp;</td>
        <td class="style9" colspan="2">
                    &nbsp;</td>
        <td class="style9" colspan="2">
            &nbsp;</td>
        <td class="style9" colspan="2">
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
        <td colspan="2">
                &nbsp;</td>
        <td colspan="2">
                &nbsp;</td>
    </tr>
    <tr>
        <td align="center" style="width: 94px" >
                &nbsp;</td>
        <td align="center" >
            <asp:Button ID="BtnAlta" runat="server" Text="Alta" onclick="BtnAlta_Click" 
                    />
        </td>
        <td align="center" style="width: 90px" >
            <asp:Button ID="BtnModificar" runat="server" Text="Modificar" 
                    />
        </td>
        <td align="center" style="width: 22px" >
                &nbsp;</td>
        <td align="center" colspan="4" >
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

