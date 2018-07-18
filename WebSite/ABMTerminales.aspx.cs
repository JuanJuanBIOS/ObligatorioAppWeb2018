using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Logica.Interfaces;
using Logica;
using EntidadesCompartidas;

public partial class ABMTerminales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            TBCodigo.Focus();
            List<string> Facilidades = new List<string>();

            Session["Facilidades"] = Facilidades;
        }
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        try
        {
            string _Codigo = Convert.ToString(TBCodigo.Text);

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            Terminales unaTer = FTerminal.Buscar_Terminal(_Codigo);

            if (unaTer == null)
            {
                ActivoFormularioAlta();
            }

            else
            {
                TBCiudad.Text = unaTer.Ciudad;
                TBPais.Text = unaTer.Pais;

                //*****************************************************************************************************************
                //EN ESTE PUNTO SE TRANSFORMA LA LISTA DE OBJETOS FACILIDADES A UNA LISTA DE STRINGS PARA PODER PONERLO EN EL LISTBOX
                //CONSULTAR EN CLASE SI SE HACE DE ESTA MANERA O HAY QUE HACERLO DE OTRA
                List<string> Facilidades = new List<string>();
                Session["Facilidades"] = Facilidades;
                foreach (Facilidades facilidad in unaTer.ListaFacilidades)
                {
                    Facilidades.Add(facilidad.Facilidad);
                }
                LBFacilidades.DataSource = Facilidades;
                LBFacilidades.DataBind();
                //*****************************************************************************************************************
                TBCodigo.Enabled = false;
                BtnBuscar.Enabled = false;
                BtnModificar.Enabled = true;
                BtnEliminar.Enabled = true;
            }
        }

        catch (Exception ex)
        {
            LblError.Text = "";
            LblError.Text = "Error en la base de datos. Contacte con el administrador.";
        }
    }

    protected void BtnAgregar_Click(object sender, EventArgs e)
    {
        if (TBFacilidades.Text != "")
        {
            if (!((List<string>)Session["Facilidades"]).Contains(TBFacilidades.Text))
            {
                ((List<string>)Session["Facilidades"]).Add(TBFacilidades.Text);
                LBFacilidades.DataSource = (List<string>)Session["Facilidades"];
                LBFacilidades.DataBind();
            }
            TBFacilidades.Text = "";
            TBFacilidades.Focus();
        }
    }

    protected void BtnQuitar_Click(object sender, EventArgs e)
    {
        if (LBFacilidades.SelectedItem != null)
        {
            ((List<string>)Session["Facilidades"]).Remove(LBFacilidades.SelectedItem.ToString());
            LBFacilidades.DataSource = (List<string>)Session["Facilidades"];
            LBFacilidades.DataBind();
        }
        TBFacilidades.Focus();
    }

    protected void BtnAlta_Click(object sender, EventArgs e)
    {
        try
        {
            string _Codigo = Convert.ToString(TBCodigo.Text);
            string _Ciudad = Convert.ToString(TBCiudad.Text);
            string _Pais = Convert.ToString(TBPais.Text);
            //*****************************************************************************************************************
            //EN ESTE PUNTO SE TRANSFORMA LA LISTA DE STRINGS FACILIDADES A UNA LISTA DE OBJETOS PARA PODER CREAR LA TERMINAL
            //CONSULTAR EN CLASE SI SE HACE DE ESTA MANERA O HAY QUE HACERLO DE OTRA
            List<Facilidades> _Facilidades = new List<Facilidades>();
            foreach (string facilidad in (List<string>)Session["Facilidades"])
            {
                Facilidades _unaFacilidad = new Facilidades(facilidad);
                _Facilidades.Add(_unaFacilidad);
            }
            //*****************************************************************************************************************
            Terminales unaTer = new Terminales(_Codigo, _Ciudad, _Pais, _Facilidades);

            ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

            FTerminal.Alta_Terminal(unaTer);

            LblError.ForeColor = System.Drawing.Color.Blue;
            LblError.Text = "La Terminal ha sido ingresada a la base de datos correctamente.";

            BloqueoFormulario();
        }

        catch (Exception ex)
        {
            LblError.Text = ex.Message;
            BloqueoFormulario();
        }
    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect("ABMTerminales.aspx", false);
    }

    protected void BtnModificar_Click(object sender, EventArgs e)
    {
        ActivoFormularioModificacion();
    }

    protected void BtnLimpiar_Click(object sender, EventArgs e)
    {
        Response.Redirect("ABMTerminales.aspx", false);
    }

    private void BloqueoFormulario()
    {
        //ESTO NO SE SI SE HACE ASI, PREGUNTAR EN CLASE**********************************
        List<string> Facilidades = new List<string>();
        Session["Facilidades"] = Facilidades;
        //*******************************************************************************
        TBCodigo.Enabled = false;
        BtnBuscar.Enabled = false;
        BtnOk.Visible = true;
        TBCiudad.Enabled = false;
        TBPais.Enabled = false;
        TBFacilidades.Enabled = false;
        BtnAgregar.Enabled = false;
        LBFacilidades.Enabled = false;
        BtnQuitar.Enabled = false;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnConfirmarModificacion.Enabled = false;
        BtnEliminar.Enabled = false;
        BtnLimpiar.Enabled = false;
    }


    private void ActivoFormularioAlta()
    {
        TBCodigo.Text = TBCodigo.Text.ToUpper();
        //ESTO NO SE SI SE HACE ASI, PREGUNTAR EN CLASE**********************************
        List<string> Facilidades = new List<string>();
        Session["Facilidades"] = Facilidades;
        //*******************************************************************************
        TBCodigo.Enabled = false;
        BtnBuscar.Enabled = false;
        BtnOk.Visible = false;
        TBCiudad.Enabled = true;
        TBPais.Enabled = true;
        TBFacilidades.Enabled = true;
        BtnAgregar.Enabled = true;
        LBFacilidades.Enabled = true;
        BtnQuitar.Enabled = true;
        BtnAlta.Enabled = true;
        BtnModificar.Enabled = false;
        BtnConfirmarModificacion.Enabled = false;
        BtnEliminar.Enabled = false;
    }

    private void ActivoFormularioModificacion()
    {
        TBCodigo.Enabled = false;
        BtnBuscar.Enabled = false;
        BtnOk.Visible = false;
        TBCiudad.Enabled = true;
        TBPais.Enabled = true;
        TBFacilidades.Enabled = true;
        BtnAgregar.Enabled = true;
        LBFacilidades.Enabled = true;
        BtnQuitar.Enabled = true;
        BtnAlta.Enabled = false;
        BtnModificar.Enabled = false;
        BtnConfirmarModificacion.Enabled = true;
        BtnEliminar.Enabled = false;
    }
}