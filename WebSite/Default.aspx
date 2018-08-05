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
        .style5
        {
            width: 87px;
        }
        .style6
        {
            width: 172px;
        }
        .style7
        {
            width: 185px;
        }
        .style9
        {
            width: 63px;
        }
        .style10
        {
            width: 149px;
        }
        .style11
        {
            width: 149px;
            height: 192px;
        }
        .style12
        {
            width: 268435424px;
        }
    </style>
    <link href="HojaDeEstiloTerminales.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: left">
    
        <h1>
            Terminales<br />
        </h1>
    
    <table style="width: 74%">
        <tr>
            <td style="width: 179px">
                Destino:
            </td>
            <td colspan="8">
                <asp:DropDownList ID="DDLTerminal" runat="server" Width="240px" 
                    AppendDataBoundItems="true" 
                    onselectedindexchanged="DDLTerminal_SelectedIndexChanged" 
                    AutoPostBack="True">
                <Items>
                    <asp:ListItem Text="" Value="" />
                </Items>
                </asp:DropDownList>
            </td>
            <td>
                <asp:HyperLink ID="Ingresar" runat="server" NavigateUrl="~/Logueo.aspx">Ingresar</asp:HyperLink>
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
                <td class="style5">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
                <td class="style6" colspan="1">
                    <asp:Label ID="LblError" runat="server" ForeColor="Red"></asp:Label>
                </td>
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
                    <asp:Calendar ID="CalDesde" runat="server" 
                        onselectionchanged="CalDesde_SelectionChanged"></asp:Calendar>
                </td>
                <td class="style3">
                    <br />
                    <br />
                    <br />
                </td>
                <td class="style11">
                    <asp:Label ID="LbFechaArribo" runat="server" Text="Hasta fecha de partida:"></asp:Label>
                    <br />
                    <asp:TextBox ID="TBHasFechaPartida" runat="server" Enabled="False"></asp:TextBox>
                </td>
                <td class="style4" colspan="2" align="center" valign="middle">
                    <asp:Calendar ID="CalHasta" runat="server" 
                        onselectionchanged="CalHasta_SelectionChanged"></asp:Calendar>
                </td>
                <td class="style12">
                </td>
            </tr>
                <tr>
            <td style="width: 179px">
                &nbsp;</td>
            <td colspan="4">
                &nbsp;</td>
            <td class="style10">
                <asp:Button ID="BtnFiltrar" runat="server" Text="Filtrar" 
                    onclick="BtnFiltrar_Click" />
                    </td>
            <td style="width: 125px">
                <asp:Button ID="BtnLimpiar" runat="server" Text="Limpiar" 
                    onclick="BtnLimpiar_Click" />
                    </td>
            <td class="style7">
                &nbsp;</td>
            <td class="style12">
                &nbsp;</td>
        </tr>
    </table>

    <br />
        <asp:Repeater ID="RepeaterViajes" runat="server" OnItemCommand="RepeaterViajes_ItemCommand">
            <HeaderTemplate>
                    <tr>
                        <td>
                            Número
                        </td>
                        <td>
                            Companía
                        </td>
                        <td>
                            Fecha y hora de partida
                        </td>
                        <td>
                            Fecha y hora de arribo
                        </td>
                        <td>
                            Destino
                        </td>
                        <td>
                            Botones
                        </td>
                    </tr>
                    <br />
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <asp:TextBox ID="TBNum" runat="server" Text='<%#Bind("Numero") %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="TBComp" runat="server" Text='<%#Eval("Compania.Nombre") %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="TBFechP" runat="server" Text='<%#Bind("Fecha_partida") %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="TBFechA" runat="server" Text='<%#Bind("Fecha_arribo") %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="TBDestino" runat="server" Text='<%#Eval("Terminal.Codigo") %>'></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="Button1" runat="server" CommandName="ConsultaViaje" Style="text-align: center"
                            Text="Consulta" />
                    </td>
                    <br />
                </tr>
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
