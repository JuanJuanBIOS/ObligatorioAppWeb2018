<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Logueo.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 23%;
        }
        .style2
        {
        }
        .style4
        {
            width: 112px;
        }
        .style5
        {
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <br />
        <br />
        <br />
    <div>
        <br />
        <table align="center" class="style1">
            <tr>
                <td align="center" class="style5" colspan="2">
                    <h3 align="center"><asp:Label ID="LblMens" runat="server" Text="Ingrese su Usuario y Contraseña"></asp:Label></h3>
                </td>
            </tr>
            <tr>
                <td align="center" class="style5">
                    &nbsp;</td>
                <td class="style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" class="style5">
                    Cedula:
                </td>
                <td class="style4">
                    <asp:TextBox ID="TBCedula" runat="server" MaxLength="9"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" class="style5">
                    Contraseña:
                </td>
                <td class="style4">
                    <asp:TextBox ID="TBContrasenia" runat="server" TextMode="Password" 
                        MaxLength="6"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="center" class="style2" colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td align="center" class="style2" colspan="2">
                    <asp:Button ID="BtnLogin" runat="server" onclick="BtnLogin_Click" 
                        Text="Ingresar" />
                </td>
            </tr>
            <tr>
                <td align="center" class="style2" colspan="2">
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Volver</asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td align="center" class="style2" colspan="2">
                    <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
                    <asp:Label ID="LblException" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
