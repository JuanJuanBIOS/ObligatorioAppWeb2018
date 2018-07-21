using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMViajesInternacionales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LimpioFormulario();

        ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

        List<string> ListaTerminales = FTerminal.Listar_Terminales();

        DDLTerminal.DataSource = ListaTerminales;
        DDLTerminal.DataBind();

        ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

        List<string> ListaCompanias = FCompania.Listar_Companias();

        DDLCompania.DataSource = ListaCompanias;
        DDLCompania.DataBind();

        TBNumero.Focus();
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        if (TBNumero.Text != "")
        {
            try
            {
                LblError.Text = "";

                int _Codigo = Convert.ToInt32(TBNumero.Text);

                ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();

                Internacionales unInter = FViaje.Buscar_Viaje(_Codigo);

                Session["Internacional"] = unInter;

                if (unInter == null)
                {
                    ActivoFormularioAlta();
                }

                else
                {
                    DDLCompania.Text = unInter.Compania.Nombre;
                    DDLTerminal.Text = unInter.Terminal.Codigo;



                    TBCiudad.Text = unaTer.Ciudad;
                    DDLPais.Text = unaTer.Pais;

                    Session["Facilidades"] = unaTer.ListaFacilidades;

                    LBFacilidades.DataSource = unaTer.ListaFacilidades;
                    LBFacilidades.DataTextField = "Facilidad";
                    LBFacilidades.DataBind();

                    ActivoFormularioModificacion();
                }
            }

            catch (Exception ex)
            {
                LblError.ForeColor = System.Drawing.Color.Red;
                LblError.Text = ex.Message;
            }
        }
    }


    private void LimpioFormulario()
    {
        TBNumero.Text = "";
        TBNumero.Enabled = true;
        BtnBuscar.Enabled = true;
        DDLCompania.ClearSelection();
        DDLCompania.Enabled = false;
        DDLTerminal.ClearSelection();
        DDLTerminal.Enabled = false;
        TBFechaPartida.Text = "";
        CalFechaPartida.Enabled = false;
        TBFechaArribo.Text = "";
        CalFechaArribo.Enabled = false;
        DDLHoraPartida.ClearSelection();
        DDLHoraPartida.Enabled = false;
        DDLMinutosPartida.ClearSelection();
        DDLMinutosPartida.Enabled = false;
        DDLHoraArribo.ClearSelection();
        DDLHoraArribo.Enabled = false;
        DDLMinutosArribo.ClearSelection();
        DDLHoraArribo.Enabled = false;
        TBCantAsientos.Text = "";
        TBCantAsientos.Enabled = false;
        DDLServicio.ClearSelection();
        DDLServicio.Enabled = false;
        TBDocumentacion.Text = "";
        TBDocumentacion.Enabled = false;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = true;
    }


    private void ActivoFormularioAlta()
    {
        TBNumero.Text = TBNumero.Text.ToUpper();
        TBNumero.Enabled = false;
        BtnBuscar.Enabled = false;
        DDLCompania.Enabled = true;
        DDLTerminal.Enabled = true;
        CalFechaPartida.Enabled = true;
        CalFechaArribo.Enabled = true;
        DDLHoraPartida.Enabled = true;
        DDLMinutosPartida.Enabled = true;
        DDLHoraArribo.Enabled = true;
        DDLHoraArribo.Enabled = true;
        TBCantAsientos.Enabled = true;
        DDLServicio.Enabled = true;
        TBDocumentacion.Enabled = true;
        BtnAlta.Enabled = true;
        BtnModificar.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = true;
    }

    private void ActivoFormularioModificacion()
    {
        TBNumero.Enabled = false;
        BtnBuscar.Enabled = false;
        DDLCompania.Enabled = true;
        DDLTerminal.Enabled = true;
        CalFechaPartida.Enabled = true;
        CalFechaArribo.Enabled = true;
        DDLHoraPartida.Enabled = true;
        DDLMinutosPartida.Enabled = true;
        DDLHoraArribo.Enabled = true;
        DDLHoraArribo.Enabled = true;
        TBCantAsientos.Enabled = true;
        DDLServicio.Enabled = true;
        TBDocumentacion.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
        BtnLimpiar.Enabled = true;
    }
    protected void CalFechaPartida_SelectionChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        TBFechaPartida.Text = CalFechaPartida.SelectedDate.ToShortDateString();
        if(CalFechaPartida.SelectedDate > CalFechaArribo.SelectedDate && 
    }
}