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
                //Obtengo lista de terminales y lo guardo en el session
                ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();
                List<Terminales> ListaTerminales = FTerminal.Listar_Terminales();
                Session["Terminales"] = ListaTerminales;
                
                //Obtengo lista de viajes y lo guardo en el session
                ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();
                List<Viajes> ListaViajes = FViaje.Listar_Viajes();
                
                Session["ListaViajes"] = ListaViajes;

                //Uso LinQ para tener solo los viajes que aún no hayan partido
                List<Viajes> viajesnopartieron = (from unViaje in ListaViajes
                                where unViaje.Fecha_partida >= DateTime.Now 
                                select unViaje).ToList<Viajes>();

                RepeaterViajes.DataSource = viajesnopartieron;
                RepeaterViajes.DataBind();
            }
            catch (Exception ex) { LblError.Text = ex.Message; }

        }
    }
    protected void RepeaterViajes_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "ConsultaViaje")
        {

           try
            {
               
               int viajeseleccionado = Convert.ToInt32(((TextBox)(e.Item.Controls[1])).Text);

               //Uso LinQ para tener solo el viaje seleccionado por el click en el boton del repeater

               // sólo quiero el viaje con ese id
               var resultado = from unViaje in (List<Viajes>)Session["ListaViajes"]
                               where unViaje.Numero == viajeseleccionado
                               select unViaje;

               // Casteo el resultado del LinQ y la paso al session
               foreach (Viajes unViaje in resultado)
               {
                  Session["ViajeSeleccionado"] = unViaje;
               }

               Response.Redirect("~/ConsultaIndividualViaje.aspx");

            }
            catch (Exception ex) { LblError.Text = ex.Message; }
        }

    }
}