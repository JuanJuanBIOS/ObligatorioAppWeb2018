using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;


public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();

                List<Viajes> ListaViajes = FViaje.Listar_Viajes();

                RepeaterViajes.DataSource = ListaViajes;
                RepeaterViajes.DataBind();
            }
            catch (Exception ex) { LblError.Text = ex.Message; }

        }
    }
    protected void RepeaterViajes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {

    }
}