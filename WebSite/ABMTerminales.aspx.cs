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
        }
    }

    protected void BtnBuscar_Click(object sender, EventArgs e)
    {
        if (TBCodigo.Text != "")
        {
            try
            {
                string _Codigo = Convert.ToString(TBCodigo.Text);

                ILogicaTerminales FTerminal = FabricaLogica.getLogicaTerminal();

                Terminales unaTer = FTerminal.Buscar_Terminal(_Codigo);

                if (unaTer == null)
                {
                    Session["Terminal"] = unaTer;
                    ActivoFormularioAlta();
                }

                else
                {
                    Session["Terminal"] = unaTer;

                    TBCiudad.Text = unaTer.Ciudad;
                    TBPais.Text = unaTer.Pais;

                    Session["Facilidades"] = unaTer.ListaFacilidades;

                    LBFacilidades.DataSource = unaTer.ListaFacilidades;
                    LBFacilidades.DataTextField = "Facilidad";
                    LBFacilidades.DataBind();

                    ActivoFormularioModificacion();
                    BtnModificar.Enabled = true;
                    BtnEliminar.Enabled = true;
                }
            }

            catch (Exception ex)
            {
                LblError.Text = ex.Message;
            }
        }
    }

    protected void BtnAgregar_Click(object sender, EventArgs e)
    {
        if (TBFacilidades.Text != "")
        {
            Facilidades _facilidad = new Facilidades(TBFacilidades.Text);
            bool encontrado = false;

            if (LBFacilidades.Items.Count == 0)
            {
                Session["Facilidades"] = new List<Facilidades>();
            }

            else
            {
                int posicion = 0;

                do
                    if (_facilidad.Facilidad == ((List<Facilidades>)Session["Facilidades"])[posicion].Facilidad)
                    {
                        encontrado = true;
                    }
                    else
                    {
                        posicion++;
                    }
                while ((!encontrado) && (posicion < ((List<Facilidades>)Session["Facilidades"]).Count()));
            }

            if (!encontrado)
            {
                ((List<Facilidades>)Session["Facilidades"]).Add(_facilidad);
                LBFacilidades.DataSource = (List<Facilidades>)Session["Facilidades"];
                LBFacilidades.DataTextField = "Facilidad";
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
            ((List<Facilidades>)Session["Facilidades"]).RemoveAt(LBFacilidades.SelectedIndex);
            LBFacilidades.DataSource = (List<Facilidades>)Session["Facilidades"];
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
            
            List<Facilidades> _Facilidades = new List<Facilidades>();
            foreach (string facilidad in (List<string>)Session["Facilidades"])
            {
                Facilidades _unaFacilidad = new Facilidades(facilidad);
                _Facilidades.Add(_unaFacilidad);
            }

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
        }
    }

    protected void BtnOk_Click(object sender, EventArgs e)
    {
        Response.Redirect("ABMTerminales.aspx", false);
    }

    protected void BtnModificar_Click(object sender, EventArgs e)
    {
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
        BtnModificar.Enabled = true;
        BtnEliminar.Enabled = true;
    }
}