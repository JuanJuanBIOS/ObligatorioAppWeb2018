<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ABMEmpleados.aspx.cs" Inherits="ABMEmpleados" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PaginaPrincipal" Runat="Server">
    <h2 style="text-align: center">
        Mantenimiento Empleado</h2>
    <p>
        Cédula:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:TextBox ID="TBCedula" runat="server" MaxLength="50"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="BtnBuscar" runat="server" Text="Buscar" onclick="BtnBuscar_Click" 
       />
    </p>
    <p>
    <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
    </p>
<table style="width: 100%">
    <tr>
        <td style="width: 94px">
            Nombre: 
        </td>
        <td colspan="8">
            <asp:TextBox ID="TBNombre" runat="server" MaxLength="50" Width="324px" 
                Enabled="False"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 94px">
            Contraseña:
        </td>
        <td colspan="8">
            <asp:TextBox ID="TBContraseña" runat="server" MaxLength="6" Width="324px" 
                Enabled="False" TextMode="Password"></asp:TextBox>
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
    </tr>
    <tr>
        <td align="center" style="width: 94px" >
                &nbsp;</td>
        <td align="center" >
            <asp:Button ID="BtnAlta" runat="server" Text="Alta" onclick="BtnAlta_Click" Enabled="False" 
                    />
        </td>
        <td align="center" style="width: 90px" >
            <asp:Button ID="BtnModificar" runat="server" Text="Modificar" 
                onclick="BtnModificar_Click" Enabled="False" 
                    />
        </td>
        <td align="center" style="width: 22px" >
                &nbsp;</td>
        <td align="center" style="width: 34px" >
                <asp:Button ID="BtnEliminar" runat="server" Text="Eliminar" Enabled="False" 
                    onclick="BtnEliminar_Click" />
        </td>
        <td align="center" >
            &nbsp;</td>
        <td align="left" style="width: 543px" >
                <asp:Button ID="BtnLimpiar" runat="server" Text="Limpiar formulario" 
                    onclick="BtnLimpiar_Click" />
        </td>
    </tr>
</table>
    <p>
    </p>
</asp:Content>

