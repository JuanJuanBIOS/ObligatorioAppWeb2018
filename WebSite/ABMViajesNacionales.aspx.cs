using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMViajesNacionales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LimpioFormulario();

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            List<Terminales> ListaTerminales = FTerminal.Listar_Terminales();

            Session["Terminales"] = ListaTerminales;

            DDLTerminal.DataSource = ListaTerminales;
            DDLTerminal.DataTextField = "codigo";
            DDLTerminal.DataBind();
            DDLTerminal.Items.Insert(0, new ListItem("", "No seleccionado"));

            ILogicaCompania FCompania = FabricaLogica.getLogicaCompania();

            List<Companias> ListaCompanias = FCompania.Listar_Companias();

            Session["Companias"] = ListaCompanias;
            DDLCompania.DataSource = ListaCompanias;
            DDLCompania.DataTextField = "nombre";
            DDLCompania.DataBind();
            DDLCompania.Items.Insert(0, new ListItem("", "No seleccionado"));

            bool encontrado = false;
            Session["Encontrado"] = encontrado;

            TBNumero.Focus();
        }

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

                Viajes unNac = FViaje.Buscar_Viaje(_Codigo);

                if (unNac == null)
                {
                    ActivoFormularioAlta();
                }

                else if (unNac is Internacionales)
                {
                    LblError.ForeColor = System.Drawing.Color.Red;
                    LblError.Text = "El número de viaje ingresado corresponde a un viaje internacional";
                }

                else
                {
                    Session["Encontrado"] = true;

                    Session["Nacional"] = (Nacionales)unNac;

                    DDLCompania.Text = unNac.Compania.Nombre;
                    DDLTerminal.Text = unNac.Terminal.Codigo;
                    CalFechaPartida.SelectedDate = unNac.Fecha_partida.Date;
                    CalFechaArribo.VisibleDate = unNac.Fecha_partida.Date;
                    TBFechaPartida.Text = unNac.Fecha_partida.Date.ToShortDateString();
                    CalFechaArribo.SelectedDate = unNac.Fecha_arribo.Date;
                    CalFechaPartida.VisibleDate = unNac.Fecha_arribo.Date;
                    TBFechaArribo.Text = unNac.Fecha_arribo.Date.ToShortDateString();
                    DDLHoraPartida.SelectedIndex = unNac.Fecha_partida.Hour;
                    DDLMinutosPartida.SelectedIndex = unNac.Fecha_partida.Minute;
                    DDLHoraArribo.SelectedIndex = unNac.Fecha_arribo.Hour;
                    DDLMinutosArribo.SelectedIndex = unNac.Fecha_arribo.Minute;
                    TBCantAsientos.Text = Convert.ToString(unNac.Asientos);
                    TBParadas.Text = Convert.ToString(((Nacionales)unNac).Paradas);

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
    protected void BtnAlta_Click(object sender, EventArgs e)
    {
        try
        {
            int _Numero = Convert.ToInt32(TBNumero.Text);

            Terminales _Terminal = (from unaTerminal in (List<Terminales>)Session["Terminales"]
                                    where unaTerminal.Codigo == DDLTerminal.SelectedValue
                                    select unaTerminal).First();

            Companias _Compania = (from unaCompania in (List<Companias>)Session["Companias"]
                                   where unaCompania.Nombre == DDLCompania.SelectedValue
                                   select unaCompania).First();

            int diapartida = Convert.ToDateTime(TBFechaPartida.Text).Day;
            int mespartida = Convert.ToDateTime(TBFechaPartida.Text).Month;
            int aniopartida = Convert.ToDateTime(TBFechaPartida.Text).Year;
            int horapartida = Convert.ToInt16(DDLHoraPartida.Text);
            int minutospartida = Convert.ToInt16(DDLMinutosPartida.Text);
            int diaarribo = Convert.ToDateTime(TBFechaArribo.Text).Day;
            int mesarribo = Convert.ToDateTime(TBFechaArribo.Text).Month;
            int anioarribo = Convert.ToDateTime(TBFechaArribo.Text).Year;
            int horaarribo = Convert.ToInt16(DDLHoraArribo.Text);
            int minutosarribo = Convert.ToInt16(DDLMinutosArribo.Text);
            DateTime _Fechapartida = new DateTime(aniopartida, mespartida, diapartida, horapartida, minutospartida, 0);
            DateTime _Fechaarribo = new DateTime(anioarribo, mesarribo, diaarribo, horaarribo, minutosarribo, 0);

            int _CantAsientos = Convert.ToInt16(TBCantAsientos.Text);

            Empleados _Empleado = (Empleados)Session["Empleado"];

            int _Paradas = Convert.ToInt16(TBParadas.Text);

            Nacionales unNac = new Nacionales(_Numero, _Compania, _Terminal, _Fechapartida, _Fechaarribo, _CantAsientos, _Empleado, _Paradas);

            ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();

            FViaje.Alta_Viaje(unNac);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "El Viaje " + Convert.ToString(unNac.Numero) + " ha sido ingresado a la base de datos correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }
    protected void BtnModificar_Click(object sender, EventArgs e)
    {
        try
        {
            int _Numero = Convert.ToInt16(TBNumero.Text);

            Terminales _Terminal = (from unaTerminal in (List<Terminales>)Session["Terminales"]
                                    where unaTerminal.Codigo == DDLTerminal.SelectedValue
                                    select unaTerminal).First();

            Companias _Compania = (from unaCompania in (List<Companias>)Session["Companias"]
                                   where unaCompania.Nombre == DDLCompania.SelectedValue
                                   select unaCompania).First();

            int diapartida = Convert.ToDateTime(TBFechaPartida.Text).Day;
            int mespartida = Convert.ToDateTime(TBFechaPartida.Text).Month;
            int aniopartida = Convert.ToDateTime(TBFechaPartida.Text).Year;
            int horapartida = Convert.ToInt16(DDLHoraPartida.Text);
            int minutospartida = Convert.ToInt16(DDLMinutosPartida.Text);
            int diaarribo = Convert.ToDateTime(TBFechaArribo.Text).Day;
            int mesarribo = Convert.ToDateTime(TBFechaArribo.Text).Month;
            int anioarribo = Convert.ToDateTime(TBFechaArribo.Text).Year;
            int horaarribo = Convert.ToInt16(DDLHoraArribo.Text);
            int minutosarribo = Convert.ToInt16(DDLMinutosArribo.Text);
            DateTime _Fechapartida = new DateTime(aniopartida, mespartida, diapartida, horapartida, minutospartida, 0);
            DateTime _Fechaarribo = new DateTime(anioarribo, mesarribo, diaarribo, horaarribo, minutosarribo, 0);

            int _CantAsientos = Convert.ToInt16(TBCantAsientos.Text);

            Empleados _Empleado = (Empleados)Session["Empleado"];

            int _Paradas = Convert.ToInt16(TBParadas.Text);

            Nacionales unNac = new Nacionales(_Numero, _Compania, _Terminal, _Fechapartida, _Fechaarribo, _CantAsientos, _Empleado, _Paradas);

            ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();

            FViaje.Modificar_Viaje(unNac);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "El Viaje " + Convert.ToString(unNac.Numero) + " ha sido modificado correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }
    protected void BtnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            Nacionales unNac = (Nacionales)Session["Nacional"];

            ILogicaViajes FViaje = FabricaLogica.getLogicaViaje();

            FViaje.Eliminar_Viaje(unNac);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "El Viaje " + Convert.ToString(unNac.Numero) + " ha sido eliminado correctamente.";

            LimpioFormulario();
        }

        catch (Exception ex)
        {
            LblError.ForeColor = System.Drawing.Color.Red;
            LblError.Text = ex.Message;
        }
    }
    protected void BtnLimpiar_Click(object sender, EventArgs e)
    {
        Response.Redirect("ABMViajesNacionales.aspx", false);
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
        TBParadas.Text = "";
        TBParadas.Enabled = false;
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
        DDLMinutosArribo.Enabled = true;
        TBCantAsientos.Enabled = true;
        TBParadas.Enabled = true;
        BtnAlta.Enabled = false;
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
        DDLMinutosArribo.Enabled = true;
        TBCantAsientos.Enabled = true;
        TBParadas.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
        BtnLimpiar.Enabled = true;
    }

    protected void CalFechaPartida_SelectionChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        TBFechaPartida.Text = CalFechaPartida.SelectedDate.ToShortDateString();
        if (TBFechaArribo.Text != "")
        {
            VerificarFechas();
        }
    }


    protected void CalFechaArribo_SelectionChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        TBFechaArribo.Text = CalFechaArribo.SelectedDate.ToShortDateString();
        if (TBFechaPartida.Text != "")
        {
            VerificarFechas();
        }
    }

    protected void DDLHoraPartida_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        if (TBFechaPartida.Text != "" || TBFechaArribo.Text != "")
        {
            VerificarFechas();
        }
    }

    protected void DDLMinutosPartida_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        if (TBFechaPartida.Text != "" || TBFechaArribo.Text != "")
        {
            VerificarFechas();
        }
    }
    protected void DDLHoraArribo_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        if (TBFechaPartida.Text != "" || TBFechaArribo.Text != "")
        {
            VerificarFechas();
        }
    }
    protected void DDLMinutosArribo_SelectedIndexChanged(object sender, EventArgs e)
    {
        LblError.Text = "";
        if (TBFechaPartida.Text != "" || TBFechaArribo.Text != "")
        {
            VerificarFechas();
        }
    }

    private void VerificarFechas()
    {
        bool valido = false;
        LblError.Text = "";
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;

        try
        {
            int diapartida = Convert.ToDateTime(TBFechaPartida.Text).Day;
            int mespartida = Convert.ToDateTime(TBFechaPartida.Text).Month;
            int aniopartida = Convert.ToDateTime(TBFechaPartida.Text).Year;
            int horapartida = Convert.ToInt16(DDLHoraPartida.Text);
            int minutospartida = Convert.ToInt16(DDLMinutosPartida.Text);
            int diaarribo = Convert.ToDateTime(TBFechaArribo.Text).Day;
            int mesarribo = Convert.ToDateTime(TBFechaArribo.Text).Month;
            int anioarribo = Convert.ToDateTime(TBFechaArribo.Text).Year;
            int horaarribo = Convert.ToInt16(DDLHoraArribo.Text);
            int minutosarribo = Convert.ToInt16(DDLMinutosArribo.Text);
            DateTime fechapartida = new DateTime(aniopartida, mespartida, diapartida, horapartida, minutospartida, 0);
            DateTime fechaarribo = new DateTime(anioarribo, mesarribo, diaarribo, horaarribo, minutosarribo, 0);

            if (fechapartida < fechaarribo)
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
            if ((bool)Session["Encontrado"])
            {
                BtnModificar.Enabled = true;
            }
            else
            {
                BtnAlta.Enabled = true;
            }
        }
    }
}