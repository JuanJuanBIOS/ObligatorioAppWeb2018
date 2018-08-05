using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EntidadesCompartidas;


public partial class WebUserControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Viajes vselec = (Viajes)Session["ViajeSeleccionado"];
            CompletoInfoViaje(vselec);
            CompletoInfoCompania(vselec);
            CompletoInfoTerminal(vselec);

        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }

    }


    private void CompletoInfoViaje(Viajes _viaje)
    {

        if (_viaje is Internacionales)
        {
            //Escondo campos de nacionales
            TBParadas.Visible = false;
            LblParadas.Visible = false;

            //Imprimo variables de internacionales
            CBServicio.Checked = ((Internacionales)_viaje).Servicio;
            TBDocumentacion.Text = ((Internacionales)_viaje).Documentacion;
        }
        else
        {
            //Escondo campos de internacionales
            CBServicio.Visible = TBDocumentacion.Visible = false;
            LblServicio.Visible = LblDocumentacion.Visible = false;

            //Imprimo variables de nacionales
            TBParadas.Text = Convert.ToString(((Nacionales)_viaje).Paradas);
        }

        TBNumViaje.Text = Convert.ToString(_viaje.Numero);
        TBCompania.Text = _viaje.Compania.Nombre;
        TBDestino.Text = _viaje.Terminal.Codigo;
        TBFechPar.Text = Convert.ToString(_viaje.Fecha_partida);
        TBFechArr.Text = Convert.ToString(_viaje.Fecha_arribo);
        TBAsientos.Text = Convert.ToString(_viaje.Asientos);
        TBEmpleado.Text = _viaje.Empleado.Cedula;
    }

    private void CompletoInfoCompania(Viajes _viaje)
    {

        TBNomComp.Text = _viaje.Compania.Nombre;
        TBDirComp.Text = _viaje.Compania.Direccion;
        TBTelComp.Text = _viaje.Compania.Telefono;

    }

    private void CompletoInfoTerminal(Viajes _viaje)
    {

        TBCodigoTer.Text = _viaje.Terminal.Codigo;
        TBCiudadTer.Text = _viaje.Terminal.Ciudad;
        TBPaisTer.Text = _viaje.Terminal.Pais;
        foreach(Facilidades f in _viaje.Terminal.ListaFacilidades)
        {
            LBFacilidadesTer.Text = LBFacilidadesTer.Text + Convert.ToString(f.Facilidad);

        }

    }

}
