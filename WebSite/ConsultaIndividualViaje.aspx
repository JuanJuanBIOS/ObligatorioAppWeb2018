<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsultaIndividualViaje.aspx.cs" Inherits="ConsultaIndividualViaje" %>

<link href="HojaDeEstiloTerminales.css" rel="stylesheet" type="text/css" />
<%@ Register src="WebUserControl.ascx" tagname="WebUserControl" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    <h2>
        Consulta Individual de Viaje: </h2>
    <p style="text-align: right">
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx">Volver</asp:HyperLink>
    </p>
    <uc1:WebUserControl ID="WebUserControl1" runat="server" />
    </form>
</body>
</html>
