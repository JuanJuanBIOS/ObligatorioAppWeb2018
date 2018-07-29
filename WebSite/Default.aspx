<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 179px;
            height: 192px;
        }
        .style2
        {
            height: 192px;
        }
        .style3
        {
            width: 60px;
            height: 192px;
        }
        .style4
        {
            width: 268435392px;
            height: 192px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <table style="width: 100%">
        <tr>
            <td style="width: 179px">
                Destino:
            </td>
            <td colspan="8">
                <asp:DropDownList ID="DDLTerminal" runat="server" Enabled="False" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 179px">
                Compañía:
            </td>
            <td colspan="8">
                <asp:DropDownList ID="DDLCompania" runat="server" Width="240px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
                <td style="width: 179px">
                    &nbsp;</td>
                <td class="style10">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="style9" colspan="1" style="width: 370px">
                    &nbsp;</td>
                <td class="style9">
                    &nbsp;</td>
                <td colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style1">
                    <asp:Label ID="LbFechaPartida" runat="server" Text="Desde fecha de partida"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBDesFechaPartida" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td class="style2" colspan="3" align="center" valign="middle">
                    <asp:Calendar ID="CalDesde" runat="server"></asp:Calendar>
                </td>
                <td class="style3">
                    <br />
                    <br />
                    <br />
                </td>
                <td class="style2">
                    <asp:Label ID="LbFechaArribo" runat="server" Text="Hasta fecha de partida:"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBHasFechaPartida" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td class="style4" colspan="2" align="center" valign="middle">
                    <asp:Calendar ID="CalHasta" runat="server"></asp:Calendar>
                </td>
                <td
                </td class="style2">
            </tr>
                <tr>
            <td style="width: 179px">
                &nbsp;</td>
            <td colspan="4">
                &nbsp;</td>
            <td style="width: 61px">
                &nbsp;</td>
            <td style="width: 125px">
                <asp:Button ID="BtnLimpiar" runat="server" Text="Limpiar" />
                    </td>
            <td style="width: 228px">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    
        <asp:Repeater ID="RepeaterViajes" runat="server" 
            onitemcommand="RepeaterViajes_ItemCommand">
            <ItemTemplate>
                    <table>
                        <tr>
                            <th>Número</th>
                            <th>Companía</th>
                            <th>Fecha y hora de partida</th>
                            <th>Fecha y hora de arribo</th>
                            <th>Destino</th>
                        </tr>
                        <td>
                            Número1:<asp:TextBox ID="número" runat="server" Text ='<%#Bind("numero") %>'></asp:TextBox>
                        <br />
                        </td>
                         <td>
                            Companía:<asp:TextBox ID="TextBox1" runat="server" Text ='<%#Bind("numero") %>'></asp:TextBox>
                        <br />
                        </td>
                        <td>
                            FechHora1:<asp:TextBox ID="TextBox2" runat="server" Text ='<%#Bind("numero") %>'></asp:TextBox>
                        <br />
                        </td>
                    </table>
                </ItemTemplate>
        </asp:Repeater>
    
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    
    </div>
    </form>
</body>
</html>
