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
            BtnFiltrar.Enabled = false;

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

                //Obtengo la lista de companias y lo guardo en el session
                ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();
                List<Companias> ListaCompanias = FCompania.Listar_Companias();
                Session["Companias"] = ListaCompanias;

                //Predefino los valores en los dropdown lists
                DDLTerminal.DataSource = ListaTerminales;
                DDLTerminal.DataTextField = "codigo";
                DDLTerminal.DataBind();
                DDLCompania.Items.Insert(0, new ListItem("", "Blanco"));

                DDLCompania.DataSource = ListaCompanias;
                DDLCompania.DataTextField = "nombre";
                DDLCompania.DataBind();
                DDLCompania.Items.Insert(0, new ListItem("", "Blanco"));


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
    protected void CalDesde_SelectionChanged(object sender, EventArgs e)
    {
        TBDesFechaPartida.Text = CalDesde.SelectedDate.ToShortDateString();
        VerificarFechas();
    }


    protected void CalHasta_SelectionChanged(object sender, EventArgs e)
    {
        TBHasFechaPartida.Text = CalHasta.SelectedDate.ToShortDateString();
        VerificarFechas();

    }


    private void VerificarFechas()
    {
        bool valido = false;
        LblError.Text = "";

        try
        {
            DateTime desdefecha = Convert.ToDateTime(TBDesFechaPartida.Text);
            DateTime hastafecha = Convert.ToDateTime(TBHasFechaPartida.Text);


            if (desdefecha < hastafecha)
            {
                valido = true;
            }

            else
            {
                LblError.ForeColor = System.Drawing.Color.Red;
                LblError.Text = "La fecha de Arribo debe ser mayor a la fecha de Partida";
            }
        }

        catch
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = "La fecha de Arribo debe ser mayor a la fecha de Partida";
        }

        if (valido)
        {
            BtnFiltrar.Enabled = true;
        }
        else
        {
            BtnFiltrar.Enabled = false;
        }
    }
    protected void DDLTerminal_SelectedIndexChanged(object sender, EventArgs e)
    {
        BtnFiltrar.Enabled =true;
    }
}